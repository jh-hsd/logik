#include <QXmlStreamWriter>

#include "item.h"

QList<Item *> Item::_items;
int Item::_idCount = 0;

Item::Item(QQuickItem *parent) :
    QQuickItem(parent),
    _mode(Selection)
{
    Item::_items << this;
    _id = QString("%1").arg(Item::_idCount);
    Item::_idCount++;
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
