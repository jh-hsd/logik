import QtQuick 2.7
import QtQuick.Layouts 1.3

Rectangle {
    id: button

    Layout.preferredWidth: width
    Layout.preferredHeight: height

    property alias label: label
    property alias text: label.text
    property bool active: false

    signal clicked()

    width: parent.width
    height: 4 * connectorSize
    color: (active ?
            mouse.containsMouse ? "yellow" : "lightyellow": 
            "white")

    Text {
        id: label
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        text: "Simulate"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true

        onClicked: button.clicked()
    }
}
