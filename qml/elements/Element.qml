import QtQuick 2.7

Rectangle {
    id: element
    width: Math.max(_minWidth, height)
    height: 100
    border {
        width: 3
        color: "green"
    }
    color: "lightyellow"

    property alias name: nameText.text
    property alias desc: descText.text
    property var inputs: []
    property var outputs: []

    property int _maxConnectors: Math.max(inputs.length, outputs.length)
    property int _minWidth: _maxConnectors * connectorSize +
        (_maxConnectors + 1) * connectorSpacing

    signal inputClicked(int n)
    signal outputClicked(int n)

    onInputClicked: log("element.inputClicked: " + n)
    onOutputClicked: log("element.outputClicked: " + n)

    function setInput(n, val) {
        inputsRow.children[n].value = val;
    }

    function setOutput(n, val) {
        outputsRow.children[n].value = val;
    }

    function getInput(n) {
        return inputsRow.children[n].value;
    }

    function getOutput(n) {
        return outputsRow.children[n].value;
    }

    Column {
        anchors.centerIn: parent
        Text {
            id: nameText
            text: "<name>"
            font.pixelSize: 0.2 * element.height
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: descText
            text: "<decs>"
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
                direction: "in"
                name: modelData
                onClicked: element.inputClicked(index)
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
                direction: "out"
                name: modelData
                onClicked: element.outputClicked(index)
            }
        }
    }
}
