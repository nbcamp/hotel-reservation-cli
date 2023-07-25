import Foundation

struct ReservationCommand: Command {
    var name: String { "호텔 객실 예약" }

    let io: IOInterface
    let userRepo: Repository<User>
    let roomRepo: Repository<Room>
    let reservationRepo: Repository<Reservation>

    func execute() {
        var user = userRepo.findOne(where: ["name": "jinyongp"])!
        let rooms = roomRepo.findAll()

        io.output("\n[\(name) 서비스]")
        io.output("현재 보유 중이신 포인트는 \(user.point)P 입니다.")
        io.output("예약을 원하시는 호텔 객실 번호, 체크인 날짜, 체크아웃 날짜를 입력해주세요.\n")
        io.output("-----------------")
        let roomNumber = inputNumber(min: 1, max: rooms.count)
        let room = rooms[roomNumber - 1]

        if user.point < room.price {
            io.output("보유하신 포인트가 부족합니다. 포인트를 추가해주세요.")
            io.output("계속하시려면 엔터를 눌러주세요...")
            io.wait()
            return
        }

        let checkIn = inputDate(label: "체크인 날짜")
        let checkOut = inputDate(label: "체크아웃 날짜")

        io.output("\n입력하신 정보는 다음과 같습니다.")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        io.output("----------------------")
        io.output("객실번호: \(room.id)")
        io.output("체크인: \(formatter.string(from: checkIn))")
        io.output("체크아웃: \(formatter.string(from: checkOut))")
        io.output("----------------------")
        let input = io.input("입력하신 정보로 예약을 계속하시겠습니까? (Y/n): ", validate: {
            $0 == "" || $0 == "Y" || $0 == "n"
        })
        if input == "n" {
            io.output("예약을 취소합니다.")
            io.output("계속하시려면 엔터를 눌러주세요...")
            io.wait()
            return
        } else {
            reservationRepo.create(entity: Reservation(
                userId: user.id,
                roomId: room.id,
                checkIn: checkIn.unixtime,
                checkOut: checkOut.unixtime
            ))
            user.point -= room.price
            userRepo.update(entity: user)
        }

        io.output("\n호텔 예약에 성공하였습니다.")
        io.output("계속하시려면 엔터를 눌러주세요...")
        io.wait()
    }

    private func inputNumber(min: Int, max: Int) -> Int {
        let input = io.input("객실번호: ", validate: {
            guard let num = Int($0) else { return false }
            return min <= num && num <= max
        })
        return Int(input)!
    }

    private func inputDate(label: String) -> Date {
        let formatter = DateFormatter()
        let dateFormat = "yyyy/MM/dd HH:mm"
        formatter.dateFormat = dateFormat
        let input = io.input("\(label)(\(dateFormat)): ", validate: {
            formatter.date(from: $0) != nil
        })
        return formatter.date(from: input)!
    }
}
