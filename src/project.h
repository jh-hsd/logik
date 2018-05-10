#ifndef _PROJECT_
#define _PROJECT_

#include <QQuickItem>
#include <QString>

#include "item.h"
#include "connector.h"

class Project : public Item {
    Q_OBJECT

public:
    Project(QQuickItem *parent = Q_NULLPTR);
    virtual ~Project();

    Q_INVOKABLE void save();

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);
};

#endif
