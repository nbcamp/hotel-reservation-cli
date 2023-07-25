import Foundation

struct MyReservationsCommand: Command {
    var name: String { "나의 예약 목록" }

    let io: IOInterface
    let userRepo: Repository<User>
    let roomRepo: Repository<Room>
    let reservationRepo: Repository<Reservation>
    let orderBy: String? = nil

    func execute() {
        let user = userRepo.findOne(where: ["name": "jinyongp"])!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"

        io.output("\n[\(name) 서비스]")
        io.output("----------------------------------")

        var reservations = reservationRepo.findAll(where: ["userId": user.id])
        if reservations.count > 0 {
//            if orderBy != nil {
//                reservations.sort(by: { (res1, res2) in res1[orderBy!] - res2[orderBy!] })
//            }
            for reservation in reservations {
                guard let room = roomRepo.findOne(where: ["id": reservation.roomId]) else { continue }
                io.output("[\(room.id)번 객실]")
                io.output("체크인: \(formatter.string(from: Date(timeIntervalSince1970: Double(reservation.checkIn))))")
                io.output("체크아웃: \(formatter.string(from: Date(timeIntervalSince1970: Double(reservation.checkOut))))\n")
                io.output("가격: \(room.price)")
            }
        } else {
            io.output("예약하신 객실이 없습니다.")
        }

        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }
}
