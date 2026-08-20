// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Sample_Primitives

extension Benchmark.Complexity {
    public struct Exponent: Sendable, Hashable {
        public let value: Double
        public let fit: Sample.Regression.Fit

        public init(value: Double, fit: Sample.Regression.Fit) {
            self.value = value
            self.fit = fit
        }
    }
}
