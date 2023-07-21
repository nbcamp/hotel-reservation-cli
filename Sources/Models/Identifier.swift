class Identifier {
    static var shared: Identifier = Identifier()
    
    var manager: [String: Int] = [:]
    
    func get(model: any Model) -> Int {
        let key = String(describing: type(of: model))
        guard let id = manager[key] else {
            manager.updateValue(1, forKey: key)
            return get(model: model)
        }
        manager[key]! += 1
        return id
    }
    
    private init() {}
}
