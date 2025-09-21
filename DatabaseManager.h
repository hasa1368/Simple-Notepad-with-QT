#pragma once
#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    void initDatabase(const QString &dbPath);

    Q_INVOKABLE bool createUser(const QString &username, const QString &password);
    Q_INVOKABLE bool validateUser(const QString &username, const QString &password);

private:
    QSqlDatabase db;
};
