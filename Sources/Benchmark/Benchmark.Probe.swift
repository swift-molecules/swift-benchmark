extension Benchmark {

    public struct Probe<State: Sendable, Observation: Sendable, Failure: Swift::Error>: Sendable {
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

extension Benchmark.Probe {

    public func zip<OtherState: Sendable, OtherObservation: Sendable, OtherFailure: Swift::Error>(
        _ other: Benchmark.Probe<OtherState, OtherObservation, OtherFailure>
    )
        -> Benchmark.Probe<
            (State, OtherState),
            (Observation, OtherObservation),
            Benchmark.Failure<Failure, OtherFailure>
        >
    {
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
