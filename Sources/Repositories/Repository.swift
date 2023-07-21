import Foundation

class Repository<Entity: Model> {
    let storage: Storage
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    var entities: [Entity] = []
    var key: String { String(describing: type(of: Entity.self)) }

    init(storage: Storage) {
        self.storage = storage
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    func findAll() -> [Entity] {
        return load()
    }

    func findOne(id: ID) -> Entity? {
        return entities.first(where: { $0.id == id })
    }

    func create(entity: Entity) {
        entities.append(entity)
        save()
    }

    func update(entity newEntity: Entity) {
        entities = entities.map { $0.id == newEntity.id ? newEntity : $0 }
        save()
    }

    func delete(id: ID) {
        entities = entities.filter { $0.id != id }
        save()
    }

    private func save() {
        do {
            let payload = try encoder.encode(entities)
            storage.setItem(key: key, value: String(data: payload, encoding: .utf8)!)
        } catch {
            return
        }
    }

    private func load() -> [Entity] {
        do {
            guard let payload = storage.getItem(key: key) else { return [] }
            let entities = try decoder.decode([Entity].self, from: payload.data(using: .utf16)!)
            return entities
        } catch {
            return []
        }
    }
}
