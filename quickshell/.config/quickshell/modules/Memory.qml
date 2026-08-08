import QtQuick
import Quickshell.Io
import "../common"

ZRow {
    id: memory
    visible: ramPct > 0

    property int ramPct: 0
    property int totalPct: 0

    Component.onCompleted: fetch()

    function fetch() {
        reader.running = true;
    }

    Process {
        id: reader
        command: ["bash", "-c", `free | awk '
          /^Mem:/ { ram=int(($3/$2)*100+0.5) }
          /^Swap:/ { if ($2>0) sw=int(($3/$2)*100+0.5); else sw=0 }
          END { printf "%d %d", ram, ram+sw }'`]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = text.trim().split(" ");
                const r = parseInt(parts[0]);
                const t = parseInt(parts[1]);
                if (!isNaN(r))
                    memory.ramPct = r;
                if (!isNaN(t))
                    memory.totalPct = t;
            }
        }
    }

    Timer {
        running: true
        repeat: true
        interval: 5000
        triggeredOnStart: true
        onTriggered: memory.fetch()
    }

    ZText {
        text: memory.ramPct
    }

    ZText {
        text: "(" + memory.totalPct + ")"
        visible: memory.totalPct !== memory.ramPct
    }

    ZText {
        text: ""
    }

    Splitter {}
}
