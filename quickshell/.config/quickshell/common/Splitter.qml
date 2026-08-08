import QtQuick
import qs.config

Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width: Config.splitterWidth
    implicitHeight: Config.splitterHeight
    color: Config.overlay2
}
