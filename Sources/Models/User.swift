struct User: Model {
    static var name: String { "users" }
    
    var id: ID = 0
    var name: String
    var point: Int
}

