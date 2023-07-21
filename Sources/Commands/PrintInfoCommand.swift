import Foundation

class PrintInfoCommand: Command {
    var name: String { "호텔 객실 정보 조회" }
    
    var userInterface: UserInterface

    init(userInterface: UserInterface) {
        self.userInterface = userInterface
    }
    
    func execute() {
        userInterface.output("\n[호텔 객실 정보 조회]")
        userInterface.output("1박 기준 금액입니다.")
        userInterface.output("1번 객실 10,000원")
        userInterface.output("2번 객실 20,000원")
        userInterface.output("3번 객실 30,000원")
        userInterface.output("4번 객실 40,000원")
        userInterface.output("5번 객실 50,000원")
        userInterface.output("계속하려면 엔터를 눌러주세요...")
        userInterface.wait()
    }
}
