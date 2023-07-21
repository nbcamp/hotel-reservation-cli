import Foundation

let app = App.shared
let io = TerminalInterface.shared
let user = User(name: "Jinyong Park", point: 0)

app.register(command: ChargeCommand(io: io, user: user))
app.register(command: PrintInfoCommand(io: io))
app.register(command: ConsoleExitCommand(io: io))

app.run(io: io)
