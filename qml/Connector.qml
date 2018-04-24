import QtQuick 2.7
import org.jh 1.0

BaseConnector {
    id: connector
    focus: mouse.containsMouse
    width: connectorSize
    height: width /* square */

    onValueChanged: log("Connector '" + name + "': " + value);

    signal clicked()
    signal modify(var conn)
    signal startWire(var conn)
    signal stopWire(var conn)

    onClicked: log("connector.clicked")
    onStartWire: log("connector.startWire: " + conn.name)
    onStopWire: log("connector.stopWire: " + conn.name)
            
    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_W: /* draw wire */
            if (output)
                connector.startWire(connector);
            break;
        case Qt.Key_M: /* change input/output */
            connector.modify(connector);
            break;
        default:
            console.log("unsupported shortcut");
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: input ? 0.5 * width /* circle */ : 0
        border {
            width: 3
            color: mouse.containsMouse ? "grey" : "lightgrey"
        }
        color: !!value ? "yellow" : "white"
    }

    Text {
        id: nameText
        font.pixelSize: 0.5 * parent.height
        text: connector.name
        anchors {
            bottom: connector.output ? parent.top : undefined
            top: connector.input ? parent.bottom : undefined
            horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        onClicked: {
            switch (mouse.button) {
            case Qt.LeftButton:
                connector.clicked();
                break;
            case Qt.RightButton:
                connector.stopWire(connector);
                break;
            }
        }
    }
}
