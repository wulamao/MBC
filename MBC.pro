QT += quick
QT += qml webengine webchannel serialport widgets

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    code/datacollector.cpp \
    code/lidar.cpp \
    code/qmlkey.cpp

HEADERS += \
    sdk/include/rplidar.h \
    sdk/include/rplidar_cmd.h \
    sdk/include/rplidar_driver.h \
    sdk/include/rplidar_protocol.h \
    sdk/include/rptypes.h \
    sdk/src/arch/win32/arch_win32.h \
    sdk/src/arch/win32/net_serial.h \
    sdk/src/arch/win32/timer.h \
    sdk/src/arch/win32/winthread.hpp \
    sdk/src/hal/abs_rxtx.h \
    sdk/src/hal/assert.h \
    sdk/src/hal/byteops.h \
    sdk/src/hal/event.h \
    sdk/src/hal/locker.h \
    sdk/src/hal/socket.h \
    sdk/src/hal/thread.h \
    sdk/src/hal/types.h \
    sdk/src/hal/util.h \
    sdk/src/rplidar_driver_impl.h \
    sdk/src/rplidar_driver_serial.h \
    sdk/src/rplidar_driver_TCP.h \
    sdk/src/sdkcommon.h \
    sdk/include/rplidar.h \
    sdk/include/rplidar_cmd.h \
    sdk/include/rplidar_driver.h \
    sdk/include/rplidar_protocol.h \
    sdk/include/rptypes.h \
    sdk/src/arch/win32/arch_win32.h \
    sdk/src/arch/win32/net_serial.h \
    sdk/src/arch/win32/timer.h \
    sdk/src/arch/win32/winthread.hpp \
    sdk/src/hal/abs_rxtx.h \
    sdk/src/hal/assert.h \
    sdk/src/hal/byteops.h \
    sdk/src/hal/event.h \
    sdk/src/hal/locker.h \
    sdk/src/hal/socket.h \
    sdk/src/hal/thread.h \
    sdk/src/hal/types.h \
    sdk/src/hal/util.h \
    sdk/src/rplidar_driver_impl.h \
    sdk/src/rplidar_driver_serial.h \
    sdk/src/rplidar_driver_TCP.h \
    sdk/src/sdkcommon.h \
    sdk/include/rplidar.h \
    sdk/include/rplidar_cmd.h \
    sdk/include/rplidar_driver.h \
    sdk/include/rplidar_protocol.h \
    sdk/include/rptypes.h \
    sdk/src/arch/win32/arch_win32.h \
    sdk/src/arch/win32/net_serial.h \
    sdk/src/arch/win32/timer.h \
    sdk/src/arch/win32/winthread.hpp \
    sdk/src/hal/abs_rxtx.h \
    sdk/src/hal/assert.h \
    sdk/src/hal/byteops.h \
    sdk/src/hal/event.h \
    sdk/src/hal/locker.h \
    sdk/src/hal/socket.h \
    sdk/src/hal/thread.h \
    sdk/src/hal/types.h \
    sdk/src/hal/util.h \
    sdk/src/rplidar_driver_impl.h \
    sdk/src/rplidar_driver_serial.h \
    sdk/src/rplidar_driver_TCP.h \
    sdk/src/sdkcommon.h \
    code/datacollector.h \
    code/lidar.h \
    code/qmlkey.h

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Icon
RC_ICONS = $$PWD/figure/title.ico

# Lidar library
win32: LIBS += -L$$PWD/./libs/ -lrplidar_driver

INCLUDEPATH +=  $$PWD/.  \
                $$PWD/sdk/include/. \
                $$PWD/sdk/src/.\
                $$PWD/sdk/src/hal/. \
                $$PWD/sdk/src/arch/win32/.\


DEPENDPATH +=   $$PWD/.  \
                $$PWD/sdk/include/. \
                $$PWD/sdk/src/.\
                $$PWD/sdk/src/hal/. \
                $$PWD/sdk/src/arch/win32/.\

win32:!win32-g++: PRE_TARGETDEPS += $$PWD/./libs/rplidar_driver.lib
else:win32-g++: PRE_TARGETDEPS += $$PWD/./libs/librplidar_driver.a

DISTFILES += \
    js/echarts-gl.min.js \
    js/echarts.min.js \
    js/jquery-3.3.1.min.js \
    js/qwebchannel.js \
    js/vue.min.js \
    qmls/UIFiles/PageChartsForm.ui.qml \
    qmls/UIFiles/PageConfigurationForm.ui.qml \
    qmls/UIFiles/PageMonitorForm.ui.qml \
    ReadMe.txt \
    qmls/main.qml \
    qmls/LogicFiles/LogicCharts.qml \
    htmls/echarts.html \
    qmls/LogicFiles/AnimationItem.qml \
    qmls/LogicFiles/LogicMonitor.qml \
    qmls/LogicFiles/LogicConfiguration.qml
