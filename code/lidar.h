#ifndef LIDAR_H
#define LIDAR_H

#include <QObject>
#include <QDebug>
#include <QTimer>
#include <QMutex>
#include "rplidar.h"

QT_BEGIN_NAMESPACE
using namespace rp::standalone::rplidar;
QT_END_NAMESPACE

class Lidar : public QObject
{
    Q_OBJECT
public:
    Lidar();
    virtual ~Lidar();

    void delay(unsigned long n);
    // Q_INVOKABLE exposure this function to QML


signals:
    void sglFinished();
    void distReady(QString);


public slots:
    bool open(QString port);
    void close();
    void startRecord();
    void stopRecord();
    void testSlot();
    bool capture();
    void triggerTest();
    void test() {
        //while (1)
        {
            delay(2);
            //qDebug() << "Lidar test";
        }
    }

private:
    RPlidarDriver* m_drv=nullptr;
    QTimer* m_timer=nullptr;
    QMutex qMutex;
    bool m_initFlag=false;
};

#endif
