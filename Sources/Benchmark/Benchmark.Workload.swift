extension Benchmark {

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
