extension Benchmark {

    public struct Evaluation<Value: Sendable>: Sendable {
        public let compare: @Sendable (_ current: Value, _ baseline: Value) -> Benchmark.Comparison

        public init(
            compare: @escaping @Sendable (_ current: Value, _ baseline: Value) -> Benchmark.Comparison
        ) {
            self.compare = compare
        }

    }
}

extension Benchmark.Evaluation {
    public func callAsFunction(
            current: Value,
            baseline: Benchmark.Baseline<Value>
        ) -> Benchmark.Comparison {
            compare(current, baseline.value)
    }
}
