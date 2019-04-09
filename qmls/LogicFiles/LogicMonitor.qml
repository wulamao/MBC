import QtQuick 2.9
import QtQuick.Controls 2.2
import "../UIFiles"

AnimationItem {
    property alias canvas: canvas

    PageMonitorForm {
        width: 1000
        height: 600


        Canvas {
            id:canvas
            width: parent.width
            height: parent.height
            property color strokeStyle:  Qt.darker(fillStyle, 1.4)
            property color fillStyle: "#b40000" // red
            property int lineWidth: 4
            property bool fill: true
            property bool stroke: true
            property real alpha: 1.0
            property real scale : 1
            property real rotate : 0
            antialiasing: true

            onLineWidthChanged:requestPaint();
            onFillChanged:requestPaint();
            onStrokeChanged:requestPaint();
            onScaleChanged:requestPaint();
            onRotateChanged:requestPaint();

            onPaint: {
                var ctx = canvas.getContext('2d');
                var originX = 85
                var originY = 75
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.translate(originX, originX);
                ctx.globalAlpha = canvas.alpha;
                ctx.strokeStyle = canvas.strokeStyle;
                ctx.fillStyle = canvas.fillStyle;
                ctx.lineWidth = canvas.lineWidth;

                ctx.translate(originX, originY)
                ctx.scale(canvas.scale, canvas.scale);
                ctx.rotate(canvas.rotate);
                ctx.translate(-originX, -originY)

                //! [0]
                ctx.beginPath();
                ctx.moveTo(75,40);
                ctx.bezierCurveTo(75,37,70,25,50,25);
                ctx.bezierCurveTo(20,25,20,62.5,20,62.5);
                ctx.bezierCurveTo(20,80,40,102,75,120);
                ctx.bezierCurveTo(110,102,130,80,130,62.5);
                ctx.bezierCurveTo(130,62.5,130,25,100,25);
                ctx.bezierCurveTo(85,25,75,37,75,40);
                ctx.closePath();
                //! [0]
                if (canvas.fill)
                    ctx.fill();
                if (canvas.stroke)
                    ctx.stroke();
                ctx.restore();

                var ctx1=canvas.getContext("2d");
                var x;
                var y;
                var r;
                var step;
                for (step = 0; step < 50; step++) {
                    x = Math.floor(Math.random()*parent.width)
                    y = Math.floor(Math.random()*parent.height)
                    r = Math.floor(Math.random()*50)
                    ctx1.beginPath();
                    ctx1.arc(x,y,r,0,2*Math.PI);
                    ctx1.stroke();
                    //ctx1.restore();
                }
            }
        }
    }
}

