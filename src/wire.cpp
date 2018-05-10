#include <QXmlStreamWriter>

#include "wire.h"
#include "connector.h"
#include "element.h"

int Wire::_idCount = 0;

Wire::Wire(QQuickItem *parent) :
    Item(parent)
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

    _id = QString("%1").arg(Wire::_idCount);
    Wire::_idCount++;
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

void Wire::setSegments(QList<QQuickItem*> &segments)
{
    if (segments != _segments) {
        _segments = segments;
        Q_EMIT segmentsChanged();
    }
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

void Wire::pushSegment(QQuickItem *segment)
{
    qDebug("adding segment to list");
    _segments << segment;
    Q_EMIT segmentsChanged();
}

void Wire::connectTo(Element *element,
                     Connector *connector)
{
    Q_ASSERT(element);
    Q_ASSERT(connector);
    
    qDebug("connect with element connector %s-%s",
           qPrintable(element->name()),
           qPrintable(connector->name()));

    if (connector->direction() == Connector::In) {
        Q_ASSERT(_output);
        Q_ASSERT(!_input);
        setInput(connector);
        setInputElement(element);
        connect(_output, &Connector::valueChanged,
                _input, &Connector::setValue);
        QString n = QString("%1:%2-%3:%4").
            arg(_outputElement->name()).
            arg(_output->name()).
            arg(_inputElement->name()).
            arg(_input->name());
        setName(n);
    } else {
        Q_ASSERT(!_input);
        Q_ASSERT(!_output);
        setOutput(connector);
        setOutputElement(element);
    }

    // delete wire if connected element changes rotation or position
    connect(element, SIGNAL(rotationChanged()), this, SLOT(deleteLater()));
    connect(element, SIGNAL(xChanged()), this, SLOT(deleteLater()));
    connect(element, SIGNAL(yChanged()), this, SLOT(deleteLater()));
}

void Wire::toXml(QXmlStreamWriter &stream) {
    stream.writeStartElement("Wire");
    stream.writeAttribute("id", _id);
    stream.writeAttribute("name", _name);
    stream.writeEndElement();
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
