import Foundation

class App {
    static let shared = App()

    var commands: [Command] = []

    func register(command: Command) {
        commands.append(command)
    }

    func run(io: IOInterface) {
        while true {
            let command = chooseService(io: io)
            command.execute()
        }
        
    }

    private func chooseService(io: IOInterface) -> Command {
        io.output("------Welcome------")
        for (index, command) in commands.enumerated() {
            io.output("\(index + 1). \(command.name)")
        }
        io.output("-------------------")

        let input = io.input("입력: ", validate: {
            guard let value = Int($0) else { return false }
            return Int($0) != nil && (0 < value && value <= self.commands.count)
        })

        return commands[Int(input)! - 1]
    }

    private init() {}
}
