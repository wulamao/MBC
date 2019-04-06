import QtQuick 2.9

Item {
    id: root
    property bool show: false
    property real showPropertyChangeOpacity: 1
    property real showPropertyChangeX: 0
    property real showPropertyChangeY: 0
    property real showPropertyChangeZ: 1

    property real hidePropertyChangeOpacity: 0
    property real hidePropertyChangeX: 0
    property real hidePropertyChangeY: root.height/1.3
    property real hidePropertyChangeZ: 0

    state: "hide"
    states: [
        State {
            name: "show"
            PropertyChanges {
                target: root
                opacity: showPropertyChangeOpacity
                x: showPropertyChangeX
                y: showPropertyChangeY
                z: showPropertyChangeZ
            }
            when: show
        },
        State {
            name: "hide"
            PropertyChanges {
                target: root
                opacity: hidePropertyChangeOpacity
                x: hidePropertyChangeX
                y: hidePropertyChangeY
                z: hidePropertyChangeZ
            }
            when: !show
        }
    ]

    transitions: Transition {
        onRunningChanged:{
            if(running == true && show){
                root.visible = true
            }

            if(running == false && !show){
                root.visible = false
            }
        }
        NumberAnimation{properties: "x,y"; easing.type: Easing.InOutQuad; duration: 300}
        NumberAnimation{properties: "opacity"; easing.type: Easing.InOutQuad; duration: 300}
    }
}
