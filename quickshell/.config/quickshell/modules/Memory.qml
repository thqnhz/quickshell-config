import QtQuick
import Quickshell.Io
import qs.config
import qs.common

ZRow {
    id: memory
    property int ramPct: 0

    Item {
        id: warning
        visible: memory.ramPct >= Config.ramUsageThreshold || opacity > 0
        opacity: memory.ramPct >= Config.ramUsageThreshold ? 1 : 0
        scale: memory.ramPct >= Config.ramUsageThreshold ? 1 : 0.75
        implicitWidth: warnText.implicitWidth
        implicitHeight: warnText.implicitHeight

        Behavior on opacity {
            NumberAnimation {
                duration: Config.numberAnimationDuration
                easing.type: Easing.OutCubic
            }
        }
        Behavior on scale {
            NumberAnimation {
                duration: Config.numberAnimationDuration
                easing.type: Easing.OutBack
            }
        }

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
                        memory.ramPct = pct;
                }
            }
        }

        Timer {
            running: true
            repeat: true
            interval: Config.every5s
            triggeredOnStart: true
            onTriggered: warning.fetch()
        }

        ZText {
            id: warnText
            text: "!"
            color: Config.red
        }
    }

    Splitter {
        visible: warning.visible
    }
}
