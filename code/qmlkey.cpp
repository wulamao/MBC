#include "qmlKey.h"


bool QmlKey::eventFilter(QObject *watched, QEvent *event)
{
    if (event->type() == QEvent::KeyPress)
    {
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        if (keyEvent->key() == Qt::Key_F1)
        {
            emit sKeyF1Press();
            return(true);
        }
        if (keyEvent->key() == Qt::Key_F2)
        {
            emit sKeyF2Press();
            return(true);
        }
        if (keyEvent->key() == Qt::Key_Escape)
        {
            emit sKeyESCPress();
            return(true);
        }
    }
    if (event->type() == QEvent::KeyRelease)
    {
    }

    return QObject::eventFilter(watched, event);
}
