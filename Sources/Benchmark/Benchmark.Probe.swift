// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// A typed observation lifecycle independent of any concrete metric.
    public struct Probe<State: Sendable, Observation: Sendable, Failure: Swift.Error>: Sendable {
        public let start: @Sendable () -> Result<State, Failure>
        public let stop: @Sendable (consuming State) -> Result<Observation, Failure>
        public let cancel: @Sendable (consuming State) -> Void

        public init(
            start: @escaping @Sendable () -> Result<State, Failure>,
            stop: @escaping @Sendable (consuming State) -> Result<Observation, Failure>,
            cancel: @escaping @Sendable (consuming State) -> Void = { _ in }
        ) {
            self.start = start
            self.stop = stop
            self.cancel = cancel
        }

    }
}
