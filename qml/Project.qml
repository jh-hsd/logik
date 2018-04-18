import QtQuick 2.7

import "./elements" as Element

Rectangle {
    id: project
    color: "lightblue"
        
    property var _wire: null

    function startWire(elem, conn) {
        if (!!_wire) return;
        var comp = Qt.createComponent("Wire.qml");
        var pos = mapFromItem(conn, 0, 0);
        centerPos(conn, pos);
        _wire = comp.createObject(project, {});
        _wire.init(elem, conn, pos);
    }

    function stopWire(elem, conn) {
        if (!_wire) return;
        if (conn.direction == "out") {
            resetWire();
            return;
        }
        console.log("Connector position: (x/y)", conn.x, conn.y);
        console.log("Element position: (x/y)", elem.x, elem.y);
        var pos = mapFromItem(conn, 0, 0);
        centerPos(conn, pos);
        _wire.release(elem, conn, pos);
        _wire = null;
    }

    function resetWire() {
        if (!_wire) return;
        _wire.destroy();
        _wire = null;
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        onClicked: {
            switch (mouse.button) {
            case Qt.LeftButton:
                if (_wire) {
                    _wire.releaseSegment();
                    _wire.addSegment();
                }
                break;
            case Qt.RightButton:
                if (!!_wire) resetWire();
                break;
            }
        }
        onPositionChanged: {
            if (!!_wire)
                _wire.update(Qt.point(mouse.x, mouse.y));
        }
    }
}
