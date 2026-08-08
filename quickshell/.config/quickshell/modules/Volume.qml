import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import "../common"

ZRow {
    id: volume
    visible: Pipewire.ready && Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false

    ZText {
        text: Math.round(volume.volume * 100)
        visible: volume.volume !== 0
    }

    ZText {
        id: volText
        text: {
            if (volume.muted || volume.volume === 0)
                return "󰝟"; // Muted
            if (volume.volume > 0.66)
                return "󰕾"; // Loud
            if (volume.volume > 0.33)
                return "󰖀"; // Medium
            return "󰕿"; // Low
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: event => {
                if (event.button === Qt.RightButton)
                    Quickshell.execDetached(["kcmshell6", "kcm_pulseaudio"]);
            }
        }
    }

    Splitter {}
}
