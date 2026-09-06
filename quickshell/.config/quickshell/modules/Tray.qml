import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.common
import qs.config

ZRow {
    id: tray

    property var visibleItems: {
        let result = [];
        let pinned = ["fcitx5"];
        for (let item of SystemTray.items.values) {
            if (pinned.includes(item.id) || item.status !== Status.Passive)
                result.push(item);
        }
        return result;
    }

    Repeater {
        model: tray.visibleItems
        delegate: Item {
            id: delegateRoot
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            IconImage {
                id: trayIcon
                source: modelData.icon
                anchors.fill: parent
                mipmap: true
                layer.enabled: true
                layer.effect: MultiEffect {
                    saturation: -1.0
                    colorization: 1.0
                    colorizationColor: Config.text
                }
            }

            QsMenuAnchor {
                id: menuAnchor
                anchor.item: delegateRoot
                menu: modelData.menu
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        modelData.activate();
                    } else if (event.button === Qt.MiddleButton) {
                        modelData.secondaryActivate();
                    } else if (event.button === Qt.RightButton && modelData.hasMenu) {
                        menuAnchor.open();
                    }
                }
            }
        }
    }

    Splitter {
        width: 2
    }
}
