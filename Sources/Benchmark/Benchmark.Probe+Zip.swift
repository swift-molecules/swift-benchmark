// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark.Probe {
    /// Statically composes two independent probes around the same workload.
    public func zip<OtherState: Sendable, OtherObservation: Sendable, OtherFailure: Swift.Error>(
        _ other: Benchmark.Probe<OtherState, OtherObservation, OtherFailure>
    ) -> Benchmark.Probe<
        (State, OtherState),
        (Observation, OtherObservation),
        Benchmark.Failure<Failure, OtherFailure>
    > {
        .init(
            start: {
                switch self.start() {
                case .failure(let failure):
                    return .failure(.first(failure))
                case .success(let first):
                    switch other.start() {
                    case .failure(let failure):
                        self.cancel(first)
                        return .failure(.second(failure))
                    case .success(let second):
                        return .success((first, second))
                    }
                }
            },
            stop: { state in
                switch other.stop(state.1) {
                case .failure(let failure):
                    self.cancel(state.0)
                    return .failure(.second(failure))
                case .success(let second):
                    switch self.stop(state.0) {
                    case .failure(let failure):
                        return .failure(.first(failure))
                    case .success(let first):
                        return .success((first, second))
                    }
                }
            },
            cancel: { state in
                other.cancel(state.1)
                self.cancel(state.0)
            }
        )
    }
}
