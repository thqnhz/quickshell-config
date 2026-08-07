pragma ComponentBehavior: Bound
import QtQuick
import Quickshell

LazyLoader {
    loading: true

    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 20
        color: "#11111b"

        BarLeft {}

        BarCenter {}

        BarRight {}
    }
}
