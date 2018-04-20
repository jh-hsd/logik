import QtQuick 2.7
import org.jh 1.0

BaseWire {
    id: wire

    width: strength
    height: width

    property var input: null
    property var inputElement: null
    property var output: null
    property var outputElement: null

    property real dx: 0.0
    property real dy: 0.0
    property real dxAbs: Math.abs(dx)
    property real dyAbs: Math.abs(dy)
    /* 0 | 1
       --+--
       2 | 3 */
    property int _quadrant: {
        if (dy < 0)
            return (dx < 0 ? 0 : 1);
        return (dx < 0 ? 2 : 3);
    }
    property real strength: connectorSize / 4

    Component {
        id: segment

        Rectangle {
            opacity: 0.5
            x: switch (_quadrant) {
                case 0: return horizontal ? xStart + wire.dx : xStart;
                case 1: return xStart;
                case 2: return horizontal ? xStart + wire.dx : xStart;
                case 3: return xStart;
            }
            y: switch (_quadrant) {
                case 0: return horizontal ? yStart : yStart + wire.dy;
                case 1: return horizontal ? yStart : yStart + wire.dy;
                case 2: return yStart;
                case 3: return yStart;
            }
            width: vertical ? strength : dxAbs + strength
            height: horizontal ? strength : dyAbs + strength
            radius: strength / 2
            color: !!wire.output ?
                (!!wire.output.value ? "yellow" : "white") : "white"

            property bool horizontal: dxAbs > dyAbs
            property bool vertical: !horizontal
            property real xStart: -radius
            property real yStart: -radius
        }
    }

    function _newSegment() {
        var seg = segment.createObject(wire);
        wire.pushSegment(seg);
    }

    function _freezeSegment() {
        lastSegment.x = lastSegment.x;
        lastSegment.y = lastSegment.y;
        lastSegment.width = lastSegment.width;
        lastSegment.height = lastSegment.height;
        lastSegment.horizontal = lastSegment.horizontal;
        lastSegment.opacity= 1.0;
    }

    function _setElemConn(elem, conn) {
        if (conn.direction == "in") {
            input = conn;
            inputElement = elem;
        } else {
            output = conn;
            outputElement = elem;
        }
    }

    function _adjust(pos, elem) {
        var p = Qt.point(x + lastSegment.xStart, y + lastSegment.yStart);
        switch (elem.rotation) {
        case 0:
            p.x = pos.x;
            break;
        case 90:
            p.y = pos.y;
            break;
        case 180:
            p.x = pos.x;
            break;
        case 270:
            p.y = pos.y;
            break;
        }
        update(p);
        _freezeSegment();
        addSegment();
        update(pos);
    }

    function init(elem, conn, pos) {
        wire.x = pos.x;
        wire.y = pos.y;
        _newSegment();
        _setElemConn(elem, conn);
    }

    function addSegment() {
        var s = lastSegment;
        _newSegment();
        lastSegment.xStart = s.x;
        lastSegment.yStart = s.y;
        if (s.horizontal && s.xStart == s.x)
            lastSegment.xStart += s.width - s.radius;
        if (s.vertical && s.yStart == s.y)
            lastSegment.yStart += s.height - s.radius;
    }

    function releaseSegment() {
        _freezeSegment();
    }

    function release(elem, conn, pos) {
        log("Wire.release: x/y: " + pos.x + " / " + pos.y);
        _adjust(pos, elem);
        _freezeSegment();
        _setElemConn(elem, conn);
        /* bind output to input */
        input.value = Qt.binding(function() { return output.value });
    }

    function update(pos) {
        log("Wire.update: x/y: " + pos.x + " / " + pos.y);
        dx = pos.x - (x + lastSegment.xStart);
        dy = pos.y - (y + lastSegment.yStart);
    }
}
