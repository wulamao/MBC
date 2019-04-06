import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4

import QtWebEngine 1.4
import QtWebChannel 1.0

Page {
    width: 1000
    height: 600
    property alias textEdit: textEdit
    property alias someObject: someObject

    title: qsTr("Charts")
    id: eCharts

    QtObject {
        id: someObject
        // ID, under which this object will be known at WebEngineView side
        WebChannel.id: "backend"
        property string someProperty: "Break on through to the other side"
        signal someSignal(var arg)
        signal clearSignal
    }

    WebChannel {
        id: channel
        registeredObjects: [someObject]
    }

    Column {
        anchors.fill: parent
        Item {
            width: parent.width
            height: 450
            //            color: "#222222"
            WebEngineView {
                id: webEngineView
                anchors.fill: parent
                url: "../../htmls/echarts.html"
                webChannel: channel
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
                //ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                //ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                TextArea {
                    id: textEdit
                    padding: 5
                    anchors.fill: parent
                    color: "#45B659"
                    font.pointSize: 15
                    wrapMode: Text.WordWrap
                    readOnly: true
                    //text: qsTr("You are on the Charts page.")

                }
            }
        }
    }
}
