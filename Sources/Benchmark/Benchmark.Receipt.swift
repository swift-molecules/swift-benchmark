extension Benchmark {

    public struct Receipt<Observation: Sendable>: Sendable {
        public let measurement: Benchmark.Measurement<Observation>
        public let iterations: [Benchmark.Iteration]

        public init(
            measurement: Benchmark.Measurement<Observation>,
            iterations: [Benchmark.Iteration]
        ) {
            self.measurement = measurement
            self.iterations = iterations
        }
    }
}
