import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import QtWebEngine 1.4
import QtWebChannel 1.0

Page {
    width: 1000
    height: 600
    property alias textEdit: textEdit
    property alias webEngineView: webEngineView

    title: qsTr("Charts")
    id: eCharts



    Column {
        anchors.fill: parent
        Item {
            width: parent.width
            height: 450
            //            color: "#222222"
            WebEngineView {
                id: webEngineView
                anchors.fill: parent
            }
        }

        Rectangle {
            width: parent.width
            height: 150
            color: "#222222"
            ScrollView {
                id: scrollView
                anchors.fill: parent
                clip: true

                TextArea {
                    id: textEdit
                    padding: 5
                    anchors.fill: parent
                    color: "#45B659"
                    font.pointSize: 15
                    wrapMode: Text.NoWrap
                    readOnly: true
                    //text: qsTr("You are on the Charts page.")

                }
            }
        }
    }
}
