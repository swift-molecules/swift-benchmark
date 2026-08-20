// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

import Benchmark
import Cardinal_Primitives
import Testing

@Suite
struct `Benchmark Execution Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    final class Counts: @unchecked Sendable {
        var setups = 0
        var operations = 0
        var teardowns = 0
        var cancellations = 0
    }

    enum Failure: Swift.Error {
        case failed
    }

    @Test
    func `warmups, measured iterations, and batches execute exactly`() throws {
        let counts = Counts()
        let plan = try Benchmark.Plan(
            warmup: 1,
            measurements: 2,
            batch: 3
        )
        let workload = Benchmark.Workload<Int, Never>(
            setup: {
                counts.setups += 1
                return 0
            },
            operation: { state in
                counts.operations += 1
                state += 1
            },
            teardown: { state in
                counts.teardowns += 1
                #expect(state == 3)
            }
        )
        let probe = Benchmark.Probe<Int, Int, Never>(
            start: { .success(counts.operations) },
            stop: { start in .success(counts.operations - start) }
        )

        let execution = try Benchmark.run(plan: plan, workload: workload, probe: probe)

        #expect(counts.setups == 3)
        #expect(counts.operations == 9)
        #expect(counts.teardowns == 3)
        #expect(execution.measurement.values == [3, 3])
        #expect(execution.iterations.map(\.phase) == [.warmup, .measurement, .measurement])
        #expect(plan.work == 6)
    }

    @Test
    func `probe composition observes one workload execution`() throws {
        let plan = try Benchmark.Plan(warmup: 0, measurements: 1)
        let counts = Counts()
        let workload = Benchmark.Workload<Int, Never>(
            setup: { 0 },
            operation: {
                $0 += 1
                counts.operations += 1
            },
            teardown: { _ in }
        )
        let first = Benchmark.Probe<Int, Int, Never>(
            start: { .success(counts.operations) },
            stop: { .success(counts.operations - $0) }
        )
        let second = Benchmark.Probe<Int, String, Never>(
            start: { .success(counts.operations) },
            stop: { _ in .success("observed") }
        )

        let execution = try Benchmark.run(
            plan: plan,
            workload: workload,
            probe: first.zip(second)
        )

        #expect(counts.operations == 1)
        #expect(execution.measurement.values.first?.0 == 1)
        #expect(execution.measurement.values.first?.1 == "observed")
    }

    @Test
    func `workload failure cancels the active probe and tears down`() throws {
        let counts = Counts()
        let plan = try Benchmark.Plan(warmup: 0, measurements: 1)
        let workload = Benchmark.Workload<Int, Failure>(
            setup: { 0 },
            operation: { (_: inout Int) throws(Failure) -> Void in
                throw Failure.failed
            },
            teardown: { _ in counts.teardowns += 1 }
        )
        let probe = Benchmark.Probe<Int, Int, Never>(
            start: { .success(0) },
            stop: { .success($0) },
            cancel: { _ in counts.cancellations += 1 }
        )

        #expect(throws: Benchmark.Execution.Failure<Failure, Never>.self) {
            try Benchmark.run(plan: plan, workload: workload, probe: probe)
        }
        #expect(counts.cancellations == 1)
        #expect(counts.teardowns == 1)
    }
}
