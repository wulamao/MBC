import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    width: 640
    height: 480

    title: qsTr("Monitor")

    Label {
        text: qsTr("You are on the Monitor page.")
        anchors.centerIn: parent
    }

    // Component.onCompleted: {
    //     console.log("Monitor in");
    // }

    // Component.onDestruction: {
    //     console.log("Monitor out");
    // }
}
