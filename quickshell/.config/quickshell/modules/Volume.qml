import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.config
import qs.common

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

    ClickableText {
        acceptedButtons: Qt.RightButton
        onClickedAction: function (event) {
            Quickshell.execDetached(Config.volumeSettings);
        }
        property real scrollUp: Config.reverseScrolling ? Config.volumeScrollStep : -Config.volumeScrollStep
        property real scrollDown: Config.reverseScrolling ? -Config.volumeScrollStep : Config.volumeScrollStep
        onWheelAction: function (event) {
            if (!Pipewire.defaultAudioSink?.audio)
                return;
            const delta = event.angleDelta.y > 0 ? scrollUp : scrollDown;
            const vol = Math.max(0, Math.min(1.5, Pipewire.defaultAudioSink.audio.volume + delta));
            Pipewire.defaultAudioSink.audio.volume = vol;
        }
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
    }

    Splitter {}
}
