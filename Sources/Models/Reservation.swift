struct Reservation: Model {
    static var name: String { "reservations" }
    
    var id: ID = 0
    var userId: ID
    var roomId: ID
    var checkIn: Int // timestamp
    var checkOut: Int // timestamp
    var expiredAt: Int? // timestamp
}
