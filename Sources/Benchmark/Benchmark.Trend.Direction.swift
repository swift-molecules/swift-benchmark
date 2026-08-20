// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark.Trend {
    public enum Direction: Sendable, Hashable, Codable {
        case improving
        case stable
        case regressing
    }
}
