import Foundation

struct ConsoleExitCommand: Command {
    var name: String { "프로그램 종료" }
    
    let io: IOInterface
    
    func execute() {
        io.output("프로그램을 종료합니다. 감사합니다.")
        exit(0)
    }
}
