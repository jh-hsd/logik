#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "element.h"
#include "wire.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Element>("org.jh", 1, 0, "BaseElement");
    qmlRegisterType<Wire>("org.jh", 1, 0, "BaseWire");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}