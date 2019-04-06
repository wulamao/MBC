import QtQuick 2.9
import QtQuick.Controls 2.2
import "../UIFiles"

AnimationItem {
    property var logData:["0,0"]
    property bool isUpdate: false
    property alias chart: chart

    PageChartsForm {
        id: chart
        width: 1000
        height: 600
    }

    Timer {
        id: timer
        interval: 3000;
        repeat: true
        running: false
        triggeredOnStart: false
        onTriggered: {
            var data = logData
            if(isUpdate) {
                isUpdate = false
                data.forEach(function(item) {
                })
                data.splice(0,data.length)
            }
        }
    }


    function getData() {
       return chart.textEdit.text
    }

    function saveImage(imageName) {
        chart.grabToImage(function(result) {
            var text = Qt.formatDateTime(new Date(), "[yyyy-MM-dd]hh-mm-ss_")
            result.saveToFile("../MBC/data/"+text+imageName+".jpeg");
            console.log("../MBC/data/"+text+imageName+".jpeg")
        });
    }

    function clear() {
        chart.someObject.clearSignal()
        chart.textEdit.clear()
    }

    function updateChart(condition,boom,insert) {
        if(!condition) {
            if(isUpdate) {
                isUpdate = false

                //console.log("boom:"+String(boom).split(',')[0]);
                var points = String(boom).split(',')
                var pointf = points.map(parseFloat)
                var pointOK = new Array
                pointOK = arrayTo3d(pointf,insert)
                pointOK.forEach(function(item) {
                    chatView.chart.textEdit.append(item)
                })

                chatView.chart.someObject.someSignal(pointOK);
              }
         } else {
             chatView.chart.textEdit.append("debug mode ……")
             chatView.chart.someObject.someSignal([Math.floor(Math.random()*10),
                                                   Math.floor(Math.random()*10),
                                                   Math.floor(Math.random()*10),
                                                   Math.floor(Math.random()*3), 0]);
         }
    }

    //
    function arrayTo3d(arr,insert){
        var result = new Array
        for(var i=0;i<arr.length-1;i+=2){
            result.push([(arr)[i],(arr)[i+1],insert]);
        }
        return result;
    }

//    Component.onCompleted: {
//        threadCollector.newData.connect(onRecord)
//    }

}


/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
