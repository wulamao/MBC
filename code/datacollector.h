#ifndef DATA_COLLECTOR_H
#define DATA_COLLECTOR_H
#include <QObject>
#include <QDebug>
#include <QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QtSerialPort/qserialport.h>
#include <QTimer>


QT_BEGIN_NAMESPACE

QT_END_NAMESPACE


class DataCollector : public QObject
{
    Q_OBJECT
public:
    DataCollector();
    ~DataCollector();

    void delay(unsigned long n);
    QString getLastData();

signals:
    void sglFinished();
    void newData(QStringList args);

public slots:
    bool open(QString port);
    void close();
    void update(QString);
    void writeData(const QByteArray &data);
    void readData();
    void sendData();
    // exposure this function to QML as well
    void startRecord();
    void stopRecord();
    QStringList getSerInfo();

    void test() {
//        while (1) {
//            delay(1);
//            //qDebug() << "Collector test";
//        }
    }
private:
    QSerialPort* m_serial = nullptr;
    QQueue<QString>* m_q = nullptr;
    QStringList* m_qlist = nullptr;
    QTimer* m_timer = nullptr;
};

#endif
