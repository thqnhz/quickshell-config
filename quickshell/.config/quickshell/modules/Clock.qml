import QtQuick
import Quickshell
import "../common"

ZText {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    text: Qt.formatDateTime(clock.date, "hh:mm")
}
