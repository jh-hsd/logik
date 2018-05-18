#include <QXmlStreamWriter>

#include "selection.h"
#include "element.h"
#include "wire.h"

Selection::Selection(QQuickItem *parent) :
    Item(parent)
{
    _architectures << "RPi";
    _architectures << "Arduino";

    _elements << "Not";
    _elements << "And";
    _elements << "Or";
    _elements << "Gate";
    _elements << "Gpi";
    _elements << "Gpo";
    _elements << "Pwm";
}

Selection::~Selection()
{
}

void Selection::save(QUrl fileUrl)
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

void Selection::toXml(QXmlStreamWriter &stream)
{
    Q_UNUSED(stream);
    Q_ASSERT(false);
}
