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
    Q_INVOKABLE bool open(QString port);
    Q_INVOKABLE void close();
    Q_INVOKABLE void startRecord();
    Q_INVOKABLE void stopRecord();

signals:
    void sglFinished();
    void distReady(QString);


public slots:
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
};

#endif
