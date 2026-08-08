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
        text: Math.round(volumeModule.volume * 100)
        visible: volumeModule.volume !== 0
        color: volumeModule.textColor
    }

    ZText {
        id: volText
        text: {
            if (volumeModule.muted || volumeModule.volume === 0)
                return "󰝟"; // Muted
            if (volumeModule.volume > 0.66)
                return "󰕾"; // Loud
            if (volumeModule.volume > 0.33)
                return "󰖀"; // Medium
            return "󰕿"; // Low
        }
        color: volumeModule.textColor
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
