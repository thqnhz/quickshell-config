import QtQuick
import Quickshell.Services.Notifications
import qs.config
import "../common"

ZRow {
    id: notifWidget
    clip: true
    visible: active || opacity > 0
    opacity: active ? 1 : 0
    property bool active: false
    Behavior on opacity {
        NumberAnimation {
            duration: Config.numberAnimationDuration
        }
    }
    onOpacityChanged: {
        if (opacity === 0 && !active)
            notifText.text = "";
    }

    NotificationServer {
        onNotification: notif => {
            notifText.text = notif.summary;
            notifWidget.active = true;
            dismissTimer.restart();
        }
    }

    Timer {
        id: dismissTimer
        interval: Config.every5s
        onTriggered: {
            notifWidget.active = false;
        }
    }

    Splitter {
        width: 2
    }

    ZText {
        text: "󱧌"
    }

    ZText {
        id: notifText
        width: 1366 / 2 - 100
        elide: Text.ElideRight
        maximumLineCount: 1
    }
}
