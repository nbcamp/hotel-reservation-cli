import Foundation

let app = App.shared

app
    .setUserInterface(interface: TerminalInterface.shared)
    .registerCommand(
        command: ChargeCommand(
            userModel: UserModel.shared,
            userInterface: TerminalInterface.shared
        )
    )
    .registerCommand(
        command: PrintInfoCommand(
            userInterface: TerminalInterface.shared
        )
    )
    .run()
