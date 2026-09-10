public import Cardinal_Primitives

extension Benchmark.History {

    public struct Entry: Sendable {
        public let sequence: Cardinal
        public let value: Value

        public init(sequence: Cardinal, value: Value) {
            self.sequence = sequence
            self.value = value
        }
    }
}

extension Benchmark.History.Entry: Equatable where Value: Equatable {}
extension Benchmark.History.Entry: Hashable where Value: Hashable {}
