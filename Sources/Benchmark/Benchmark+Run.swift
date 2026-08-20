// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

import Cardinal_Primitives

extension Benchmark {
    /// Runs warmups without observation, then observes each measured batch once.
    public static func run<
        WorkloadState: Sendable,
        WorkloadFailure: Swift.Error,
        ProbeState: Sendable,
        Observation: Sendable,
        ProbeFailure: Swift.Error
    >(
        plan: Benchmark.Plan,
        workload: Benchmark.Workload<WorkloadState, WorkloadFailure>,
        probe: Benchmark.Probe<ProbeState, Observation, ProbeFailure>
    ) throws(Benchmark.Execution.Failure<WorkloadFailure, ProbeFailure>) -> Benchmark.Receipt<Observation> {
        var iterations: [Benchmark.Iteration] = []
        var observations: [Observation] = []
        let warmupCount = Int(clamping: plan.warmup)
        let measurementCount = Int(clamping: plan.measurements)
        let batchCount = Int(clamping: plan.batch)
        iterations.reserveCapacity(warmupCount + measurementCount)
        observations.reserveCapacity(measurementCount)

        for index in 0..<warmupCount {
            let iteration = Benchmark.Iteration(
                phase: .warmup,
                index: Cardinal(UInt(index)),
                batch: plan.batch
            )
            iterations.append(iteration)
            do throws(WorkloadFailure) {
                var state = try workload.setup()
                for _ in 0..<batchCount { try workload.operation(&state) }
                try workload.teardown(state)
            } catch {
                throw .workload(error)
            }
        }

        for index in 0..<measurementCount {
            let iteration = Benchmark.Iteration(
                phase: .measurement,
                index: Cardinal(UInt(index)),
                batch: plan.batch
            )
            iterations.append(iteration)

            var state: WorkloadState
            do throws(WorkloadFailure) { state = try workload.setup() } catch {
                throw .workload(error)
            }

            let probeState: ProbeState
            switch probe.start() {
            case .success(let value):
                probeState = value
            case .failure(let failure):
                do throws(WorkloadFailure) {
                    try workload.teardown(state)
                } catch {
                    throw .workload(error)
                }
                throw .probe(failure)
            }

            do throws(WorkloadFailure) {
                for _ in 0..<batchCount { try workload.operation(&state) }
            } catch {
                probe.cancel(probeState)
                do throws(WorkloadFailure) {
                    try workload.teardown(state)
                } catch {}
                throw .workload(error)
            }

            let observation: Observation
            switch probe.stop(probeState) {
            case .success(let value):
                observation = value
            case .failure(let failure):
                do throws(WorkloadFailure) {
                    try workload.teardown(state)
                } catch {
                    throw .workload(error)
                }
                throw .probe(failure)
            }

            do throws(WorkloadFailure) {
                try workload.teardown(state)
            } catch {
                throw .workload(error)
            }
            observations.append(observation)
        }

        return .init(measurement: .init(observations), iterations: iterations)
    }
}
