import QtQuick 2.9
import QtQuick.Controls 2.2

import QtWebChannel 1.0

import "../UIFiles"
import "../LogicFiles"

AnimationItem {
    property bool isUpdate: false
    property alias chart: chart
    property alias someObject: someObject

    PageChartsForm {
        id: chart
        width: 1000
        height: 600

        QtObject {
            id: someObject
            // ID, under which this object will be known at WebEngineView side
            WebChannel.id: "backend"
            property string someProperty: "Break on through to the other side"
            signal someSignal(var arg)
            signal clearSignal

            function test(varx) {
                console.log(varx)
            }
        }

        WebChannel {
            id: channel
            registeredObjects: [someObject]


        }

        webEngineView.url: "../../htmls/echarts.html"
        webEngineView.webChannel: channel

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

    function addInfoData(txt) {
       chart.textEdit.append(txt)
    }

    function clear() {
        someObject.clearSignal()
        chart.textEdit.clear()
    }

    function setUpdate() {
        isUpdate = true
    }

    //TODO
    function triggerUpdate(condition,boom,insert) {

    }

    function updateChart(condition,boom,insert) {
        if(!condition) {
            if(!isUpdate) return
            isUpdate = false
            var points = String(boom).split(',')
            var pointf = points.map(parseFloat)
            var pointOK = new Array
            pointOK = arrayTo3d(pointf,insert)
            pointOK.forEach(function(item) {
                chart.textEdit.append(item)
            })
            console.log(pointOK)
            someObject.someSignal(pointOK);
         } else {
            var test = new Array
            test.push([Math.floor(Math.random()*10),Math.floor(Math.random()*10),insert]);
            chart.textEdit.append("debug mode >>")
            // noted that 'test' is a list whose element is a list
            someObject.someSignal(test)
         }
    }

    function readFile(txtData) {
        var str = txtData.replace(/\n/g,',');
        var points = String(str).split(',')
        var pointf = points.map(parseFloat)
        var pointOK = new Array
        pointOK = arrayTo3dEx(pointf)
        console.log("a******************************************&")
        someObject.someSignal(pointOK);
    }

    //
    function arrayTo3d(arr,insert){
        var result = new Array
        for(var i=0;i<arr.length-1;i+=2){
            result.push([(arr)[i],(arr)[i+1],insert]);
        }
        return result;
    }
    //
    function arrayTo3dEx(arr){
        var result = new Array
        for(var i=0;i<arr.length-2;i+=3){
            result.push([(arr)[i],(arr)[i+1],String((arr)[i+2])]);
        }
        return result;
    }

    function getText() {
        return chart.textEdit.text
    }

//    Component.onCompleted: {
//        threadCollector.newData.connect(onRecord)
//    }

}


