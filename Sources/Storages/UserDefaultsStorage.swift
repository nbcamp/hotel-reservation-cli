import Foundation

class UserDefaultsStorage: Storage {
    static var shared: UserDefaultsStorage = .init()
    
    private lazy var defaults = UserDefaults.standard

    func getItem(key: String) -> String? {
        return defaults.string(forKey: key)
    }

    func setItem(key: String, value: String) {
        defaults.set(value, forKey: key)
    }

    func removeItem(key: String) {
        defaults.removeObject(forKey: key)
    }

    func clear() {
        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
    }
    
    private init() {}
}
