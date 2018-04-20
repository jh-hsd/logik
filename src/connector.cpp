#include "connector.h"

Connector::Connector(QQuickItem *parent) :
    QQuickItem(parent),
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

void Connector::toXml(QXmlStreamWriter &stream)
{
    // FIXME: add missing implementation
    Q_UNUSED(stream);
    qDebug("Expose %s to XML", qPrintable(_name));
}

void Connector::setName(QString &name)
{
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
    if (owner != _owner) {
        _owner = owner;
        Q_EMIT ownerChanged();
    }
}

void Connector::setValue(int value)
{
    if (value != _value) {
        _value = value;
        Q_EMIT valueChanged();
    }
}
