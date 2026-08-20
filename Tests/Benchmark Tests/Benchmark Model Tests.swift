// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

import Benchmark
import Cardinal_Primitives
import Testing

@Suite
struct `Benchmark Model Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `plan rejects invalid and overflowing counts`() {
        #expect(throws: Benchmark.Plan.Error.emptyMeasurement) {
            try Benchmark.Plan(measurements: 0)
        }
        #expect(throws: Benchmark.Plan.Error.emptyBatch) {
            try Benchmark.Plan(batch: 0)
        }
        #expect(throws: Benchmark.Plan.Error.overflow) {
            try Benchmark.Plan(measurements: Cardinal(UInt(Int.max)), batch: 2)
        }
    }

    @Test
    func `typed measurement maps without erasing its value`() throws {
        let measurement = Benchmark.Measurement([1, 2, 3])
        let mapped = measurement.map(String.init)
        #expect(mapped.values == ["1", "2", "3"])
    }

    @Test
    func `baseline evaluation and history remain storage independent`() {
        let evaluation = Benchmark.Evaluation<Int> {
            if $0 < $1 { .improved } else if $0 > $1 { .regressed } else { .unchanged }
        }
        let baseline = Benchmark.Baseline(name: "main", value: 10)
        #expect(evaluation(current: 8, baseline: baseline) == .improved)

        let history = Benchmark.History(
            entries: [
                .init(sequence: 2, value: 12),
                .init(sequence: 1, value: 10),
            ]
        )
        #expect(history.latest?.value == 12)
    }

    struct Token: ~Copyable {
        let value: Int
    }

    @Test
    func `optimizer consumption accepts a noncopyable value`() {
        let token = Token(value: 42)
        Benchmark.consume(token)
    }
}
