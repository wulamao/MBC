import QtQuick 2.9
import QtQuick.Controls 2.2
import Qt.labs.settings 1.0
import "../UIFiles"

PageConfigurationForm {
    id: root

    property bool openedDist: false
    property bool openedCltr: false

    Settings {
        id: settings
        property int cmbDist: 0
        property int cmbCltr: 0
    }

    Component.onCompleted: {
        cmbCollector.currentIndex = settings.cmbCltr
        cmbDistance.currentIndex = settings.cmbDist
    }
    Component.onDestruction: {
        settings.cmbDist = cmbDistance.currentIndex
        settings.cmbCltr = cmbCollector.currentIndex
    }

    elmCltr.onClipChanged: {
        if(elmDist.checked === true) {
        } else {
        }
    }

    btnOK.onClicked:  {
        var portDist = cmbDistance.currentText
        var portCltr = cmbCollector.currentText
        console.log("openedDist:"+openedDist)
        console.log("openedCltr:"+openedCltr)

        console.log(portDist,portCltr,elmDist.checked,elmCltr.checked)
        //
        if(elmDist.checked === true) {
            if(!openedDist) {
                openedDist = threadLidar.open(portDist)
                if(openedDist !== true)
                    elmDist.checked = false
            } else
                console.log("openedDist is true, opened")
        } else {
            threadLidar.close()
            openedDist = false
            console.log("close lidar")
        }
        //
        if(elmCltr.checked === true) {
            if(!openedCltr) {
                openedCltr = threadCollector.open(portCltr)
                if(openedCltr !== true)
                    elmCltr.checked = false
            } else
                console.log("openedCltr is true, opened")
        } else {
            threadCollector.close()
            openedCltr = false
            console.log("close collector")
        }
    }

    btnStart.onClicked : {
        threadLidar.startRecord()
        threadCollector.startRecord()
    }

    btnStop.onClicked : {
        threadLidar.stopRecord()
        threadCollector.stopRecord()
    }

}

