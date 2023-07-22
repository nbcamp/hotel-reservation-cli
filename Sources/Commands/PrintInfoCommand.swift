import Foundation

class PrintInfoCommand: Command {
    var name: String { "호텔 객실 정보 조회" }
    
    var io: IOInterface
    var rooms: [Room]

    init(io: IOInterface, rooms: [Room]) {
        self.io = io
        self.rooms = rooms
    }
    
    func execute() {
        io.output("\n[\(name) 서비스]")
        io.output("1박 기준 금액입니다.")
        
        for room in rooms {
            io.output("\(room.id)번 객실 \(room.price)원")
        }

        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }
}
