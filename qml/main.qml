import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0

Window {
    id: main
    visible: true
    width: 1280
    height: 800
    title: "Logik"
    color: "grey"

    property int connectorSize: 20
    property int connectorSpacing: 10
    property string architecture: "RPi"
    property var supportedArchitectures: ["RPi", "Arduino", "Component"]

    property bool _debug: true

    function log(s) {
        if (_debug)
            console.log(s);
    }

    function centerPos(item, pos) {
        pos.x += item.width / 2;
        pos.y += item.height / 2;
    }

    SplitView {
        id: view
        anchors.fill: parent
        orientation: Qt.Horizontal

        Selection {
            id: selection
            Layout.minimumWidth: 0.3 * parent.width
            Layout.maximumWidth: 0.5 * parent.width

            onPlaceInProject: {
                var file = "./elements/" + comp + ".qml";
                log("Selection.onPlaceInProject: " + file);
                var comp = Qt.createComponent(file);
                var obj = comp.createObject(project, {
                    "x": 0.5 * project.width,
                    "y": 0.5 * project.height,
                    "dragable": true
                });
                obj.startWire.connect(project.startWire);
                obj.stopWire.connect(project.stopWire);
            }
        }

        Project {
            id: project
        }
    }
}
