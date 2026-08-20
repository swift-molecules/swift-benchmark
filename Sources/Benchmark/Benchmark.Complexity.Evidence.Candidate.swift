// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Sample_Primitives

extension Benchmark.Complexity.Evidence {
    public struct Candidate: Sendable, Hashable {
        public let complexity: Benchmark.Complexity.Class
        public let fit: Sample.Regression.Fit

        public init(complexity: Benchmark.Complexity.Class, fit: Sample.Regression.Fit) {
            self.complexity = complexity
            self.fit = fit
        }
    }
}
