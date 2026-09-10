extension Benchmark {

    public struct Baseline<Value: Sendable>: Sendable {
        public let name: String
        public let value: Value

        public init(name: String, value: Value) {
            self.name = name
            self.value = value
        }
    }
}

extension Benchmark.Baseline: Equatable where Value: Equatable {}
extension Benchmark.Baseline: Hashable where Value: Hashable {}
extension Benchmark.Baseline: Codable where Value: Codable {}
