struct Reservation: Model {
    var id: ID = { Identifier.shared.get(from: User.self) }()
    var userId: ID
    var roomId: ID
    var checkIn: Int // timestamp
    var checkOut: Int // timestamp
}
