#include "DatabaseManager.h"
#include <QSqlError>

DatabaseManager::DatabaseManager(QObject *parent) : QObject(parent) {}

void DatabaseManager::initDatabase(const QString &dbPath)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath);
    if (!db.open()) qDebug() << "Cannot open database:" << db.lastError().text();

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)");
}

bool DatabaseManager::createUser(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);
    if (!query.exec()) {
        qDebug() << "Create user failed:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::validateUser(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT * FROM users WHERE username = :username AND password = :password");
    query.bindValue(":username", username);
    query.bindValue(":password", password);
    if (!query.exec()) return false;
    return query.next();
}
