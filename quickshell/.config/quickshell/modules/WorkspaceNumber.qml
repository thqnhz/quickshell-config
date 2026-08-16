import QtQuick
import Quickshell.Hyprland
import qs.common
import qs.config

ClickableText {
    property string scrollUp: Config.reverseScrolling ? "+1" : "-1"
    property string scrollDown: Config.reverseScrolling ? "-1" : "+1"
    acceptedButtons: Qt.NoButton
    onWheelAction: function (event) {
        // If you are not using lua hyprland...

        // This is false when hyprland is not initialized
        // I'll just make sure to not have some race condition
        if (!Hyprland.usingLua)
            return;
        const ws = event.angleDelta.y > 0 ? scrollUp : scrollDown;
        Hyprland.dispatch(`hl.dsp.focus({ workspace = "${ws}" })`);
    }
    text: "#" + (Hyprland.focusedWorkspace?.id ?? "")
}
