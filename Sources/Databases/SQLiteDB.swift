import Foundation
import SQLite

class SQLiteDB: Database {
    static let shared = SQLiteDB()
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
                var dict: [String: Any] = [:]
                for (name, value) in zip(columns, values) {
                    dict[name] = value
                }
                rows.append(dict)
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
                    created_at  TIMESTAMP   DEFAULT     CURRENT_TIMESTAMP
                );
            """)
        }

        if !exists("rooms") {
            try connection.execute("""
                CREATE TABLE rooms (
                    id          INTEGER     NOT NULL    PRIMARY KEY AUTOINCREMENT,
                    price       INTEGER     DEFAULT     0,
                    created_at  TIMESTAMP   DEFAULT     CURRENT_TIMESTAMP
                );
            """)
        }

        if !exists("reservations") {
            try connection.execute("""
                CREATE TABLE reservations (
                    id          INTEGER     NOT NULL    PRIMARY KEY AUTOINCREMENT,
                    user_id     INTEGER     NOT NULL,
                    room_id     INTEGER     NOT NULL,
                    check_in    TIMESTAMP,
                    check_out   TIMESTAMP,
                    created_at  TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
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
