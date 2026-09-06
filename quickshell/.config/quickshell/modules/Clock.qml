import QtQuick
import qs.common
import qs.common.animation
import qs.config

Item {
    id: clockRoot

    implicitWidth: timeText.width
    implicitHeight: timeText.height

    property bool hovered: false

    Timer {
        id: hoverDelay
        interval: Config.numberAnimationDuration
        onTriggered: clockRoot.hovered = false
    }

    ZText {
        id: timeText
        text: Time.hour + ":" + Time.minute
        anchors.horizontalCenter: parent.horizontalCenter
        y: clockRoot.hovered ? -height : 0
        Behavior on y {
            BouncingAnimation {}
        }
    }

    ZText {
        id: dateText
        text: Time.fullDate
        anchors.horizontalCenter: parent.horizontalCenter
        y: clockRoot.hovered ? 0 : height
        Behavior on y {
            BouncingAnimation {}
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            hoverDelay.stop();
            clockRoot.hovered = true;
        }
        onExited: hoverDelay.start()
    }
}
