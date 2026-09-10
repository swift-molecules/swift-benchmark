extension Benchmark {

    public struct History<Value: Sendable>: Sendable {
        public let entries: [Entry]

        public init(entries: [Entry]) {
            self.entries = entries.sorted { $0.sequence < $1.sequence }
        }

    }
}

extension Benchmark.History {
    public var latest: Entry? { entries.last }
}

extension Benchmark.History: Equatable where Value: Equatable {}
extension Benchmark.History: Hashable where Value: Hashable {}
