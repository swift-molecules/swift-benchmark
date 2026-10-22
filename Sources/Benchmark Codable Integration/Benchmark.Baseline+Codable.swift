public import Benchmark

extension Benchmark.Baseline: Codable where Value: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: Benchmark.Coding.Key.self)
        self.init(
            name: try container.decode(String.self, forKey: .init("name")),
            value: try container.decode(Value.self, forKey: .init("value"))
        )
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: Benchmark.Coding.Key.self)
        try container.encode(name, forKey: .init("name"))
        try container.encode(value, forKey: .init("value"))
    }
}
