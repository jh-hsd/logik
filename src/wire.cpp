#include "wire.h"

Wire::Wire(QQuickItem *parent) :
    QQuickItem(parent)
{
    connect(this, &Wire::segmentsChanged,
            this, &Wire::segmentCountChanged);
    connect(this, &Wire::segmentsChanged,
            this, &Wire::lastSegmentChanged);
    connect(this, &Wire::dxChanged,
            this, &Wire::dxAbsChanged);
    connect(this, &Wire::dyChanged,
            this, &Wire::dyAbsChanged);
    connect(this, &Wire::dxChanged,
            this, &Wire::checkQuadrant);
    connect(this, &Wire::dyChanged,
            this, &Wire::checkQuadrant);
}

Wire::~Wire()
{
}

QQuickItem *Wire::lastSegment()
{
    if (_segments.empty())
        return Q_NULLPTR;
    return _segments.last();
}

void Wire::toXml(QXmlStreamWriter &stream)
{
    // FIXME: add missing implementation
    Q_UNUSED(stream);
    qDebug("Expose wire to XML");
}

void Wire::setSegments(QList<QQuickItem*> &segments)
{
    if (segments != _segments) {
        _segments = segments;
        Q_EMIT segmentsChanged();
    }
}

void Wire::pushSegment(QQuickItem *segment)
{
    qDebug("adding segment to list");
    _segments << segment;
    Q_EMIT segmentsChanged();
}

void Wire::setInput(Connector *input) {
    if (input != _input) {
        _input = input;
        Q_EMIT inputChanged();
    }
}

void Wire::setOutput(Connector *output) {
    if (output != _output) {
        _output = output;
        Q_EMIT outputChanged();
    }
}

void Wire::setInputElement(Element *input) {
    if (input != _inputElement) {
        _inputElement = input;
        Q_EMIT inputElementChanged();
    }
}

void Wire::setOutputElement(Element *output) {
    if (output != _outputElement) {
        _outputElement = output;
        Q_EMIT outputElementChanged();
    }
}

void Wire::setDx(qreal dx) {
    if (dx != _dx) {
        _dx = dx;
        Q_EMIT dxChanged();
    }
}

void Wire::setDy(qreal dy) {
    if (dy != _dy) {
        _dy = dy;
        Q_EMIT dyChanged();
    }
}

void Wire::checkQuadrant() {
    Quadrant q;
    if (_dy < 0)
        q = (_dx < 0) ? TOP_LEFT : TOP_RIGHT;
    else
        q = (_dx < 0) ? BOTTOM_LEFT : BOTTOM_RIGHT;
    if (q != _quadrant) {
        _quadrant = q;
        Q_EMIT quadrantChanged();
    }
}
