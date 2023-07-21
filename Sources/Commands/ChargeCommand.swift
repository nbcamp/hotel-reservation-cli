import Foundation

class ChargeCommand: Command {
    var name: String { "호텔 포인트 충전" }

    var userModel: UserModel
    var userInterface: UserInterface

    init(
        userModel: UserModel,
        userInterface: UserInterface
    ) {
        self.userModel = userModel
        self.userInterface = userInterface
    }

    func execute() {
        userInterface.output("\n[\(name) 서비스]")
        userInterface.output("현재 보유 중이신 포인트는 \(userModel.point)P 입니다.")
        while true {
            let input = userInterface.input(
                "충전할 포인트를 입력해주세요. (0 = 랜덤, -1 = 취소)\n금액: ",
                validate: { (Int($0) != nil && Int($0)! >= -1) }
            )
            var value: Int
            switch Int(input) {
            case let val? where val == 0:
                value = Int.random(in: 1 ... 5) * 100_000
            case let val? where val == -1:
                return userInterface.output("포인트 충전을 취소합니다.\n")
            case let val?:
                value = val
            default:
                continue
            }
            
            let updatedPoint = userModel.point + value
            if let error = userModel.updatePoint(updatedPoint) {
                userInterface.output("Error: \(error)")
                continue
            }
            break
        }
        userInterface.output("\n포인트 충전에 성공했습니다. 총 보유하신 포인트: \(userModel.point)P")
        userInterface.output("계속하려면 엔터를 눌러주세요...")
        userInterface.wait()
    }
}
