#include <QXmlStreamWriter>

#include "element.h"
#include "item.h"

Element::Element(QQuickItem *parent) :
    Item(parent)
{
}

Element::~Element()
{
}

void Element::setDesc(QString &desc)
{
    if (desc != _desc) {
        _desc = desc;
        Q_EMIT descChanged();
    }
}

void Element::setArchs(QStringList &archs)
{
    _archs = archs;
    Q_EMIT archsChanged();
}

void Element::setInputs(QStringList &inputs)
{
    _inputs = inputs;
    Q_EMIT inputsChanged();
}

void Element::setOutputs(QStringList &outputs)
{
    _outputs = outputs;
    Q_EMIT outputsChanged();
}

Connector* Element::input(QString name)
{
    if (!_inputs.contains(name))
        return Q_NULLPTR;
    if (!_connectors.contains(name))
        return Q_NULLPTR;
    return _connectors[name];
}

Connector* Element::output(QString name)
{
    if (!_outputs.contains(name))
        return Q_NULLPTR;
    if (!_connectors.contains(name))
        return Q_NULLPTR;
    return _connectors[name];
}

void Element::setInput(QString name, int val)
{
    if (!_inputs.contains(name))
        return;
    Connector *conn = _connectors[name];
    conn->setValue(val);
}

void Element::setOutput(QString name, int val)
{
    if (!_outputs.contains(name))
        return;
    Connector *conn = _connectors[name];
    conn->setValue(val);
}

void Element::addConnector(Connector *conn)
{
    if (_connectors.contains(conn->name()))
        return;
    _connectors[conn->name()] = conn;
    connect(conn, SIGNAL(valueChanged(int)),
            this, SIGNAL(evaluate()));
    connect(conn, SIGNAL(modify(Connector *, int)),
            this, SIGNAL(modify(Connector *, int)));
}

void Element::toXml(QXmlStreamWriter &stream)
{
    stream.writeStartElement("Element");
    stream.writeAttribute("id", _id);
    stream.writeAttribute("name", _name);
    stream.writeEndElement();
}
