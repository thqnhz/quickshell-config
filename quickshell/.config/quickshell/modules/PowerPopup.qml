import QtQuick
import Quickshell
import qs.config
import qs.common

PopupWindow {
    id: popup
    required property Item anchorItem

    implicitWidth: Config.powerPopupWidth
    implicitHeight: Config.powerPopupHeight
    color: "transparent"
    grabFocus: true

    property string pending: ""
    property real pendingSince: 0

    onVisibleChanged: {
        if (!visible) {
            pending = "";
            pendingSince = 0;
        }
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
            return;
        }
        pending = action;
        pendingSince = now;
    }

    anchor {
        item: popup.anchorItem
        rect.y: popup.anchorItem.height + Config.rowSpacing / 2
        rect.x: -Config.rowSpacing / 2
    }

    Rectangle {
        anchors.fill: parent
        color: Config.mantle
        border.width: 1
        border.color: Config.overlay2

        Column {
            anchors.centerIn: parent
            spacing: Config.rowSpacing

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    popup.handleAction("sleep", Config.sleepCommand);
                }
                text: popup.pending === "sleep" ? Config.powerConfirmIcon : "󰒲"
                color: popup.pending === "sleep" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    popup.handleAction("lock", Config.lockCommand);
                }
                text: popup.pending === "lock" ? Config.powerConfirmIcon : "󰌾"
                color: popup.pending === "lock" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    popup.handleAction("logout", Config.logoutCommand);
                }
                text: popup.pending === "logout" ? Config.powerConfirmIcon : "󰍃"
                color: popup.pending === "logout" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    popup.handleAction("shutdown", Config.shutdownCommand);
                }
                text: popup.pending === "shutdown" ? Config.powerConfirmIcon : "󰐥"
                color: popup.pending === "shutdown" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }

            ClickableText {
                acceptedButtons: Qt.LeftButton
                anchors.horizontalCenter: parent.horizontalCenter
                onClickedAction: function (event) {
                    popup.handleAction("restart", Config.restartCommand);
                }
                text: popup.pending === "restart" ? Config.powerConfirmIcon : "󰜉"
                color: popup.pending === "restart" ? Config.red : Config.text
                font.pixelSize: Config.fontSizePopup
            }
        }
    }
}
