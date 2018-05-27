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
    Q_PROPERTY(QString param READ param WRITE setParam NOTIFY paramChanged)

    Q_PROPERTY(QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)

    friend class Connector;

public:
    Element(QQuickItem *parent = Q_NULLPTR);
    virtual ~Element();

    const QString &desc() const { return _desc; };
    const QStringList &archs() const { return _archs; };
    const QStringList &inputs() const { return _inputs; };
    const QStringList &outputs() const { return _outputs; };
    const QString &param() const { return _param; };

    const QString &fileName() const { return _fileName; };

    void setDesc(QString &desc);
    void setArchs(QStringList &archs);
    void setInputs(QStringList &inputs);
    void setOutputs(QStringList &outputs);
    void setParam(QString &param);

    void setEvalInC(QString &code);
    void setFileName(QString &fn);

    Q_INVOKABLE Connector *input(QString name);
    Q_INVOKABLE Connector *output(QString name);
    Q_INVOKABLE void setInput(QString name, int val);
    Q_INVOKABLE void setOutput(QString name, int val);
    Q_INVOKABLE int inputValue(QString name);
    Q_INVOKABLE int outputValue(QString name);

protected:
    void addConnector(Connector *conn);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);
    virtual void toArduino(QTextStream &stream);

Q_SIGNALS:
    void descChanged();
    void archsChanged();
    void inputsChanged();
    void outputsChanged();
    void paramChanged();

    void fileNameChanged();

    void evaluate();
    void modify(Connector *conn, int direction);

private:
    QString _desc;
    QStringList _archs;
    QStringList _inputs;
    QStringList _outputs;
    QString _param;

    QString _fileName;

    QHash<QString, Connector *> _connectors;
};

#endif
