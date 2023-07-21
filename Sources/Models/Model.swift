protocol Model {}

extension Model {
    var id: ID { Identifier.shared.get(model: self) }
}
