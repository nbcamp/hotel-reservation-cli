struct Room: Model {
    static var name: String { "rooms" }
    
    var id: ID = 0
    var price: Int
}
