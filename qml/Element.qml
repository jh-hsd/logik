import QtQuick 2.7
import org.jh 1.0

BaseElement {
    id: element
    width: Math.max(_minWidth, height)
    height: 100
    visible: (!architecture || archs.indexOf(architecture) >= 0)
    
    name: "<?>"
    desc: "<?>"
    archs: ["RPi", "Arduino", "Component"]

    property int _maxConnectors: Math.max(inputs.length, outputs.length)
    property int _minWidth: _maxConnectors * connectorSize +
        (_maxConnectors + 1) * connectorSpacing
    property alias dragable: mouse.dragActive

    signal clicked()
    signal modify(var conn)
    signal inputClicked(string name)
    signal outputClicked(string name)
    signal evaluate()
    signal startWire(var element, var conn)
    signal stopWire(var element, var conn)

    onClicked: log("element.clicked")
    onInputClicked: log("element.inputClicked: " + name)
    onOutputClicked: log("element.outputClicked: " + name)
    onStartWire: log("element.startWire: " + element.name +
                     ":" + conn.name)
    onStopWire: log("element.stopWire: " + element.name +
                    ":" + conn.name)

    Component.onCompleted: {
        console.log("Element position: (x/y/width/height)",
                    element.x, element.y, element.width, element.height);
        for (var i = 0; i < inputs.length; i++) {
            console.log("Element connector position: (x/y/width/height)",
                        inputsRow.children[i].x,
                        inputsRow.children[i].y,
                        inputsRow.children[i].width,
                        inputsRow.children[i].height);
        }
    }

    function _findConnectorByName(cs, n) {
        for (var i = 0; i < cs.length; i++)
            if (cs[i].name === n) return cs[i];
        return null;
    }

    function setInputByName(name, val) {
        var c = _findConnectorByName(inputsRow.children, name);
        if (!!c) c.value = val;
    }

    function setOutputByName(name, val) {
        var c = _findConnectorByName(outputsRow.children, name);
        if (!!c) c.value = val;
    }

    function getInputByName(name) {
        var c = _findConnectorByName(inputsRow.children, name);
        return (!!c ? c.value : null);
    }

    function getOutputByName(name) {
        var c = _findConnectorByName(outputsRow.children, name);
        return (!!c ? c.value : null);
    }

    Rectangle {
        anchors.fill: parent
        border {
            width: 3
            color: "green"
        }
        color: mouse.containsMouse ? "yellow" : "lightyellow"
    }

    Column {
        anchors.centerIn: parent
        Text {
            id: nameText
            text: element.name
            font.pixelSize: 0.2 * element.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: descText
            text: element.desc
            font.pixelSize: 0.2 * element.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        drag {
            target: dragActive ? element : null
            threshold: 10
        }
        hoverEnabled: true

        property bool dragActive: false

        onClicked: element.clicked()
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
                onClicked: element.inputClicked(name)
                onModify: element.modify(conn)
                onStartWire: element.startWire(element, conn)
                onStopWire: element.stopWire(element, conn)
                onValueChanged: element.evaluate()
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
                onClicked: element.outputClicked(name)
                onModify: element.modify(conn)
                onStartWire: element.startWire(element, conn)
                onStopWire: element.stopWire(element, conn)
            }
        }
    }
}
