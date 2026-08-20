// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

import Benchmark
import Cardinal_Primitives
import Sample_Primitives
import Testing

@Suite
struct `Benchmark Complexity Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `linear and quadratic controls produce their expected exponents`() throws {
        let linear = Benchmark.Complexity.analyze(
            [UInt(1), 2, 4, 8].map {
                .init(size: Cardinal($0), observation: Double($0))
            }
        )
        let quadratic = Benchmark.Complexity.analyze(
            [UInt(1), 2, 4, 8].map {
                .init(size: Cardinal($0), observation: Double($0 * $0))
            }
        )

        #expect(abs(try #require(linear).exponent.value - 1) < 0.000_001)
        #expect(abs(try #require(quadratic).exponent.value - 2) < 0.000_001)
        #expect(linear?.candidates.first?.complexity == .linear)
        #expect(quadratic?.candidates.first?.complexity == .quadratic)
    }

    @Test
    func `insufficient and nonfinite evidence is inconclusive`() {
        #expect(Benchmark.Complexity.analyze([]) == nil)
        #expect(
            Benchmark.Complexity.analyze([
                .init(size: 1, observation: .nan),
                .init(size: 2, observation: .infinity),
            ]) == nil
        )
    }

    @Test
    func `benchmark trend interprets canonical Sample evidence`() {
        let evidence = Sample.Trend.mannKendall([1.0, 2, 3, 4, 5], value: { $0 })
        let trend = Benchmark.Trend(evidence: evidence, significance: 0)
        #expect(trend.direction == .regressing)
    }
}
