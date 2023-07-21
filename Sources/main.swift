import Foundation

let app = App.shared

let io = TerminalInterface.shared

app.register(command: ChargeCommand(io: io, user: User.shared))
app.register(command: PrintInfoCommand(io: io))
app.register(command: ConsoleExitCommand(io: io))

app.run(io: io)
