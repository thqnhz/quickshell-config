import QtQuick
import Quickshell.Bluetooth
import "../common"

ZRow {
    spacing: 8
    visible: Bluetooth.defaultAdapter.enabled

    ZText {
        text: {
            for (let d of Bluetooth.defaultAdapter.devices.values) {
                if (d.connected)
                    return "󰂱";
            }
            return "󰂯";
        }
    }

    Splitter {}
}
