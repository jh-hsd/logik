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

void Element::setParam(QString &param)
{
    if (_param != param) {
        _param = param;
        Q_EMIT paramChanged();
    }
}

void Element::setEvalCode(QString &evalCode)
{
    _evalCode = evalCode;
    Q_EMIT evalCodeChanged();
}

void Element::setFileName(QString &fn)
{
    _fileName = fn;
    Q_EMIT fileNameChanged();
}

Connector *Element::input(QString name)
{
    if (!_inputs.contains(name))
        return Q_NULLPTR;
    if (!_connectors.contains(name))
        return Q_NULLPTR;
    return _connectors[name];
}

Connector *Element::output(QString name)
{
    if (!_outputs.contains(name))
        return Q_NULLPTR;
    if (!_connectors.contains(name))
        return Q_NULLPTR;
    return _connectors[name];
}

int Element::inputValue(QString name)
{
    Connector *inp = input(name);
    if (inp)
        return inp->value();
    return -1;
}

int Element::outputValue(QString name)
{
    Connector *outp = output(name);
    if (outp)
        return outp->value();
    return -1;
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

void Element::fire() const
{
    QHash<QString, Connector *>::const_iterator i;
    for (i = _connectors.constBegin(); i != _connectors.constEnd(); ++i)
        i.value()->fire();
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
    Item::toXml(stream);
    stream.writeAttribute("fileName", fileName());
    stream.writeEndElement();
}

void Element::toArduino(QTextStream &stream) {
    stream << "/* Boilerplate for " << name() << " (" <<
        identifier() << ") */";
}
