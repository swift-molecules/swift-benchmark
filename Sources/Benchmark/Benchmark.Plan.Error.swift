// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark.Plan {
    public enum Error: Swift.Error, Equatable {
        case emptyMeasurement
        case emptyBatch
        case overflow
    }
}
