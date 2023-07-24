import Foundation

let app = App.shared

let io: IOInterface = TerminalInterface.shared
let database: Database = SQLiteDB.shared
// let storage = UserDefaultsStorage.shared

let userRepo = Repository<User>(database: database)
let roomRepo = Repository<Room>(database: database)
let reservationRepo = Repository<Reservation>(database: database)

// <defaults>
userRepo.create(entity: User(name: "jinyongp", point: 0))
roomRepo.create(entity: Room(price: 10_000))
roomRepo.create(entity: Room(price: 20_000))
roomRepo.create(entity: Room(price: 30_000))
roomRepo.create(entity: Room(price: 40_000))
roomRepo.create(entity: Room(price: 50_000))
// </defaults>

app.register(command: ChargeCommand(io: io, userRepo: userRepo))
app.register(command: PrintInfoCommand(io: io, roomRepo: roomRepo))
app.register(command: ReservationCommand(
    io: io,
    userRepo: userRepo,
    roomRepo: roomRepo,
    reservationRepo: reservationRepo
))

app.register(command: ConsoleExitCommand(io: io))
app.run(io: io)
