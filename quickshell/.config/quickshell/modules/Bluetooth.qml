import QtQuick
import Quickshell
import Quickshell.Bluetooth
import "../common"

ZRow {
    ZText {
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
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: event => {
                if (event.button === Qt.RightButton)
                    Quickshell.execDetached(["kcmshell6", "kcm_bluetooth"]);
            }
        }
    }

    Splitter {}
}
