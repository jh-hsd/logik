#include "item.h"

Item::Item(QQuickItem *parent) :
    QQuickItem(parent)
{
}

Item::~Item()
{
}

void Item::toXml(QXmlStreamWriter &stream)
{
    // FIXME: add missing implementation
    Q_UNUSED(stream);
    qDebug("Expose %s to XML", qPrintable(_name));
}

void Item::setName(QString &name)
{
    if (name != _name) {
        _name = name;
        Q_EMIT nameChanged();
    }
}
