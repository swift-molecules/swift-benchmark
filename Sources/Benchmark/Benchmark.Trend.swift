// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Sample_Primitives

extension Benchmark {
    /// Benchmark-domain interpretation of canonical Sample trend evidence.
    public struct Trend: Sendable, Hashable {
        public let evidence: Sample.Trend
        public let direction: Direction

        public init(
            evidence: Sample.Trend,
            regression: Regression = .increasing,
            significance: Double = 1.96
        ) {
            self.evidence = evidence
            if evidence.standardized.magnitude <= significance {
                self.direction = .stable
            } else if (evidence.standardized > 0) == (regression == .increasing) {
                self.direction = .regressing
            } else {
                self.direction = .improving
            }
        }
    }
}
