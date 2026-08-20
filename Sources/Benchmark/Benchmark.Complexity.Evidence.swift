// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Sample_Primitives

extension Benchmark.Complexity {
    /// Pure fitted complexity evidence, without pass/fail policy.
    public struct Evidence: Sendable {
        public let exponent: Exponent
        public let candidates: [Candidate]
        public let trend: Sample.Trend
        public let points: [Point]

        public init(
            exponent: Exponent,
            candidates: [Candidate],
            trend: Sample.Trend,
            points: [Point]
        ) {
            self.exponent = exponent
            self.candidates = candidates
            self.trend = trend
            self.points = points
        }
    }
}
