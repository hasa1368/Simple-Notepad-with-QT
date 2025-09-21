#include "FileManager.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>


FileManager::FileManager(QObject *parent) : QObject(parent) {}
FileManager::~FileManager() {}


QString FileManager::readFile(const QString &path) {
    QFile f(path);
    if (!f.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Unable to open file for reading:" << path;
        return QString();
    }
    QTextStream in(&f);
    QString content = in.readAll();
    f.close();
    return content;
}


bool FileManager::writeFile(const QString &path, const QString &content) {
    QFile f(path);
    if (!f.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "Unable to open file for writing:" << path;
        return false;
    }
    QTextStream out(&f);
    out << content;
    f.close();
    return true;
}
