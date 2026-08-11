import QtQuick
import Quickshell.Hyprland
import qs.common

ClickableText {
    acceptedButtons: Qt.LeftButton
    text: "#" + (Hyprland.focusedWorkspace?.id ?? "")
}
