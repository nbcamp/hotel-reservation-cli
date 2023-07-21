import Foundation

 let app = App.shared

 let io = TerminalInterface.shared
let storage = UserDefaultsStorage.shared

 let user = User(name: "jinyongp", point: 0)
 let rooms: [Room] = [
    Room(rate: 10_000),
    Room(rate: 20_000),
    Room(rate: 30_000),
    Room(rate: 40_000),
    Room(rate: 50_000),
 ]

 app.register(command: ChargeCommand(io: io, user: user))
 app.register(command: PrintInfoCommand(io: io, rooms: rooms))
 app.register(command: ConsoleExitCommand(io: io))

 app.run(io: io, storage: storage)
