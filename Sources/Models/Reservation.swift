struct Reservation: Model {
    var userId: ID
    var roomId: ID
    var checkIn: Int // timestamp
    var checkOut: Int // timestamp
}
