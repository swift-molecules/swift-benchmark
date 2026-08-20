// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// Explicit setup, measured operation, and teardown lifecycle.
    public struct Workload<State: Sendable, Failure: Swift.Error>: Sendable {
        public let setup: @Sendable () throws(Failure) -> State
        public let operation: @Sendable (inout State) throws(Failure) -> Void
        public let teardown: @Sendable (consuming State) throws(Failure) -> Void

        public init(
            setup: @escaping @Sendable () throws(Failure) -> State,
            operation: @escaping @Sendable (inout State) throws(Failure) -> Void,
            teardown: @escaping @Sendable (consuming State) throws(Failure) -> Void
        ) {
            self.setup = setup
            self.operation = operation
            self.teardown = teardown
        }
    }
}
