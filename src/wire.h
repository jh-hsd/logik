#ifndef _WIRE_
#define _WIRE_

#include <QQuickItem>
#include "item.h"

class QXmlStreamWriter;
class Connector;
class Element;

class Wire : public Item {
    Q_OBJECT

    Q_PROPERTY(QList<QQuickItem*> segments READ segments WRITE setSegments NOTIFY segmentsChanged)
    Q_PROPERTY(QQuickItem* lastSegment READ lastSegment NOTIFY lastSegmentChanged)
    Q_PROPERTY(int segmentCount READ segmentCount NOTIFY segmentCountChanged)

    Q_PROPERTY(Connector* input READ input WRITE setInput NOTIFY inputChanged)
    Q_PROPERTY(Connector* output READ output WRITE setOutput NOTIFY outputChanged)
    Q_PROPERTY(Element* inputElement READ inputElement WRITE setInputElement NOTIFY inputElementChanged)
    Q_PROPERTY(Element* outputElement READ outputElement WRITE setOutputElement NOTIFY outputElementChanged)

    Q_PROPERTY(qreal dx READ dx WRITE setDx NOTIFY dxChanged)
    Q_PROPERTY(qreal dy READ dy WRITE setDy NOTIFY dyChanged)
    Q_PROPERTY(qreal dxAbs READ dxAbs NOTIFY dxAbsChanged)
    Q_PROPERTY(qreal dyAbs READ dyAbs NOTIFY dyAbsChanged)
    Q_PROPERTY(Quadrant quadrant READ quadrant NOTIFY quadrantChanged)

public:
    enum Quadrant {
        TOP_LEFT,
        TOP_RIGHT,
        BOTTOM_LEFT,
        BOTTOM_RIGHT,
    };
    Q_ENUMS(Quadrant)

    Wire(QQuickItem *parent = Q_NULLPTR);
    virtual ~Wire();

    QList<QQuickItem*> segments() const { return _segments; };
    QQuickItem* lastSegment();
    int segmentCount() const { return _segments.count(); };
    Connector* input() const { return _input; };
    Connector* output() const { return _output; };
    Element* inputElement() const { return _inputElement; };
    Element* outputElement() const { return _outputElement; };
    qreal dx() const { return _dx; };
    qreal dy() const { return _dy; };
    qreal dxAbs() const { return abs(_dx); };
    qreal dyAbs() const { return abs(_dy); };
    Quadrant quadrant() const { return _quadrant; };

    void setSegments(QList<QQuickItem*> &segments);
    void setInput(Connector *input);
    void setOutput(Connector *output);
    void setInputElement(Element *input);
    void setOutputElement(Element *output);
    void setDx(qreal dx);
    void setDy(qreal dx);

    Q_INVOKABLE void pushSegment(QQuickItem *segment);
    Q_INVOKABLE void connectTo(Element *element,
                               Connector *connector);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void segmentsChanged();
    void lastSegmentChanged();
    void segmentCountChanged();
    void inputChanged();
    void outputChanged();
    void inputElementChanged();
    void outputElementChanged();
    void dxChanged();
    void dyChanged();
    void dxAbsChanged();
    void dyAbsChanged();
    void quadrantChanged();

private:
    void checkQuadrant();

    QList<QQuickItem*> _segments;
    Connector *_input = NULL;
    Connector *_output = NULL;
    Element *_inputElement = NULL;
    Element *_outputElement = NULL;
    qreal _dx;
    qreal _dy;
    Quadrant _quadrant;
};

#endif
