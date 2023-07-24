import Foundation

struct ChargeCommand: Command {
    var name: String { "호텔 포인트 충전" }

    let io: IOInterface
    let userRepo: Repository<User>

    func execute() {
        var user = userRepo.findOne(where: ["name": "jinyongp"])!
        
        io.output("\n[\(name) 서비스]")
        io.output("현재 보유 중이신 포인트는 \(user.point)P 입니다.")
        while true {
            let input = io.input(
                "충전할 포인트를 입력해주세요. (0 = 랜덤, -1 = 취소)\n금액: ",
                validate: { (Int($0) != nil && Int($0)! >= -1) }
            )
            var value: Int
            switch Int(input) {
            case let val? where val == 0:
                value = Int.random(in: 1 ... 5) * 100_000
            case let val? where val == -1:
                return io.output("포인트 충전을 취소합니다.\n")
            case let val?:
                value = val
            default:
                continue
            }
            
            let point = user.point + value
            if point < 0 {
                io.output("[ERROR] 0보다 작은 값으로 변경할 수 없습니다.")
                continue
            }
            user.point = point
            userRepo.update(entity: user)
            break
        }
        io.output("\n포인트 충전에 성공했습니다. 총 보유하신 포인트: \(user.point)P")
        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }
}
