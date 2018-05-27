#ifndef _ITEM_
#define _ITEM_

#include <QQuickItem>
#include <QList>

class QXmlStreamWriter;

class Item : public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(QString identifier READ identifier NOTIFY identifierChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(Mode mode READ mode WRITE setMode NOTIFY modeChanged)

public:
    enum Mode {
        Selection,
        Project,
    };
    Q_ENUMS(Mode)

    Item(QQuickItem *parent = Q_NULLPTR);
    virtual ~Item();

    const QString &identifier() const { return _id; };
    const QString &name() const { return _name; };
    Mode mode() const { return _mode; };

    virtual void setName(QString &name);
    virtual void setMode(Mode mode);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream);
    virtual void toArch(QString &arch, QTextStream &stream);

Q_SIGNALS:
    void identifierChanged();
    void nameChanged();
    void modeChanged();

protected:
    QString _id;
    QString _name;
    Mode _mode;

private:
    static int _idCount;

    static QList<Item *> _items;
};

#endif
