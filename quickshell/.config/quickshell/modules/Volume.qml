import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.config
import "../common"

ZRow {
    id: volumeModule
    visible: Pipewire.ready && Pipewire.defaultAudioSink
    property color textColor: {
        let vol = volume * 100;
        if (vol >= Config.volumeThreshold2)
            return Config.red;
        if (vol >= Config.volumeThreshold1)
            return Config.peach;
        if (vol >= Config.volumeThreshold0)
            return Config.yellow;
        return Config.text;
    }

    Behavior on textColor {
        ColorAnimation {
            duration: Config.colorAnimationDuration
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false

    ZText {
        text: {
            let v = volumeModule.volume !== 0 ? Math.round(volumeModule.volume * 100) + " " : "";
            if (volumeModule.muted || volumeModule.volume === 0)
                return v + "󰝟"; // Muted
            if (volumeModule.volume > 0.66)
                return v + "󰕾"; // Loud
            if (volumeModule.volume > 0.33)
                return v + "󰖀"; // Medium
            return v + "󰕿"; // Low
        }
        color: volumeModule.textColor
        MouseArea {
            id: mouse
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            hoverEnabled: true
            onClicked: event => {
                if (event.button === Qt.RightButton)
                    Quickshell.execDetached(["pavucontrol-qt"]);
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
