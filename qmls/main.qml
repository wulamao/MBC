import QtQuick 2.9
import QtQuick.Controls 2.2

import "../qmls/LogicFiles"
import "../qmls/UIFiles"

ApplicationWindow {
    id: window
    visible: true
    width: 1000
    height: 600
    title: qsTr("MBroadcast")

    property int index: 1

    Drawer {
        id: drawer
        width: parent.width * 0.4
        height: parent.height
        LogicConfiguration {
            id: configView
            anchors.fill: parent
            Component.onCompleted: {
                console.log("drawer in");
            }
            Component.onDestruction: {
                console.log("drawer out");
            }
            //
            btnSaveData.onClicked : {
                threadCollector.saveData(chatView.getData(),txtInputName.text)
            }

            btnScreenShot.onClicked: {
                chatView.saveImage(txtInputName.text)
                console.log("ScreenShot Clicked");
            }
            btnClear.onClicked: {
                chatView.clear()
            }
            chbDebug.onCheckStateChanged: {
            }
        }
    }

    LogicCharts {
        id: chatView
        anchors.fill: parent
        show: index === 1

        property var boom

        Component.onCompleted: {
            console.log("chatView in");
            threadCollector.newData.connect(onRecord)
        }
        Component.onDestruction: {
            console.log("chatView out");
        }

        function onRecord(args){
            boom = String(args)
            //console.log("args:"+String(args));
            chatView.isUpdate = true
        }

        Timer {
            id: timer
            interval: 1000;
            repeat: true
            running: true
            triggeredOnStart: false
            onTriggered: {
                var sampleTime = Number(configView.txtInputSample.text)
                if(sampleTime>100 || sampleTime<10000)
                    timer.interval = sampleTime
                chatView.updateChart(configView.chbDebug.checked,
                                     chatView.boom,
                                     parseInt(configView.txtInputMark.text))
            }
        }
    }

    LogicMonitor {
        id: monitorView
        //anchors.fill: parent
        show: index === 2
        Component.onCompleted: {
            console.log("monitorView in");
        }
        Component.onDestruction: {
            console.log("monitorView out");
        }
    }

    //QML receive signal from C++
    Connections {
        target: qmlKey
        onSKeyF1Press: {
            onSKeyF1Press();
        }
        onSKeyF2Press: {
            onSKeyF2Press();
        }
        onSKeyESCPress: {
            onSKeyESCPress();
        }
    }

    //C++ call QML
    function onSKeyF1Press(){
        console.log("onSKeyF1Press")
        if(index === 2) {
            index = 1
        }
    }
    function onSKeyF2Press(){
        console.log("onSKeyF2Press")
        if(index === 1) {
            index = 2
        }
    }
    function onSKeyESCPress(){
        console.log("onSKeyDESCPress")
        drawer.open()
    }
}
