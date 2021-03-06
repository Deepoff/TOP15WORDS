import QtQuick 2.0
import QtQuick.Controls 2.4

ToolButton {
    id: aboutBtn
    property int btn_state: 0
    state: btn_state > 0 ? "Open" : "Close"

    Rectangle {
        id: rectangle1
        color: "#00ffffff"
        anchors.fill: parent
        anchors.margins: parent.width/5
        onStateChanged: console.debug(btn_state)

        Rectangle {
            id: rectangle
            width: parent.width/5
            height: parent.height/5
            radius: width/2
            color: "white"
            anchors.verticalCenterOffset: -parent.height/3
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            border.width: 0
        }

        Rectangle {
            id: rectangle2
            width: parent.width/5
            height: parent.height/5
            radius: width/2
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            border.width: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: rectangle3
            width: parent.width/5
            height: parent.height/5
            radius: width/2
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            border.width: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: parent.height/3
        }

    }
    states: [
        State {
            id: open
            name: "Open"

            PropertyChanges {
                id: propertyChanges_open_icon
                target: rectangle1; rotation: 90; /*height: passinput.height*/
            }
        },

        State {
            id: close
            name: "Close"

            PropertyChanges {
                id: propertyChanges_close_icon_on
                target: rectangle1; rotation: 0;
            }
        }
    ]

    transitions: [
        Transition {
            from: "Close"
            to: "Open"

            PropertyAnimation {
                target: rectangle1
                easing.amplitude: 2
                duration: 500
                properties: "scale"
                from: 1
                to: 0
                easing.type: Easing.OutQuad
            }
        },
        Transition {
            from: "Open"
            to: "Close"

            PropertyAnimation {
                target: rectangle1
                easing.amplitude: 1.5
                duration: 500
                properties: "scale"
                from: 0
                to: 1
                easing.type: Easing.OutElastic
            }
        }
    ]

}
