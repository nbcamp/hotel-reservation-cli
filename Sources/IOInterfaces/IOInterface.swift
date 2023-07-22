import Foundation

protocol IOInterface {
    func output(_ message: String)
    func input(_ prompt: String, validate: ((String) -> Bool)?) -> String
    func wait()
}

extension IOInterface {
    func input(_ prompt: String) -> String {
        return input(prompt, validate: nil)
    }
}
