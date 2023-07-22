import Foundation

let app = App.shared

let io: IOInterface = TerminalInterface.shared
let database: Database = SQLiteDB.shared
// let storage = UserDefaultsStorage.shared

let userRepo = Repository<User>(database: database)
let roomRepo = Repository<Room>(database: database)

userRepo.create(entity: User(name: "jinyongp", point: 0))
let user = userRepo.findOne(where: ["name": "jinyongp"])!

roomRepo.create(entity: Room(price: 10_000))
roomRepo.create(entity: Room(price: 20_000))
roomRepo.create(entity: Room(price: 30_000))
roomRepo.create(entity: Room(price: 40_000))
roomRepo.create(entity: Room(price: 50_000))
let rooms: [Room] = roomRepo.findAll()

app.register(command: ChargeCommand(io: io, user: user))
app.register(command: PrintInfoCommand(io: io, rooms: rooms))
app.register(command: ConsoleExitCommand(io: io))

app.run(io: io)
