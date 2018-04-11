import QtQuick 2.7

Rectangle {
    id: connector
    width: connectorSize
    height: width /* square */
    radius: 0.5 * width /* circle */
    border {
        width: 3
        color: _input ? "yellow" : "blue"
    }
    color: !!value ? "white" : "grey"

    property string direction: "in"
    property alias name: nameText.text

    property bool _input: direction == "in"
    property bool _output: !_input

    property int value: 0
    onValueChanged: log("Connector '" + name + "': " + value);

    signal clicked()

    Text {
        id: nameText
        font.pixelSize: 0.5 * parent.height
        anchors {
            bottom: parent._output ? parent.top : undefined
            top: parent._input ? parent.bottom : undefined
            horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
