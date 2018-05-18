#include <QXmlStreamWriter>

#include "project.h"
#include "item.h"
#include "element.h"
#include "wire.h"

Project::Project(QQuickItem *parent) :
    Item(parent)
{
}

Project::~Project()
{
}

void Project::save(QUrl fileUrl)
{
    Q_UNUSED(fileUrl);
    QString xml;
    QXmlStreamWriter stream(&xml);

    stream.setAutoFormatting(true);
    stream.writeStartDocument();

    const auto &childItemsCopy = childItems();
    for(const auto &item : childItemsCopy) {
        Element *elem = qobject_cast<Element *>(item);
        if (elem)
            elem->toXml(stream);
        Wire *wire = qobject_cast<Wire *>(item);
        if (wire)
            wire->toXml(stream);
    }

    stream.writeEndDocument();
    qDebug("%s", qPrintable(xml));
}

void Project::toXml(QXmlStreamWriter &stream)
{
    Q_UNUSED(stream);
    Q_ASSERT(false);
}
