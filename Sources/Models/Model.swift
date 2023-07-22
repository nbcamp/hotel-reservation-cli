import Foundation

protocol Model: Codable {
    static var name: String { get }
    var id: ID { get set }
}

struct ModelIterator: IteratorProtocol, Sequence {
    private var iterator: Mirror.Children.Iterator

    init(_ model: any Model) {
        self.iterator = Mirror(reflecting: model).children.makeIterator()
    }

    mutating func next() -> (prop: String, value: Any)? {
        guard let child = iterator.next() else { return nil }
        guard case let (prop?, value) = child else { return nil }
        return (prop, value)
    }
}

extension Model {
    var _key: String { String(describing: type(of: Self.self)) }

    static func instantiate(dict: [String: Any]) -> Self? {
        guard let serialized = try? JSONSerialization.data(withJSONObject: dict) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let instance = try? decoder.decode(Self.self, from: serialized) else { return nil }
        return instance
    }

    func entries() -> ModelIterator {
        return ModelIterator(self)
    }
}
