pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    readonly property bool hasAdapter: Bluetooth.defaultAdapter !== null
    readonly property bool adapterEnabled: hasAdapter && Bluetooth.defaultAdapter.enabled
    readonly property int connectedCount: Bluetooth.devices.count

    function toggleAdapter() {
        if (!hasAdapter)
            return;
        Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
    }

    function icon() {
        if (!adapterEnabled)
            return "󰂲";
        for (let d of Bluetooth.defaultAdapter.devices.values) {
            if (d.connected)
                return "󰂱";
        }
        return "󰂯";
    }

    function color() {
        return "#cdd6f4";
    }
}
