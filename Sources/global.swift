import Foundation

typealias ID = Int

extension Date {
    var unixtime: Int { Int(self.timeIntervalSince1970) }
    var timestamp: Int { Int(self.timeIntervalSince1970  * 1000) }
}

