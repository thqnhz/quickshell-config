import QtQuick
import Quickshell
import Quickshell.Bluetooth
import qs.config
import qs.common

ZRow {
    ClickableText {
        id: btIcon

        acceptedButtons: Qt.RightButton
        onClickedAction: function (event) {
            Quickshell.execDetached(Config.bluetoothSettings);
        }

        text: {
            if (!Bluetooth.defaultAdapter.enabled)
                return "󰂲";
            for (let d of Bluetooth.defaultAdapter.devices.values) {
                if (d.connected)
                    return "󰂱";
            }
            return "󰂯";
        }
    }

    Splitter {}
}
