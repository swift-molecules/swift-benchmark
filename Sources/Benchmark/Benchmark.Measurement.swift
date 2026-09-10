public import Sample_Primitives

extension Benchmark {

    public struct Measurement<Value: Sendable>: Sendable {
        public let values: [Value]

        public init(_ values: [Value]) {
            self.values = values
        }

    }
}

extension Benchmark.Measurement {
    public func map<Mapped: Sendable>(
        _ transform: (Value) -> Mapped
    ) -> Benchmark.Measurement<Mapped> {
        .init(values.map(transform))
    }

    public func sample(
        sortedBy comparator: Order.Comparator<Value>
    ) -> Sample.Batch<Value> {
        .init(values, sortedBy: comparator)
    }
}
