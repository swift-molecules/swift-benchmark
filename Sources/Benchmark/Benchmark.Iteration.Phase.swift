extension Benchmark.Iteration {
    public enum Phase: String, Sendable, Hashable {
        case warmup
        case measurement
    }
}
