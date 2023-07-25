import Foundation

class InMemoryStorage: Storage {
    static var shared: InMemoryStorage = .init()

    private var storage: [String: String] = [:]

    func getItem(key: String) -> String? {
        return storage[key]
    }

    func setItem(key: String, value: String) {
        storage.updateValue(value, forKey: key)
    }

    func removeItem(key: String) {
        storage.removeValue(forKey: key)
    }

    func clear() {
        storage = [:]
    }
    
    private init() {}
}
