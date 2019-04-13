#include "fileio.h"

FileIO::FileIO(QObject *parent)
    : QObject(parent)
{
}

FileIO::~FileIO()
{
    emit sglFinished();
}


void FileIO::read()
{
    if(m_source.isEmpty()) {
        return;
    }
    QFile file(m_source.toLocalFile());
    if(!file.exists()) {
        qWarning() << "Does not exits: " << m_source.toLocalFile();
        return;
    }
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        m_text = stream.readAll();
        emit textChanged(m_text);
    }
}

void FileIO::write()
{
    if(m_source.isEmpty()) {
        return;
    }
    QFile file(m_source.toLocalFile());
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << m_text;
    }
    QString threadText = QStringLiteral("@0x%1").arg(quintptr(QThread::currentThreadId()), 16, 16, QLatin1Char('0'));
    qDebug() << "ioThread:" << threadText;
}

QUrl FileIO::source() const
{
    return m_source;
}

QString FileIO::text() const
{
    return m_text;
}

void FileIO::setSource(QUrl source)
{
    if (m_source == source)
        return;

    m_source = source;
    emit sourceChanged(source);
}

void FileIO::setText(QString text)
{
    if (m_text == text)
        return;

    m_text = text;
    emit textChanged(text);
}

void FileIO::savefile(QString dir, QString text) {
    m_source = dir;
    m_text = text;
    write();
}

void FileIO::openfile(QString dir) {
    QStringList sections = dir.split(QRegExp("[,]"));
    for (QStringList::iterator it = sections.begin(); it != sections.end(); ++it)
    {
        qDebug() << *it;
        m_source = *it;
        read();
    }
}

#include <QPixmap>
void FileIO::base64ToImage(QString base64,QString savePath)
{
    QByteArray Ret_bytearray;
    //qDebug() <<"base64 :" << base64 ;
    Ret_bytearray = QByteArray::fromBase64(base64.toLatin1());
    QBuffer buffer(&Ret_bytearray);
    buffer.open(QIODevice::WriteOnly);
    QPixmap imageresult;
    imageresult.loadFromData(Ret_bytearray);
    if(savePath != "")
    {
        qDebug() <<"saved :" +savePath<<imageresult.save(savePath);

    }
}

//
#include <QFile>
#include <QDateTime>
#include <QMessageBox>
#include <QDir>

void FileIO::saveData(QString data,QString savePath) {
    QFile file(savePath);

    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << QString(savePath+":open file error");
        return;
    }

    file.write(data.toUtf8());
    file.close();
    qDebug() << "Data saved:" << savePath;
}
