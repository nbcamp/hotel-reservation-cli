import Foundation

protocol UserInterface {
    static var shared: Self { get }

    func output(_ message: String)
    func input(_ prompt: String, validate: ((String) -> Bool)?) -> String
    func wait()
}

extension UserInterface {
    func input(_ prompt: String) -> String {
        return input(prompt, validate: nil)
    }
}
