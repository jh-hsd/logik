#ifndef _ITEM_
#define _ITEM_

#include <QQuickItem>

class QXmlStreamWriter;

class Item : public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    Item(QQuickItem *parent = Q_NULLPTR);
    virtual ~Item();

    const QString &name() const { return _name; };
    virtual void setName(QString &name);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void nameChanged();

protected:
    QString _name;
};

#endif
