import QtQuick
import Quickshell.Services.Notifications
import "../common"

ZRow {
    id: notification
    clip: true
    visible: notifText.text !== ""

    NotificationServer {
        onNotification: notif => {
            notifText.text = notif.summary;
            dismissTimer.restart();
        }
    }

    Timer {
        id: dismissTimer
        interval: 5000
        onTriggered: notifText.text = ""
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
