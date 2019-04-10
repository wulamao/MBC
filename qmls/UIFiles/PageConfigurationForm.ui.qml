import QtQuick 2.9
import QtQuick.Controls 2.2
import "../LogicFiles"

Page {
    id: configForm
    width: 600
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
    property alias btnImport: btnImport
    property alias btnExpert: btnExpert
    property alias textMemo: textMemo

    title: qsTr("Configuration")
    ScrollView {
        anchors.fill: parent
        visible: true

        Column {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                id: tips
                color: "#dddddd"
                width: configForm.width
                height: 30

                Text {
                    anchors.centerIn: parent
                    color: "#123456"
                    text: qsTr("Configuration")
                }
            }
            Rectangle {
                id: colorBar
                width: configForm.width
                height: 5
                color: "#123456"
            }

            Grid {
                rows: 2
                columns: 3

                width: configForm.width
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

                    width: configForm.width / 4
                    height: 40
                    font.pointSize: 9
                }
                Label {
                    id: label3
                    text: qsTr("Collector")
                    leftPadding: 15
                    topPadding: 12
                    width: configForm.width / 4
                    height: 40
                    font.pointSize: 9
                }
                ComboBox {
                    id: cmbDistance
                    width: configForm.width / 4
                    model: 20
                }
                ComboBox {
                    id: cmbCollector
                    width: configForm.width / 4
                    model: 20
                }
                Switch {
                    id: elmDist
                    width: configForm.width / 4
                }
                Switch {
                    id: elmCltr
                    width: configForm.width / 4
                }
            }

            Grid {
                rows: 2
                columns: 3
                width: configForm.width
                height: 100
                leftPadding: 10
                rowSpacing: 5
                columnSpacing: 15
                flow: Grid.TopToBottom
                CheckBox {
                    id: chbDebug
                    width: configForm.width / 4
                    text: qsTr("DebugMode")
                }
                CheckBox {
                    id: checkBox2
                    width: configForm.width / 4
                    text: qsTr("SomeMode")
                }
                CheckBox {
                    id: checkBox3
                    width: configForm.width / 4
                    text: qsTr("AddRTC")
                }
                CheckBox {
                    id: checkBox
                    width: configForm.width / 4
                    text: qsTr("AddLine")
                }

                CheckBox {
                    id: checkBox4
                    width: configForm.width / 4
                    text: qsTr("State1")
                }

                CheckBox {
                    id: checkBox5
                    width: configForm.width / 4
                    text: qsTr("State2")
                }
            }

            Grid {
                rows: 2
                columns: 4
                width: configForm.width
                leftPadding: 25
                height: 60
                rowSpacing: 5
                columnSpacing: 15

                flow: Grid.TopToBottom
                Label {
                    id: label1
                    width: configForm.width / 6
                    topPadding: 3
                    height: 25
                    text: qsTr("Mark")
                }

                Label {
                    id: label
                    width: configForm.width / 6
                    topPadding: 3
                    height: 25
                    text: qsTr("Name")
                }

                TextInput {
                    id: txtInputMark
                    width: configForm.width / 5
                    topPadding: 3
                    height: 25
                    color: "#615a5a"
                    text: qsTr("0")
                    font.pixelSize: 12
                }

                TextInput {
                    id: txtInputName
                    width: configForm.width / 5
                    topPadding: 3
                    height: 25
                    color: "#615a5a"
                    text: qsTr("filename")
                    font.pixelSize: 12
                }

                Label {
                    id: labelSample
                    width: configForm.width / 6
                    height: 25
                    text: qsTr("Sample(ms)")
                    topPadding: 3
                }

                Label {
                    id: label5
                    width: configForm.width / 6
                    height: 25
                    text: qsTr("None")
                    topPadding: 3
                }

                TextInput {
                    id: txtInputSample
                    width: configForm.width / 7
                    height: 25
                    color: "#615a5a"
                    text: qsTr("1000")
                    topPadding: 3
                    font.pixelSize: 12
                }

                TextInput {
                    id: txtInputName1
                    width: configForm.width / 5
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
                width: configForm.width
                height: 140
                rowSpacing: 5
                columnSpacing: 5
                Button {
                    id: btnOK
                    width: configForm.width / 4
                    text: qsTr("OK")
                }

                Button {
                    id: btnStart
                    width: configForm.width / 4
                    text: qsTr("RecordStart")
                }

                Button {
                    id: btnStop
                    width: configForm.width / 4
                    text: "RecordStop"
                }

                Button {
                    id: btnClear
                    width: configForm.width / 4
                    text: qsTr("Clear")
                }

                Button {
                    id: btnExpert
                    width: configForm.width / 4
                    text: qsTr("Expert")
                }

                Button {
                    id: btnImport
                    width: configForm.width / 4
                    text: qsTr("Import")
                }
                Button {
                    id: btnHelp
                    width: configForm.width / 4
                    text: qsTr("Help")
                    autoRepeat: false
                    highlighted: true
                    flat: true
                }
                Button {
                    id: btnSaveData
                    width: configForm.width / 4
                    text: qsTr("SaveData")
                }
                Button {
                    id: btnScreenShot
                    width: configForm.width / 4
                    text: qsTr("ScreenShot")
                }
            }
            Rectangle {
                id: tips1
                color: "#dddddd"
                width: configForm.width
                height: 300

                Text {
                    width: configForm.with - 40
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

                TextEdit {
                    id: textMemo
                    width: configForm.with - 40
                    height: 139
                    text: "MemoZy"
                    font.pixelSize: 12
                    leftPadding: 10
                    topPadding: 10
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
