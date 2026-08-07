import QtQuick
import Quickshell.Bluetooth
import "../common"

ZRow {
    spacing: 8
    readonly property bool btEnabled: Bluetooth.defaultAdapter.enabled
    ZText {
        visible: parent.btEnabled
        text: {
            Bluetooth.defaultAdapter.devices?.values[0]?.connected ? "󰂱" : "󰂯";
        }
    }

    Splitter {
        visible: parent.btEnabled
    }
}
