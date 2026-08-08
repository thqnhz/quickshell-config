import QtQuick
import Quickshell.Io
import qs.config
import "../common"

ZRow {
    id: cpu
    visible: temp > 0

    property int temp: 0
    property double load: 0
    property color tempColor: {
        if (temp >= Config.cpuTempThreshold2)
            return Config.red;
        if (temp >= Config.cpuTempThreshold1)
            return Config.peach;
        if (temp >= Config.cpuTempThreshold0)
            return Config.yellow;
        return Config.text;
    }

    Behavior on tempColor {
        ColorAnimation {
            duration: Config.colorAnimationDuration
        }
    }

    Component.onCompleted: fetchTemp()

    function fetchTemp() {
        reader.running = true;
    }

    Process {
        id: reader
        command: ["bash", "-c", `t=0; for z in /sys/class/thermal/thermal_zone*; do [ "$(cat $z/type)" = "x86_pkg_temp" ] &&
  t=$(cat $z/temp) && break; done; l=$(awk '{print $1}' /proc/loadavg); echo "$t $l"`]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(" ");
                const rawTemp = parseInt(parts[0]);
                if (!isNaN(rawTemp))
                    cpu.temp = Math.round(rawTemp / 1000);
                const rawLoad = parseFloat(parts[1]);
                if (!isNaN(rawLoad))
                    cpu.load = rawLoad;
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: Config.every5s
        triggeredOnStart: true
        onTriggered: cpu.fetchTemp()
    }

    ZText {
        text: cpu.temp + "°C"
        color: cpu.tempColor
    }

    ZText {
        text: "(" + cpu.load.toFixed(1) + ")"
        color: cpu.tempColor
    }

    ZText {
        text: ""
        color: cpu.tempColor
    }

    Splitter {}
}
