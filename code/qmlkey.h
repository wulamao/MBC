#pragma once
#include <QObject>
#include <QEvent>
#include <QKeyEvent>

class QmlKey : public QObject
{
    Q_OBJECT
public:
    QmlKey() {}
    ~QmlKey() {}


protected:
    virtual bool eventFilter(QObject *watched, QEvent *event);

signals:
    void sKeyBackPress();
    void sKeyF1Press();
    void sKeyF2Press();
    void sKeyESCPress();
    void sKeyBackRelease();
};
