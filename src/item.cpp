#include "item.h"

Item::Item(QQuickItem *parent) :
    QQuickItem(parent)
{
}

Item::~Item()
{
}

void Item::setName(QString &name)
{
    if (name != _name) {
        _name = name;
        Q_EMIT nameChanged();
    }
}

void Item::toArduino(QTextStream &stream) {
    Q_UNUSED(stream);
    Q_ASSERT(false);
}
