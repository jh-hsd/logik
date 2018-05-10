#include "connector.h"
#include "element.h"

Connector::Connector(QQuickItem *parent) :
    Item(parent),
    _direction(In),
    _owner(Q_NULLPTR),
    _value(0)
{
    connect(this, &Connector::directionChanged,
            this, &Connector::inputChanged);
    connect(this, &Connector::directionChanged,
            this, &Connector::outputChanged);
}

Connector::~Connector()
{
}

void Connector::setName(QString &name)
{
    if (_owner && !_name.isEmpty()) {
        Element *elem = qobject_cast<Element *>(_owner);
        if (elem)
            elem->addConnector(this);
    }

    if (name != _name) {
        _name = name;
        Q_EMIT nameChanged();
    }
}

void Connector::setDirection(Direction direction)
{
    if (direction != _direction) {
        _direction = direction;
        Q_EMIT directionChanged();
    }
}

void Connector::setOwner(QQuickItem *owner)
{
    if (owner && !_name.isEmpty()) {
        Element *elem = qobject_cast<Element *>(owner);
        if (elem)
            elem->addConnector(this);
    }

    if (owner != _owner) {
        _owner = owner;
        Q_EMIT ownerChanged();
    }
}

void Connector::setValue(int value)
{
    if (value != _value) {
        _value = value;
        Q_EMIT valueChanged(_value);
    }
}

void Connector::toXml(QXmlStreamWriter &stream) {
    Q_UNUSED(stream);
    Q_ASSERT(false);
}
