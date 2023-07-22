import Foundation

class Repository<Entity: Model> {
    var database: Database? // TODO: DB 분리
    var storage: Storage? // TODO: storage 분리
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    var entities: [Entity] = []
    var key: String { String(describing: type(of: Entity.self)) }

    init(
        storage: Storage? = nil,
        database: Database? = nil
    ) {
        self.storage = storage
        self.database = database
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    func findAll() -> [Entity] {
        let rows = database?.execute("SELECT * FROM \(Entity.name)") ?? []
        return rows.map { Entity.instantiate(dict: $0) }.compactMap { $0 }
    }

    func findOne(where: [String: Any]) -> Entity? {
        let rows = database?.execute("""
            SELECT * FROM \(Entity.name)
            WHERE \(`where`.map { "`\($0.key)` = \"\($0.value)\"" }.joined(separator: " and "))
        """) ?? []
        return rows.count > 0 ? Entity.instantiate(dict: rows[0]) : nil
    }

    func create(entity: Entity) {
        var columns: [String] = []
        var values: [String] = []
        for (prop, value) in entity.entries() {
            if prop == "id" { continue }
            columns.append("`\(prop)`")
            values.append("\"\(value)\"")
        }
        guard columns.count > 0, values.count > 0 else { return }
        database?.execute("""
            INSERT INTO \(Entity.name) (\(columns.joined(separator: ", ")))
            VALUES (\(values.joined(separator: ", ")))
        """)
    }

    func update(entity: Entity) {
        var targets: [String] = []
        for (prop, value) in entity.entries() {
            if prop == "id" { continue }
            targets.append("`\(prop)` = \"\(value)\"")
        }
        database?.execute("""
            UPDATE \(Entity.name) SET \(targets.joined(separator: ", "))
            WHERE id = \(entity.id)
        """)
    }

    func delete(id: ID) {
        database?.execute("DELETE FROM \(Entity.name) WHERE id = \(id)")
    }

    private func save() {
        guard let storage = storage else { return }
        do {
            let payload = try encoder.encode(entities)
            storage.setItem(key: key, value: String(data: payload, encoding: .utf8)!)
        } catch {
            return
        }
    }

    private func load() -> [Entity] {
        guard let storage = storage else { return [] }
        do {
            guard let payload = storage.getItem(key: key) else { return [] }
            let entities = try decoder.decode([Entity].self, from: payload.data(using: .utf16)!)
            return entities
        } catch {
            return []
        }
    }
}
