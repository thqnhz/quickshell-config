import QtQuick
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "../common"

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
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            IconImage {
                source: modelData.icon
                anchors.fill: parent
                mipmap: true
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: event => {
                    if (event.button === Qt.LeftButton)
                        modelData.activate();
                }
            }
        }
    }

    Splitter {
        width: 2
    }
}
