#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "./code/datacollector.h"
#include "./code/lidar.h"
#include "./code/qmlkey.h"

#include <QThread>
#include <QtWebEngine>
#include <QString>

const QString logFilePath = "./debug.log";
bool logToFile = false;

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QHash<QtMsgType, QString> msgLevelHash({{QtDebugMsg, "Debug"}, {QtInfoMsg, "Info"}, {QtWarningMsg, "Warning"}, {QtCriticalMsg, "Critical"}, {QtFatalMsg, "Fatal"}});
    QByteArray localMsg = msg.toLocal8Bit();
    QTime time = QTime::currentTime();
    QString formattedTime = time.toString("hh:mm:ss.zzz");
    QByteArray formattedTimeMsg = formattedTime.toLocal8Bit();
    QString logLevelName = msgLevelHash[type];
    QByteArray logLevelMsg = logLevelName.toLocal8Bit();

    if (logToFile) {
        QString txt = QString("%1 %2: %3 (%4)").arg(formattedTime, logLevelName, msg, context.file);
        QFile outFile(logFilePath);
        outFile.open(QIODevice::WriteOnly | QIODevice::Append);
        QTextStream ts(&outFile);
        ts << txt << endl;
        outFile.close();
    } else {
        fprintf(stderr, "%s %s: %s (%s:%u, %s)\n", formattedTimeMsg.constData(), logLevelMsg.constData(), localMsg.constData(), context.file, context.line, context.function);
        fflush(stderr);
    }

    if (type == QtFatalMsg)
        abort();
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // thread create
    DataCollector* threadCollector = new DataCollector();
    Lidar* threadLidar = new Lidar();
    QThread thread1,thread2;
    threadCollector->moveToThread(&thread1);
    threadLidar->moveToThread(&thread2);

    // thread quit
    // AutoConnection default exec in the same thread
    // DirectConnection exec in the thread which emit this signal
    // QueuedConnection exec in different threads
    QObject::connect(&thread1, SIGNAL(started()), threadCollector, SLOT(test()));
    QObject::connect(threadCollector, SIGNAL(sglFinished()), &thread1, SLOT(quit()));
    QObject::connect(&thread1, SIGNAL(finished()), &thread1, SLOT(deleteLater()));
    QObject::connect(&thread2, SIGNAL(started()), threadLidar, SLOT(test()));
    QObject::connect(threadLidar, SIGNAL(sglFinished()), &thread2, SLOT(quit()));
    QObject::connect(&thread2, SIGNAL(finished()), &thread2, SLOT(deleteLater()));
    thread1.start();
    thread2.start();

    //
    QtWebEngine::initialize();

    //
    app.setOrganizationName("BJFU");
    app.setOrganizationDomain("12-4A.com");
    app.setApplicationName("MBC Software");

    // load qml
    QQmlApplicationEngine engine;
    // before load qml
    QmlKey qmlKey;
    engine.rootContext()->setContextProperty("threadLidar", threadLidar);
    engine.rootContext()->setContextProperty("threadCollector", threadCollector);
    engine.rootContext()->setContextProperty("qmlKey", &qmlKey);
    engine.load(QUrl(QStringLiteral("../MBC/qmls/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    // after load qml
    QObject *root = engine.rootObjects()[0];
    root->installEventFilter(&qmlKey);
    // log
//    qInstallMessageHandler(myMessageOutput);
    //
    QObject::connect(threadLidar, SIGNAL(distReady(QString)), threadCollector, SLOT(update(QString)));

    QString threadText = QStringLiteral("@0x%1").arg(quintptr(QThread::currentThreadId()), 16, 16, QLatin1Char('0'));
    //qDebug() << "mainThread:" << threadText;

    return app.exec();
}
