// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Sample_Primitives

extension Benchmark {
    /// Ordered typed observations from measured iterations.
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

    /// Projects the observations into the canonical Sample batch owner.
    public func sample(
        sortedBy comparator: Order.Comparator<Value>
    ) -> Sample.Batch<Value> {
        .init(values, sortedBy: comparator)
    }
}
