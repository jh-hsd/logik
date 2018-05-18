#ifndef _ELEMENT_
#define _ELEMENT_

#include <QQuickItem>
#include <QString>

#include "item.h"
#include "connector.h"

class Element : public Item {
    Q_OBJECT

    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged)
    Q_PROPERTY(QStringList archs READ archs WRITE setArchs NOTIFY archsChanged)
    Q_PROPERTY(QStringList inputs READ inputs WRITE setInputs NOTIFY inputsChanged)
    Q_PROPERTY(QStringList outputs READ outputs WRITE setOutputs NOTIFY outputsChanged)

    friend class Connector;

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

    Q_INVOKABLE Connector* input(QString name);
    Q_INVOKABLE Connector* output(QString name);
    Q_INVOKABLE void setInput(QString name, int val);
    Q_INVOKABLE void setOutput(QString name, int val);

protected:
    void addConnector(Connector *conn);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void descChanged();
    void archsChanged();
    void inputsChanged();
    void outputsChanged();

    void evaluate();
    void modify(Connector *conn, int direction);

private:
    QString _desc;
    QStringList _archs;
    QStringList _inputs;
    QStringList _outputs;

    QHash<QString, Connector *> _connectors;
};

#endif
