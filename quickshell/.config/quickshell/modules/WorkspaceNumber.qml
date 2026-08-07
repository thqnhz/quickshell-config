import QtQuick
import Quickshell.Hyprland
import "../common"

ZRow {
    ZText {
        text: "#" + (Hyprland.focusedWorkspace?.id ?? "")
    }
}
