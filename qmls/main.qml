import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1
//import org.example.io 1.0

import "../qmls/LogicFiles"
import "../qmls/UIFiles"

ApplicationWindow {
    id: window

    visible: true
    width: 1000
    height: 640
    title: qsTr("MBroadcast")

    property int index: 1

    footer: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }
    }

    Drawer {
        id: drawer
        width: parent.width * 0.4
        height: parent.height

        LogicConfiguration {
            id: configView
            objectName: "configView"

            anchors.fill: parent

            signal saveDataSignal(string content, string name)

            FileDialog {
                id: openDialog
                objectName: "openDialog"
                nameFilters: ["data file (*.txt *.csv)","All files (*)"]
                fileMode: FileDialog.OpenFiles
                signal importSignal(string dir)
                onAccepted: {
                    importSignal(openDialog.files)
                }
            }
            FileDialog {
                id: saveDialog
                objectName: "saveDialog"
                signal expertSignal(string dir,string content)
                fileMode: FileDialog.SaveFile
                onAccepted: {
                    expertSignal(saveDialog.file, chatView.getText())
                }
            }

            Component.onCompleted: {
                console.log("drawer in");
                io.textChanged.connect(chatView.readFile)
            }
            Component.onDestruction: {
                console.log("drawer out");
            }
            //
            btnSaveData.onClicked : {
                var time = Qt.formatDateTime(new Date(), "[yyyy-MM-dd][hh-mm-ss]")
                var savePath = "../MBC/data/"+time+txtInputName.text+".txt"
                saveDataSignal(chatView.getData(),savePath)
            }

            btnScreenShot.onClicked: {
                chatView.saveImage(txtInputName.text)
                console.log("ScreenShot Clicked");
            }
            btnClear.onClicked: {
                chatView.clear()
            }
            btnHelp.onClicked: {
                chatView.addInfoData(threadCollector.getSerInfo())
            }
            btnImport.onClicked: {
                openDialog.open()
            }
            btnExpert.onClicked: {
                saveDialog.open()
            }
            chbDebug.onCheckStateChanged: {
            }
            txtInputSample.onTextChanged: {
                var sampleTime = Number(configView.txtInputSample.text)
                if(sampleTime>=500 || sampleTime<=10000) {
                    timer.stop()
                    timer.interval = sampleTime
                    timer.start()
                } else {
                    console.log("illegal time")
                }
            }
        }
    }

    LogicCharts {
        id: chatView
        objectName: "chatView"
        anchors.fill: parent
        show: index === 1
        //receive data from back end
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
            setUpdate()
        }

        Timer {
            id: timer
            interval: 1000;
            repeat: true
            running: true
            triggeredOnStart: false
            onTriggered: {
                if(configView.txtInputMark.text !== '') {
                        chatView.updateChart(configView.chbDebug.checked,
                                             chatView.boom,
                                             configView.txtInputMark.text)
                                             //parseInt(configView.txtInputMark.text))
                }
            }
        }
    }

    LogicMonitor {
        id: monitorView
        anchors.fill: parent
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
        monitorView.canvas.requestPaint();
    }
    function onSKeyESCPress(){
        console.log("onSKeyDESCPress")
        drawer.open()
    }
}
