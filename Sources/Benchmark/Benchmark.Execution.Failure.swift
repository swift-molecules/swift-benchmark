extension Benchmark.Execution {
    public enum Failure<
        Workload: Swift.Error,
        Probe: Swift.Error
    >: Swift.Error {
        case workload(Workload)
        case probe(Probe)
    }
}
