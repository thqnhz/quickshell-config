import QtQuick
import Quickshell
import Quickshell.Io
import qs.common
import qs.config

ZRow {
    ClickableText {
        id: coffee

        acceptedButtons: Qt.LeftButton
        onClickedAction: function(event) {
            if (coffee.active)
                Quickshell.execDetached(Config.stopCoffeeModeCommand);
            else
                Quickshell.execDetached(Config.startCoffeeModeCommand);
            coffee.active = !coffee.active;
        }

        property bool active: false

        Component.onCompleted: checkState()

        function checkState() {
            checker.running = true
        }

        Process {
            id: checker
            command: Config.checkHypridleCommand
            stdout: StdioCollector {
                onStreamFinished: {
                    coffee.active = text.trim() === "stopped";
                }
            }
        }
        text: active ? "" : "󰒲"
    }

    Splitter {}
}
