#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "DatabaseManager.h"
#include "FileManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Notepad");

    // DB manager
    DatabaseManager dbMgr;
    dbMgr.initDatabase("E:/appdata.db");

    FileManager fileManager;

    // QML Engine
    QQmlApplicationEngine engine;

    //   C++ to QML
    engine.rootContext()->setContextProperty("DatabaseManager", &dbMgr);
    engine.rootContext()->setContextProperty("fileManager", &fileManager);

     const QUrl url = QUrl::fromLocalFile("Main.qml");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
