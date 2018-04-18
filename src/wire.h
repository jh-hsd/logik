#ifndef _WIRE_
#define _WIRE_

#include <QQuickItem>

class QXmlStreamWriter;

class Wire : public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(QList<QQuickItem*> segments READ segments WRITE setSegments NOTIFY segmentsChanged)
    Q_PROPERTY(QQuickItem* lastSegment READ lastSegment NOTIFY lastSegmentChanged)
    Q_PROPERTY(int segmentCount READ segmentCount NOTIFY segmentCountChanged)

public:
    Wire(QQuickItem *parent = Q_NULLPTR);
    virtual ~Wire();

    QList<QQuickItem*> segments() const { return _segments; };
    QQuickItem* lastSegment();
    int segmentCount() const { return _segments.count(); };

    void setSegments(QList<QQuickItem*> &segments);
    Q_INVOKABLE void pushSegment(QQuickItem *segment);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void segmentsChanged();
    void lastSegmentChanged();
    void segmentCountChanged();

private:
    QList<QQuickItem*> _segments;
};

#endif
