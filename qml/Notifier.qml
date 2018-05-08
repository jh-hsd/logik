import QtQuick 2.7

Rectangle {
    id: notifier
    opacity: timeout.running

    anchors.top: parent.top
    width: parent.width
    height: 4 * connectorSize
    color: "yellow"

    function show(text) {
        label.text = text;
        timeout.start();
    }

    Behavior on opacity {
        NumberAnimation { duration: 200 }
    }

    Timer {
        id: timeout
        running: false
        repeat: false
        interval: 3 * 1000
    }

    Text {
        id: label
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
    }
}
