import QtQuick
import Quickshell.Io
import "../common"

ZRow {
    id: memory
    spacing: 8
    visible: usedPct > 0

    property int usedPct: 0

    Component.onCompleted: fetch()

    function fetch() {
        reader.running = true;
    }

    Process {
        id: reader
        command: ["bash", "-c", `free | awk '/^Mem:/{printf "%.0f", ($3/$2)*100}'`]
        stdout: StdioCollector {
            onStreamFinished: {
                const pct = parseInt(text.trim());
                if (!isNaN(pct))
                    memory.usedPct = pct;
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
        text: memory.usedPct
    }

    ZText {
        text: ""
    }

    Splitter {}
}
