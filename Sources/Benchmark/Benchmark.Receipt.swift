// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// The observed result and exact iteration identities of one execution.
    public struct Receipt<Observation: Sendable>: Sendable {
        public let measurement: Benchmark.Measurement<Observation>
        public let iterations: [Benchmark.Iteration]

        public init(
            measurement: Benchmark.Measurement<Observation>,
            iterations: [Benchmark.Iteration]
        ) {
            self.measurement = measurement
            self.iterations = iterations
        }
    }
}
