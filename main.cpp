#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

//QString About () {
//    QString str;
//    str = "build number: " + APP_BUILD + "\n" + "build date: " + __DATE__ + "number of release: " + APP_VERSION;
//    return str;
//}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

//    qmlRegisterType<About, 1>("About", 1, 0, "About");

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

