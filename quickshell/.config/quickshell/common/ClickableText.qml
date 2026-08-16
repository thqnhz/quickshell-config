import QtQuick
import qs.config

ZText {
    id: root
    required property int acceptedButtons
    property var onClickedAction: function (event) {}
    property var onWheelAction: function (event) {}

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: root.acceptedButtons
        hoverEnabled: true
        onClicked: event => root.onClickedAction(event)
        onWheel: event => root.onWheelAction(event)
    }
    Rectangle {
        anchors.centerIn: parent
        width: parent.width + Config.rowSpacing * 2
        height: parent.height
        opacity: mouse.containsMouse ? 0.2 : 0
        color: Config.overlay0
        z: -1
    }
}
