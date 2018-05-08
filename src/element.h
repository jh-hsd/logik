#ifndef _ELEMENT_
#define _ELEMENT_

#include <QQuickItem>
#include "item.h"

class QXmlStreamWriter;

class Element : public Item {
    Q_OBJECT

    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged)
    Q_PROPERTY(QStringList archs READ archs WRITE setArchs NOTIFY archsChanged)
    Q_PROPERTY(QStringList inputs READ inputs WRITE setInputs NOTIFY inputsChanged)
    Q_PROPERTY(QStringList outputs READ outputs WRITE setOutputs NOTIFY outputsChanged)

public:
    Element(QQuickItem *parent = Q_NULLPTR);
    virtual ~Element();

    const QString &desc() const { return _desc; };
    const QStringList &archs() const { return _archs; };
    const QStringList &inputs() const { return _inputs; };
    const QStringList &outputs() const { return _outputs; };

    void setDesc(QString &desc);
    void setArchs(QStringList &archs);
    void setInputs(QStringList &inputs);
    void setOutputs(QStringList &outputs);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void descChanged();
    void archsChanged();
    void inputsChanged();
    void outputsChanged();

private:
    static int _idCount;

    QString _id;
    QString _desc;
    QStringList _archs;
    QStringList _inputs;
    QStringList _outputs;
};

#endif
