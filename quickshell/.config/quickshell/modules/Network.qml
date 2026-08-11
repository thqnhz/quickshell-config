import QtQuick
import Quickshell
import Quickshell.Networking
import qs.config
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
    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        hoverEnabled: true
        onClicked: event => {
            if (event.button === Qt.RightButton)
                Quickshell.execDetached(["kcmshell6", "kcm_networkmanagement"]);
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
