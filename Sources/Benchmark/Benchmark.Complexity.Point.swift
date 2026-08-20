// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Cardinal_Primitives

extension Benchmark.Complexity {
    /// One metric-independent size/observation pair.
    public struct Point: Sendable, Hashable {
        public let size: Cardinal
        public let observation: Double

        public init(size: Cardinal, observation: Double) {
            self.size = size
            self.observation = observation
        }
    }
}
