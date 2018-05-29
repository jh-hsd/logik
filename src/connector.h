#ifndef _CONNECTOR_
#define _CONNECTOR_

#include <QQuickItem>

#include "item.h"

class Connector : public Item {
    Q_OBJECT

    Q_PROPERTY(Direction direction READ direction WRITE setDirection NOTIFY directionChanged)
    Q_PROPERTY(bool input READ input NOTIFY inputChanged)
    Q_PROPERTY(bool output READ output NOTIFY outputChanged)
    Q_PROPERTY(QQuickItem *owner READ owner WRITE setOwner NOTIFY ownerChanged)
    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)

public:
    enum Direction {
        In,
        Out,
    };
    Q_ENUMS(Direction)

    Connector(QQuickItem *parent = Q_NULLPTR);
    virtual ~Connector();

    Direction direction() const { return _direction; };
    bool input() const { return _direction == In; };
    bool output() const { return _direction == Out; };
    QQuickItem *owner() const { return _owner; };
    int value() const { return _value; };

    void setName(QString &name);
    void setDirection(Direction direction);

    void setOwner(QQuickItem *owner);
    void setValue(int value);

    void fire();

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void directionChanged();
    void inputChanged();
    void outputChanged();
    void ownerChanged();
    void valueChanged(int value);

    void modify(Connector *conn, int direction);

private:
    Direction _direction;
    QQuickItem *_owner;
    int _value;
};

#endif
