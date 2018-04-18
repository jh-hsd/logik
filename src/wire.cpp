#include "wire.h"

Wire::Wire(QQuickItem *parent) :
    QQuickItem(parent)
{
    connect(this, &Wire::segmentsChanged,
            this, &Wire::segmentCountChanged);
    connect(this, &Wire::segmentsChanged,
            this, &Wire::lastSegmentChanged);
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
