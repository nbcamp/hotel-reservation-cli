protocol Storage {
    static var shared: Self { get }

    func getItem(key: String) -> String?
    func setItem(key: String, value: String)
    func removeItem(key: String)
    func clear()
}
