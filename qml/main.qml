import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

Window {
    id: main
    visible: true
    width: 600
    height: 400
    title: "Logik"
    color: "grey"

    property var elements: ["And2"]

    property int connectorSize: 20
    property int connectorSpacing: 10

    property bool _debug: true

    function log(s) {
        if (_debug)
            console.log(s);
    }

    SplitView {
        id: view
        anchors.fill: parent
        orientation: Qt.Horizontal

        Selection {
            Layout.minimumWidth: 0.1 * parent.width
            Layout.maximumWidth: 0.3 * parent.width
        }

        Project {}
    }
}
