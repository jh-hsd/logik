#ifndef _ELEMENT_
#define _ELEMENT_

#include <QQuickItem>

class QXmlStreamWriter;

class Element : public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged)
    Q_PROPERTY(QStringList archs READ archs WRITE setArchs NOTIFY archsChanged)
    Q_PROPERTY(QStringList inputs READ inputs WRITE setInputs NOTIFY inputsChanged)
    Q_PROPERTY(QStringList outputs READ outputs WRITE setOutputs NOTIFY outputsChanged)

public:
    Element(QQuickItem *parent = Q_NULLPTR);
    virtual ~Element();

    QString name() const { return _name; };
    QString desc() const { return _desc; };

    QStringList archs() const { return _archs; };
    QStringList inputs() const { return _inputs; };
    QStringList outputs() const { return _outputs; };

    void setName(QString &name);
    void setDesc(QString &desc);

    void setArchs(QStringList &archs);
    void setInputs(QStringList &inputs);
    void setOutputs(QStringList &outputs);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);

Q_SIGNALS:
    void nameChanged();
    void descChanged();

    void archsChanged();
    void inputsChanged();
    void outputsChanged();

private:
    QString _name;
    QString _desc;
    QStringList _archs;
    QStringList _inputs;
    QStringList _outputs;
};

#endif
