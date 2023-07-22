import Foundation

class PrintInfoCommand: Command {
    var name: String { "호텔 객실 정보 조회" }
    
    var io: IOInterface
    var roomRepo: Repository<Room>

    init(io: IOInterface, roomRepo: Repository<Room>) {
        self.io = io
        self.roomRepo = roomRepo
    }
    
    func execute() {
        io.output("\n[\(name) 서비스]")
        io.output("1박 기준 금액입니다.")
        for room in roomRepo.findAll() {
            io.output("\(room.id)번 객실 \(room.price)원")
        }
        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }
}
