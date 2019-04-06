#include "datacollector.h"

#include <QTime>
#include <QEventLoop>
#include <QThread>

#include <QQueue>
//


void DataCollector::delay(unsigned long n)
{
    QThread::sleep(n);
}

DataCollector::DataCollector() {
    m_serial = new QSerialPort();
    m_q = new QQueue<QString>();
    m_qlist = new QStringList();
    m_timer = new QTimer();
    QObject::connect(m_serial, SIGNAL(readyRead()), this, SLOT(readData()));
    QObject::connect(m_timer, SIGNAL(timeout()), this, SLOT(sendData()));
    //
}
DataCollector::~DataCollector() {
    if(!m_serial) {
        delete  m_serial;
        m_serial = nullptr;
    }
}

bool DataCollector::open(QString port) {
    m_serial->setPortName("COM"+port);
    m_serial->setBaudRate(qint32(115200));
    m_serial->setDataBits(QSerialPort::Data8);
    m_serial->setStopBits(QSerialPort::OneStop);
    m_serial->setParity(QSerialPort::NoParity);
    m_serial->setFlowControl(QSerialPort::NoFlowControl);

    if(!m_serial->isOpen()) {
        if (m_serial->open(QIODevice::ReadWrite)) {
            qDebug("open successfully");
            return true;
        } else {
            qDebug("please check your port number!");
            return false;
        }
    } else {
        qDebug("This port is opened");
        return true;
    }
}

void DataCollector::close() {
    if (m_serial->isOpen()) {
        m_serial->close();
        m_timer->stop();
    }
}

void DataCollector::writeData(const QByteArray &data)
{
    m_serial->write(data);
}

void DataCollector::readData()
{
    if(m_serial->bytesAvailable()) {
        QByteArray data = m_serial->readAll();
        QString str = data;
        m_q->enqueue(str);
    }
}

/////////////////////////////////////////////////////////
/// \brief qlist
/////////////////////////////////////////////////////////


QString DataCollector::getLastData() {
    QString str = m_q->last();
    m_q->clear();
    return str;
}

void DataCollector::update(QString dist) {
    if(!m_q->isEmpty()) {
        QString value = m_q->last();
        m_qlist->append(dist+','+value);
        m_q->clear();
    }
}

void DataCollector::sendData() {
    if(!(m_qlist->isEmpty())) {
        emit newData(*m_qlist);
        //qDebug() << *m_qlist;
        m_qlist->clear();
    }
    QString threadText = QStringLiteral("@0x%1").arg(quintptr(QThread::currentThreadId()), 16, 16, QLatin1Char('0'));
    qDebug() << "collectorThread:" << threadText;
}

void DataCollector::startRecord() {
    m_timer->start(500);
}

void DataCollector::stopRecord() {
    m_timer->stop();
}

//
#include <QFile>
#include <QDateTime>
#include <QMessageBox>
#include <QDir>

void DataCollector::saveData(QString data,QString name) {
    QDateTime time = QDateTime::currentDateTime();
    QString str = time.toString("[yy-MM-dd_hh-mm-ss]");
    QString dir = QDir::currentPath();
    QFile file("../MBC/data/"+str+name+".txt");

    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << dir+":open file error";
        return;
    }

    file.write(data.toUtf8());
    file.close();
    qDebug() << "Data saved:" << "../MBC/data/"+str+name+".txt";
}

QStringList DataCollector::getSerInfo()
{
    QStringList m_slist;
    static const char blankString[] = QT_TRANSLATE_NOOP("SettingsDialog", "N/A");
    QString description;
    QString manufacturer;
    QString serialNumber;
    const auto infos = QSerialPortInfo::availablePorts();
    m_slist.clear();
    for (const QSerialPortInfo &info : infos) {
        description = info.description();
        manufacturer = info.manufacturer();
        serialNumber = info.serialNumber();
        m_slist << info.portName()
             << (!description.isEmpty() ? description : blankString);
    }
    qDebug() << m_slist;
    return m_slist;
    //emit getSerialPortNum(m_slist);
}
