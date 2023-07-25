import Foundation
import SQLite

class SQLiteDB: Database {
    static let shared: SQLiteDB = .init()

    let connection: Connection
    var tables: [String: Table] = [:]

    private init() {
        do {
//            connection = try Connection("./db.sqlite3")
            connection = try Connection(.temporary)
            try createTables()
        } catch {
            print(error)
            exit(1)
        }
    }

    func execute(_ query: String, params: [String] = []) -> [[String: Any]]? {
        do {
            let statement = try connection.prepare(query)
            defer { statement.reset() }
            let columns = statement.columnNames

            var rows: [[String: Any]] = []
            for values in statement {
                var row: [String: Any] = [:]
                for (name, value) in zip(columns, values) {
                    if let value = value {
                        row.updateValue(value, forKey: name)
                    }
                }
                rows.append(row)
            }
            return rows
        } catch {
            print(error)
            return []
        }
    }

    private func createTables() throws {
        if !exists("users") {
            try connection.execute("""
                CREATE TABLE users (
                    id          INTEGER     NOT NULL    PRIMARY KEY AUTOINCREMENT,
                    name        TEXT        NOT NULL,
                    point       INTEGER     DEFAULT     0,
                    createdAt   TIMESTAMP   DEFAULT     CURRENT_TIMESTAMP
                );
            """)
        }

        if !exists("rooms") {
            try connection.execute("""
                CREATE TABLE rooms (
                    id          INTEGER     NOT NULL    PRIMARY KEY AUTOINCREMENT,
                    price       INTEGER     DEFAULT     0,
                    createdAt   TIMESTAMP   DEFAULT     CURRENT_TIMESTAMP
                );
            """)
        }

        if !exists("reservations") {
            try connection.execute("""
                CREATE TABLE reservations (
                    id          INTEGER     NOT NULL    PRIMARY KEY AUTOINCREMENT,
                    userId      INTEGER     NOT NULL,
                    roomId      INTEGER     NOT NULL,
                    checkIn     TIMESTAMP   DEFAULT NULL,
                    checkOut    TIMESTAMP   DEFAULT NULL,
                    expiredAt   TIMESTAMP   DEFAULT NULL,
                    createdAt   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
                );
            """)
        }
    }

    private func exists(_ name: String) -> Bool {
        do {
            let table = Table(name)
            _ = try connection.scalar(table.exists)
            return true
        } catch {
            return false
        }
    }
}
