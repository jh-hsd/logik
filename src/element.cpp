#include "element.h"

Element::Element(QQuickItem *parent) :
    QQuickItem(parent)
{
}

Element::~Element()
{
}

void Element::toXml(QXmlStreamWriter &stream)
{
    // FIXME: add missing implementation
    Q_UNUSED(stream);
    qDebug("Expose %s to XML", qPrintable(_name));
}

void Element::setName(QString &name)
{
    if (name != _name) {
        _name = name;
        Q_EMIT nameChanged();
    }
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
