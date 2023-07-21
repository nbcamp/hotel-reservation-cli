import Foundation

class Reservation {
    static var nextId = 1

    var id: ID
    var userId: ID
    var roomId: ID
    var checkIn: Int // timestamp
    var checkOut: Int // timestamp

    init(
        userId: ID,
        roomId: ID,
        checkIn: Int,
        checkOut: Int
    ) {
        self.id = Room.nextId
        self.userId = userId
        self.roomId = roomId
        self.checkIn = checkIn
        self.checkOut = checkOut
        
        Room.nextId += 1
    }
    
}
