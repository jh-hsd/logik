#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "selection.h"
#include "project.h"
#include "element.h"
#include "connector.h"
#include "wire.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<Selection>("org.jh", 1, 0, "BaseSelection");
    qmlRegisterType<Project>("org.jh", 1, 0, "BaseProject");
    qmlRegisterType<Element>("org.jh", 1, 0, "BaseElement");
    qmlRegisterType<Connector>("org.jh", 1, 0, "BaseConnector");
    qmlRegisterType<Wire>("org.jh", 1, 0, "BaseWire");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
