import Foundation

class TerminalInterface: IOInterface {
    static let shared: TerminalInterface = TerminalInterface()
    
    func output(_ message: String) {
        print(message)
    }

    func input(_ prompt: String, validate: ((String) -> Bool)? = nil) -> String {
        while true {
            print(prompt, terminator: "")
            guard let input = readLine() else { exit(1) }
            guard input.count > 0 else { continue }
            
            if validate?(input) != false {
                return input
            }
        }
    }
    
    func wait() {
        _ = readLine()
    }
    
    private init() {}
}
