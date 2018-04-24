import QtQuick 2.7
import org.jh 1.0

BaseWire {
    id: wire

    width: strength
    height: width

    property real strength: connectorSize / 4

    Component {
        id: segment

        Rectangle {
            opacity: 0.5
            x: switch (quadrant) {
                case BaseWire.TOP_LEFT: return horizontal ? xStart + wire.dx : xStart;
                case BaseWire.TOP_RIGHT: return xStart;
                case BaseWire.BOTTOM_LEFT: return horizontal ? xStart + wire.dx : xStart;
                case BaseWire.BOTTOM_RIGHT: return xStart;
            }
            y: switch (quadrant) {
                case BaseWire.TOP_LEFT: return horizontal ? yStart : yStart + wire.dy;
                case BaseWire.TOP_RIGHT: return horizontal ? yStart : yStart + wire.dy;
                case BaseWire.BOTTOM_LEFT: return yStart;
                case BaseWire.BOTTOM_RIGHT: return yStart;
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
        connectTo(elem, conn);
    }

    function addSegment() {
        var s = lastSegment; /* save current segment */
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
        connectTo(elem, conn);
    }

    function update(pos) {
        dx = pos.x - (x + lastSegment.xStart) - lastSegment.radius;
        dy = pos.y - (y + lastSegment.yStart) - lastSegment.radius;
    }
}
