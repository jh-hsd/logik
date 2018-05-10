#include "item.h"

QList<Item *> Item::_items;

Item::Item(QQuickItem *parent) :
    QQuickItem(parent),
    _mode(Selection)
{
    Item::_items << this;
}

Item::~Item()
{
    Item::_items.removeOne(this);
}

void Item::setName(QString &name)
{
    if (name != _name) {
        _name = name;
        Q_EMIT nameChanged();
    }
}

void Item::setMode(Mode mode)
{
    if (mode != _mode) {
        _mode = mode;
        Q_EMIT modeChanged();
    }
}

void Item::toArduino(QTextStream &stream) {
    Q_UNUSED(stream);
    Q_ASSERT(false);
}
