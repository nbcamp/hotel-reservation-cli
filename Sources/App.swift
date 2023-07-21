import Foundation

class App {
    static let shared = App()

    var interface: UserInterface?
    var commands: [Command] = []

    @discardableResult
    func setUserInterface(interface: UserInterface) -> Self {
        self.interface = interface
        return self
    }

    @discardableResult
    func registerCommand(command: Command) -> Self {
        commands.append(command)
        return self
    }
    
    func run() {
        guard let io = interface  else {
            print("[App] Need to initialize UserInterface")
            exit(1)
        }

        while true {
            let command = chooseService(io: io)
            command.execute()
        }
        
    }
    
    private func chooseService(io: UserInterface) -> Command {
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
