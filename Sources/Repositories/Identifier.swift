class Identifier {
    static var shared: Identifier = Identifier()
    
    var manager: [String: Int] = [:]
    
    func get<T: Model>(from model: T.Type) -> Int {
        let key = generateKey(from: model)
        guard let id = manager[key] else {
            manager.updateValue(1, forKey: key)
            return get(from: model)
        }
        manager[key]! += 1
        return id
    }
    
    private func generateKey<T: Model>(from model: T.Type) -> String {
        return String(describing: type(of: model))
    }
    
    private init() {}
}
