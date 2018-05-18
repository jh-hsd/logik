import QtQuick 2.7
import org.jh 1.0

BaseElement {
    id: element
    width: visible ? Math.max(_minWidth, height) : 0
    height: visible ? 100 : 0
    visible: (!architecture || archs.indexOf(architecture) >= 0)
    
    name: "<?>"
    desc: "<?>"
    archs: ["RPi", "Arduino", "Component"]

    property int _maxConnectors: Math.max(inputs.length, outputs.length)
    property int _minWidth: _maxConnectors * connectorSize +
        (_maxConnectors + 1) * connectorSpacing
    property alias dragable: mouse.dragActive
    property bool writable: false

    signal clicked()
    signal inputClicked(string name)
    signal outputClicked(string name)
    signal startWire(var element, var conn)
    signal stopWire(var element, var conn)
    signal adjustName(var element, string btnText, string text)

    onClicked: log("element.clicked")
    onInputClicked: log("element.inputClicked: " + name)
    onOutputClicked: log("element.outputClicked: " + name)
    onStartWire: log("element.startWire: " + element.name + ":" + conn.name)
    onStopWire: log("element.stopWire: " + element.name + ":" + conn.name)

    function textChange(text) {
        element.name = text;
    }

    Rectangle {
        anchors.fill: parent
        border {
            width: 3
            color: "green"
        }
        color: mouse.containsMouse ? "yellow" : "lightyellow"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag {
            target: dragActive ? element : null
            threshold: 10
        }
        hoverEnabled: true

        property bool dragActive: false

        onClicked: {
            switch (mouse.button) {
            case Qt.LeftButton:
                element.clicked();
                break;
            case Qt.RightButton:
                break;
            }
        }
    }

    Column {
        anchors.centerIn: parent
        Text {
            id: nameText
            text: element.name
            font.pixelSize: 0.2 * element.height
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent
                enabled: writable
                onClicked: element.adjustName(element, "", element.name)
            }
        }
        Text {
            id: descText
            text: element.desc
            font.pixelSize: 0.2 * element.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Row {
        id: inputsRow
        anchors {
            verticalCenter: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        spacing: connectorSpacing

        Repeater {
            model: inputs
            delegate: Connector {
                direction: Connector.In
                name: modelData
                owner: element
                topValue: true
                onClicked: element.inputClicked(name)
                onStartWire: element.startWire(element, conn)
                onStopWire: element.stopWire(element, conn)
            }
        }
    }

    Row {
        id: outputsRow
        anchors {
            verticalCenter: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        spacing: connectorSpacing

        Repeater {
            model: outputs
            delegate: Connector {
                direction: Connector.Out
                name: modelData
                owner: element
                topValue: false
                onClicked: element.outputClicked(name)
                onStartWire: element.startWire(element, conn)
                onStopWire: element.stopWire(element, conn)
            }
        }
    }
}
