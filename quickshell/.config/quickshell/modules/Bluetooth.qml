import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.config
import "../common"

ZRow {
    ZText {
        id: btIcon
        text: {
            if (!Bluetooth.defaultAdapter.enabled)
                return "󰂲";
            for (let d of Bluetooth.defaultAdapter.devices.values) {
                if (d.connected)
                    return "󰂱";
            }
            return "󰂯";
        }
        MouseArea {
            id: mouse
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            hoverEnabled: true
            onClicked: event => {
                if (event.button === Qt.RightButton)
                    Quickshell.execDetached(["kcmshell6", "kcm_bluetooth"]);
            }
        }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width + Config.rowSpacing * 2
            height: parent.height
            opacity: mouse.containsMouse ? 0.2 : 0
            color: Config.overlay0
        }
    }

    Splitter {}
}
