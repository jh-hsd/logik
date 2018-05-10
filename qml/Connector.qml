import QtQuick 2.7
import org.jh 1.0

BaseConnector {
    id: connector
    focus: mouse.containsMouse
    width: connectorSize
    height: width /* square */

    property bool topValue: true

    onValueChanged: {
        timeout.restart();
        log("Connector '" + name + "': " + value);
    }

    signal clicked()
    signal startWire(var conn)
    signal stopWire(var conn)

    function checkModify(conn, direction) {
        if (!simulation) return;
        if (connector.direction == BaseConnector.In) return;
        modify(conn, direction);
    }

    onClicked: log("connector.clicked")
    onStartWire: log("connector.startWire: " + conn.name)
    onStopWire: log("connector.stopWire: " + conn.name)
            
    Keys.onPressed: {
        switch (event.key) {
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

    Rectangle {
        id: valueChangedNotifier
        width: 2 * connector.height
        height: connector.height
        anchors.left: connector.left
        anchors.bottom: topValue ? connector.top : undefined
        anchors.top: !topValue ? connector.bottom : undefined
        opacity: timeout.running
        color: "yellow"

        Text {
            id: label
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            text: connector.value
        }

        Timer {
            id: timeout
            running: false
            repeat: false
            interval: 1 * 1000
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        onWheel: {
            var d = wheel.angleDelta.y > 0 ? +1 : -1;
            connector.checkModify(connector, d);
        }
        
        onClicked: {
            switch (mouse.button) {
            case Qt.LeftButton:
                connector.checkModify(connector, +1);
                break;
            case Qt.RightButton:
                if (output)
                    connector.startWire(connector);
                else
                    connector.stopWire(connector);
                break;
            }
        }
    }
}
