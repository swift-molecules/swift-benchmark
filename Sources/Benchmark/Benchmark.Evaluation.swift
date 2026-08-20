// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// A typed comparison policy supplied by the metric-owning relation.
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
