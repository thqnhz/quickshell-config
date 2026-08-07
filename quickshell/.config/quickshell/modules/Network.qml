import QtQuick
import Quickshell.Networking
import "../common"

ZText {
    text: {
        let netDevice = null;
        for (let d of Networking.devices.values)
            if (d.connected && (d.type === DeviceType.Wifi || d.type === DeviceType.Wired))
                netDevice = d;
        if (!netDevice?.connected)
            return "󰤭";
        if (netDevice.type === DeviceType.Wired)
            return "󰈀";
        let active = netDevice.networks?.values?.find(n => n.connected);
        if (!active)
            return "󰤩";
        let s = active.signalStrength;
        if (s > 0.75)
            return "󰤨";
        if (s > 0.5)
            return "󰤥";
        if (s > 0.25)
            return "󰤢";
        return "󰤟";
    }
}
