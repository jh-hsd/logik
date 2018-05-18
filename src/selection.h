#ifndef _SELECTION_
#define _SELECTION_

#include <QQuickItem>
#include <QStringList>

#include "item.h"

class Selection : public Item {
    Q_OBJECT

    Q_PROPERTY(QStringList architectures READ architectures CONSTANT);
    Q_PROPERTY(QStringList elements READ elements CONSTANT);

public:
    Selection(QQuickItem *parent = Q_NULLPTR);
    virtual ~Selection();

    const QStringList &architectures() const { return _architectures; };
    const QStringList &elements() const { return _elements; };

    Q_INVOKABLE void save(QUrl fileUrl);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void placeInProject(QString comp);

private:
    QStringList _architectures;
    QStringList _elements;
};

#endif
