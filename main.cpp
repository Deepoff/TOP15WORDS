#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    QApplication::setApplicationName("TOP 15 WORDS");
    QApplication::setWindowIcon(QIcon("icon.png"));
    QApplication::setOrganizationName("2GIS LLC");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("APP_VERSION", QVariant(APP_VERSION));
    engine.rootContext()->setContextProperty("APP_BUILD", QVariant(APP_BUILD));
    engine.rootContext()->setContextProperty("DATESTR", QVariant(__DATE__));

    engine.load(url);

    return app.exec();
}

