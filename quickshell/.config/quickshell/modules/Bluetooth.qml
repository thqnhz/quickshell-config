import QtQuick
import Quickshell.Bluetooth
import "../common"

ZRow {
    id: bluetooth
    spacing: 8
    visible: Bluetooth.defaultAdapter.enabled

    ZText {
        text: {
            Bluetooth.defaultAdapter.devices?.values[0]?.connected ? "󰂱" : "󰂯";
        }
    }

    Splitter {}
}
