protocol Database {
    @discardableResult
    func execute(_ query: String, params: [String]) -> [[String: Any]]?
}

extension Database {
    @discardableResult
    func execute(_ query: String) -> [[String: Any]]? {
        return execute(query, params: [])
    }
}
