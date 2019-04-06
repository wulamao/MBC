#include "lidar.h"
#include "string.h"

#include <QTime>
#include <QEventLoop>
#include <QThread>


//
bool open();
void close();

void Lidar::testSlot() {
    emit distReady(QString::number(0.1));
}

Lidar::Lidar() {
    m_timer = new QTimer();
    m_drv = RPlidarDriver::CreateDriver(DRIVER_TYPE_SERIALPORT);
    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(triggerTest()));
    //QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(testSlot()));

}
Lidar::~Lidar() {
    close();
}

void Lidar::delay(unsigned long n)
{
    QThread::sleep(n);
}

bool Lidar::open(QString port) {
    char str_port[20] = "\\\\.\\com";
    _u32         opt_com_baudrate = 115200;
    u_result     op_result;

    if(!m_drv) {
        m_drv = RPlidarDriver::CreateDriver(DRIVER_TYPE_SERIALPORT);
        if (!m_drv) return false;
    }
    rplidar_response_device_health_t healthinfo;
    rplidar_response_device_info_t devinfo;

    QByteArray qba = port.toLatin1();
    strcat(str_port,qba.data());

    do {
        // try to connect
        if (IS_FAIL(m_drv->connect(str_port, opt_com_baudrate))) {
            qDebug("Error, cannot bind to the specified serial port %s.\n"
                , str_port);
            return false;
        }

        // retrieving the device info
        ////////////////////////////////////////
        op_result = m_drv->getDeviceInfo(devinfo);

        if (IS_FAIL(op_result)) {
            if (op_result == RESULT_OPERATION_TIMEOUT) {
                // you can check the detailed failure reason
                qDebug("Error, operation time out.\n");
            } else {
                qDebug("Error, unexpected error, code: %x\n", op_result);
                // other unexpected result
            }
            goto err;
        }

        // check the device health
        ////////////////////////////////////////
        op_result = m_drv->getHealth(healthinfo);
        if (IS_OK(op_result)) { // the macro IS_OK is the preperred way to judge whether the operation is succeed.
//            qDebug("RPLidar health status : ");
            switch (healthinfo.status) {
            case RPLIDAR_STATUS_OK:
//                qDebug("OK.");
                break;
            case RPLIDAR_STATUS_WARNING:
                qDebug("Warning.");
                break;
            case RPLIDAR_STATUS_ERROR:
                qDebug("Error.");
                qDebug(" (errorcode: %d)\n", healthinfo.error_code);
                break;
            }
        } else {
            qDebug("Error, cannot retrieve the lidar health code: %x\n", op_result);
            goto err;
        }

        if (healthinfo.status == RPLIDAR_STATUS_ERROR) {
            qDebug("Error, rplidar internal error detected. Please reboot the device to retry.\n");
            // enable the following code if you want rplidar to be reboot by software
            m_drv->reset();
            //goto err;
        }

        m_drv->startMotor();
        // take only one 360 deg scan and display the result as a histogram
        ////////////////////////////////////////////////////////////////////////////////
        if (IS_FAIL(m_drv->startScan( 0,1 ))) // you can force rplidar to perform scan operation regardless whether the motor is rotating
        {
            qDebug("Error, cannot start the scan operation.\n");
//            m_drv->stopMotor();
            goto err;
        }
    } while(0);

    m_initFlag = true;
    return true;

err:
    close();

    return false;
}

void Lidar::close() {
    if(m_drv) {
        m_drv->stop();
        m_drv->stopMotor();
        m_drv->disconnect();
        RPlidarDriver::DisposeDriver(m_drv);
        m_drv = nullptr;
        m_timer->stop();
        m_initFlag = false;
    }
}

//
float dataFilter(float pData[], int nSize)
{
    float max,min;
    float sum;

    if(nSize>2) {
        max = pData[0];
        min = max;
        sum = 0;
        for(int i=0;i<nSize;i++) {
            sum += float(pData[i]);
            if(float(pData[i])>max) {
                max = float(pData[i]);
            } else if(float(pData[i])<min) {
                min = float(pData[i]);
            }
        }
        sum = sum-max-min;
        return sum/(nSize-2);
    } else {
        return pData[0];
    }
}


void Lidar::triggerTest() {
    qMutex.lock();
    if(m_initFlag)
        capture();
    qMutex.unlock();
}
//
bool Lidar::capture()
{
    u_result ans;
    rplidar_response_measurement_node_t nodes[8192];
    float dist[8192];
    size_t   count = _countof(nodes);
    if(m_drv==nullptr) return false;

    if(1)
    {
        ans = m_drv->grabScanData(nodes, count);
        if (IS_OK(ans) || ans == RESULT_OPERATION_TIMEOUT) {
            m_drv->grabScanData(nodes, count);
            unsigned int dist_count=0;
            for (int pos = 0; pos < (int)count ; ++pos) {
                float angular = (nodes[pos].angle_q6_checkbit >> RPLIDAR_RESP_MEASUREMENT_ANGLE_SHIFT)/64.0f;
                // 4° - 4m - 28cm
                bool a = (angular >= 358.0f);
                bool b = (angular <= 2.0f);
                if( a || b) {
                    float data = nodes[pos].distance_q2/4.0f;
                    if(data > 10) {
                        dist[dist_count] = data;
                        dist_count++;
                        //qDebug() << dist_count << " " << angular <<" :" << dist[dist_count];
                    }
                }
            }
            if(ans == RESULT_OPERATION_TIMEOUT) {
                 qDebug() << "TIME OUT!!!";
                 m_drv->reset();
            }

            float resualt = dataFilter(dist, dist_count);

            emit distReady(QString::number(double(resualt/1000)));

        } else {
            qDebug("error code: %x\n", ans);
            return false;
        }
    }

    QString threadText = QStringLiteral("@0x%1").arg(quintptr(QThread::currentThreadId()), 16, 16, QLatin1Char('0'));
    qDebug() << "lidarThread:" << threadText;

    return true;
}


void Lidar::startRecord() {
    m_timer->start(200);
}

void Lidar::stopRecord() {
    m_timer->stop();
}
