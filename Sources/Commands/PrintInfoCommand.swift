import Foundation

class PrintInfoCommand: Command {
    var name: String { "호텔 객실 정보 조회" }
    
    var io: IOInterface

    init(io: IOInterface) {
        self.io = io
    }
    
    func execute() {
        io.output("\n[\(name) 서비스]")
        io.output("1박 기준 금액입니다.")
        io.output("1번 객실 10,000원")
        io.output("2번 객실 20,000원")
        io.output("3번 객실 30,000원")
        io.output("4번 객실 40,000원")
        io.output("5번 객실 50,000원")
        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }
}
