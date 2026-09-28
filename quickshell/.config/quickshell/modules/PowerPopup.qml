import QtQuick
import Quickshell
import qs.config
import qs.common

PopupWindow {
    id: root
    required property Item anchorItem

    implicitWidth: Config.powerPopupWidth
    implicitHeight: Config.powerPopupHeight
    color: "transparent"
    grabFocus: true

    property string pending: ""
    property real pendingSince: 0
    property bool confirmReady: false

    onVisibleChanged: {
        if (!visible) {
            root.pending = "";
            root.pendingSince = 0;
            root.confirmReady = false;
            pendingTimer.stop();
            confirmDelayTimer.stop();
        }
    }

    Timer {
        id: pendingTimer
        interval: Config.powerConfirmTimeout
        onTriggered: {
            root.pending = "";
            root.pendingSince = 0;
            root.confirmReady = false;
        }
    }

    Timer {
        id: confirmDelayTimer
        interval: Config.powerConfirmMinDelay
        onTriggered: root.confirmReady = true
    }

    function handleAction(action, command) {
        const now = Date.now();
        if (pending === action) {
            const elapsed = now - pendingSince;
            if (elapsed >= Config.powerConfirmMinDelay && elapsed <= Config.powerConfirmTimeout) {
                Quickshell.execDetached(command);
                visible = false;
            }
            pending = "";
            pendingSince = 0;
            confirmReady = false;
            pendingTimer.stop();
            confirmDelayTimer.stop();
            return;
        }
        pending = action;
        pendingSince = now;
        confirmReady = false;
        pendingTimer.restart();
        confirmDelayTimer.restart();
    }

    anchor {
        item: root.anchorItem
        rect.y: root.anchorItem.height + Config.rowSpacing / 2
        rect.x: -Config.rowSpacing / 2
    }

    Rectangle {
        anchors.fill: parent
        color: Config.mantle
        border.width: 1
        border.color: Config.overlay2

        Column {
            anchors.centerIn: parent
            spacing: Config.rowSpacing / 2

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    root.handleAction("sleep", Config.sleepCommand);
                }
                text: root.pending === "sleep" ? Config.powerConfirmIcon : "󰒲"
                color: root.pending === "sleep" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    root.handleAction("lock", Config.lockCommand);
                }
                text: root.pending === "lock" ? Config.powerConfirmIcon : "󰌾"
                color: root.pending === "lock" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    root.handleAction("shutdown", Config.shutdownCommand);
                }
                text: root.pending === "shutdown" ? Config.powerConfirmIcon : "󰐥"
                color: root.pending === "shutdown" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    root.handleAction("restart", Config.restartCommand);
                }
                text: root.pending === "restart" ? Config.powerConfirmIcon : "󰜉"
                color: root.pending === "restart" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }
        }
    }
}
