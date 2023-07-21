import Foundation

let app = App.shared

let interface = TerminalInterface.shared

app.register(command: ChargeCommand(
    user: User.shared,
    io: interface
))

app.register(command: PrintInfoCommand(
    io: interface
))

app.run(io: TerminalInterface.shared)
