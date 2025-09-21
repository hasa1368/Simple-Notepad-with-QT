#pragma once
#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>
#include<QDebug>
class FileManager : public QObject {
    Q_OBJECT
public:
    explicit FileManager(QObject *parent = nullptr);
    ~FileManager();


    Q_INVOKABLE QString readFile(const QString &path);
    Q_INVOKABLE bool writeFile(const QString &path, const QString &content);

    Q_INVOKABLE bool saveFile(const QString &filePath, const QString &text) {
        QFile file(filePath);
        if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
            return false;
        QTextStream out(&file);
        out << text;
        file.close();
        return true;
    }

    Q_INVOKABLE QString openFile(const QString &filePath) {
        QFile file(filePath);
        if (!file.exists()) {
            qDebug() << "File does not exist:" << filePath;
            return "";
        }
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qDebug() << "Cannot open file:" << filePath;
            return "";
        }
        QTextStream in(&file);
        QString content = in.readAll();
        file.close();
        return content;
    }

};
