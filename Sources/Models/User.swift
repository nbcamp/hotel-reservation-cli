import Foundation

enum PointError: Error {
    case invalidFormat
    case lackOfBalance
}

class User {
    static let shared = User()

    private(set) var id: ID = 1
    private(set) var point = 0

    func updatePoint(_ amount: Int) -> String? {
        guard amount > 0 else {
            return "올바른 금액을 입력해주세요."
        }
        
        self.point = amount
        return nil
    }
    
    private init() {}
}
