pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.config

Singleton {
    id: root

    readonly property bool ready: Pipewire.ready && Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    readonly property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false
    readonly property int volPct: Math.round(volume * 100)

    function setVolume(vol) {
        if (!ready)
            return;
        Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1.5, vol));
    }

    function step(delta) {
        if (!ready)
            return; // Not a redundant check, This ensure the volume isn't null before trying to add
        setVolume(Pipewire.defaultAudioSink.audio.volume + delta);
    }

    function toggleMute() {
        if (!ready)
            return;
        Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted;
    }

    function icon() {
        if (muted || volume === 0)
            return "󰝟"; // Muted
        if (volume > 0.66)
            return "󰕾"; // Loud
        if (volume > 0.33)
            return "󰖀"; // Medium
        return "󰕿"; // Low
    }

    function color() {
        if (volPct >= Config.volumeThreshold2)
            return Config.red;
        if (volPct >= Config.volumeThreshold1)
            return Config.peach;
        if (volPct >= Config.volumeThreshold0)
            return Config.yellow;
        return Config.text;
    }

    function displayText() {
        const v = volume !== 0 ? volPct + " " : "";
        return v + icon();
    }
}
