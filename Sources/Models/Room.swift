struct Room: Model {
    var id: ID = { Identifier.shared.get(from: User.self) }()
    var rate: Int
}
