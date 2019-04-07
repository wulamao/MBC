import QtQuick 2.9
import QtQuick.Controls 2.2
import "../LogicFiles"

Page {
    width: 383
    height: 480

    property alias cmbDistance: cmbDistance
    property alias cmbCollector: cmbCollector
    property alias elmDist: elmDist
    property alias elmCltr: elmCltr
    property alias btnOK: btnOK
    property alias btnStart: btnStart
    property alias btnStop: btnStop
    property alias btnSaveData: btnSaveData
    property alias btnScreenShot: btnScreenShot
    property alias txtInputMark: txtInputMark
    property alias txtInputName: txtInputName
    property alias btnClear: btnClear
    property alias btnHelp: btnHelp
    property alias chbDebug: chbDebug
    property alias txtInputSample: txtInputSample

    title: qsTr("Configuration")
    ScrollView {
        visible: true
        anchors.fill: parent

        Column {
            spacing: 0
            anchors.fill: parent
            Rectangle {
                id: tips
                color: "#dddddd"
                width: parent.width
                height: 30

                Text {
                    anchors.centerIn: parent
                    color: "#123456"
                    text: qsTr("Configuration")
                }
            }
            Rectangle {
                id: colorBar
                width: parent.width
                height: 5
                color: "#123456"
            }

            Grid {
                rows: 2
                columns: 3

                width: parent.width
                height: 100
                rowSpacing: 5
                columnSpacing: 13
                topPadding: 10

                flow: Grid.TopToBottom

                Label {
                    id: label2
                    text: qsTr("Distance")
                    leftPadding: 15
                    topPadding: 12

                    width: parent.width / 5
                    height: 40
                    font.pointSize: 9
                }
                Label {
                    id: label3
                    text: qsTr("Collector")
                    leftPadding: 15
                    topPadding: 12
                    width: parent.width / 5
                    height: 40
                    font.pointSize: 9
                }
                ComboBox {
                    id: cmbDistance
                    model: 20
                }
                ComboBox {
                    id: cmbCollector
                    model: 20
                }
                Switch {
                    id: elmDist
                }
                Switch {
                    id: elmCltr
                }
            }

            Grid {
                rows: 2
                columns: 3
                width: parent.width
                height: 100
                leftPadding: 10
                rowSpacing: 5
                columnSpacing: 15
                flow: Grid.TopToBottom
                CheckBox {
                    id: chbDebug
                    text: qsTr("DebugMode")
                }
                CheckBox {
                    id: checkBox2
                    text: qsTr("SomeMode")
                }
                CheckBox {
                    id: checkBox3
                    text: qsTr("AddRTC")
                }
                CheckBox {
                    id: checkBox
                    text: qsTr("AddLine")
                }

                CheckBox {
                    id: checkBox4
                    text: qsTr("State1")
                }

                CheckBox {
                    id: checkBox5
                    text: qsTr("State2")
                }
            }

            Grid {
                rows: 2
                columns: 4
                width: parent.width
                leftPadding: 25
                height: 60
                rowSpacing: 5
                columnSpacing: 15

                flow: Grid.TopToBottom
                Label {
                    id: label1
                    width: parent.width / 6
                    topPadding: 3
                    height: 25
                    text: qsTr("Mark")
                }

                Label {
                    id: label
                    width: parent.width / 6
                    topPadding: 3
                    height: 25
                    text: qsTr("Name")
                }

                TextInput {
                    id: txtInputMark
                    width: parent.width / 5
                    topPadding: 3
                    height: 25
                    color: "#615a5a"
                    text: qsTr("0")
                    font.pixelSize: 12
                }

                TextInput {
                    id: txtInputName
                    width: parent.width / 5
                    topPadding: 3
                    height: 25
                    color: "#615a5a"
                    text: qsTr("filename")
                    font.pixelSize: 12
                }

                Label {
                    id: labelSample
                    width: parent.width / 6
                    height: 25
                    text: qsTr("Sample(ms)")
                    topPadding: 3
                }

                Label {
                    id: label5
                    width: parent.width / 6
                    height: 25
                    text: qsTr("None")
                    topPadding: 3
                }

                TextInput {
                    id: txtInputSample
                    width: parent.width / 7
                    height: 25
                    color: "#615a5a"
                    text: qsTr("1000")
                    topPadding: 3
                    font.pixelSize: 12
                }

                TextInput {
                    id: txtInputName1
                    width: parent.width / 5
                    height: 25
                    color: "#615a5a"
                    text: qsTr("^_^")
                    topPadding: 3
                    font.pixelSize: 12
                }
            }

            Grid {
                rows: 3
                columns: 3
                leftPadding: 20
                width: parent.width
                height: 140
                rowSpacing: 5
                columnSpacing: 5
                Button {
                    id: btnOK
                    text: qsTr("OK")
                }

                Button {
                    id: btnStart
                    text: qsTr("RecordStart")
                }

                Button {
                    id: btnStop
                    text: "RecordStop"
                }

                Button {
                    id: btnClear
                    text: qsTr("Clear")
                }

                Button {
                    id: button4
                    text: qsTr("Expert")
                }

                Button {
                    id: button5
                    text: qsTr("Import")
                }
                Button {
                    id: btnHelp
                    text: qsTr("Help")
                    autoRepeat: false
                    highlighted: true
                    flat: true
                }
                Button {
                    id: btnSaveData
                    text: qsTr("SaveData")
                }
                Button {
                    id: btnScreenShot
                    text: qsTr("ScreenShot")
                }
            }
            Rectangle {
                id: tips1
                color: "#dddddd"
                width: parent.width
                height: 300

                Text {
                    width: 344
                    height: 120
                    color: "#000000"
                    text: qsTr("You got me, wow! ^_^

There are some tips for you guys:
tip No.1, key Esc can call or exit this page,
tip No.2, key F1 can open a page,
tip No.3, key F2 can open a page too!
Have fun! via W.")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                }
            }
        }
    }

    // Component.onCompleted: {
    //     console.log("Configuration in");
    // }

    // Component.onDestruction: {
    //     console.log("Configuration out");
    // }
}
