#ifndef _ITEM_
#define _ITEM_

#include <QQuickItem>
#include <QList>

class QXmlStreamWriter;

class Item : public QQuickItem {
    Q_OBJECT

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

    const QString &name() const { return _name; };
    virtual void setName(QString &name);
    Mode mode() const { return _mode; };
    virtual void setMode(Mode mode);

public Q_SLOTS:
    virtual void toXml(QXmlStreamWriter &stream) = 0;
    virtual void toArduino(QTextStream &stream);

Q_SIGNALS:
    void nameChanged();
    void modeChanged();

protected:
    QString _name;
    Mode _mode;

private:
    static QList<Item *> _items;
};

#endif
