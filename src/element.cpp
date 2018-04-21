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
