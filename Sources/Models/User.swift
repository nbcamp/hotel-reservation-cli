struct User: Model {
    var id: ID = { Identifier.shared.get(from: User.self) }()
    var name: String
    var point: Int
}

