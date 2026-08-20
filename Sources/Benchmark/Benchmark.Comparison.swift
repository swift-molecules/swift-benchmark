// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// Metric-independent comparison outcome.
    public enum Comparison: Sendable, Hashable, Codable {
        case improved
        case unchanged
        case regressed
        case inconclusive
    }
}
