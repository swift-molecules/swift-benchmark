extension Benchmark.Iteration {
    public enum Phase: String, Sendable, Hashable, Codable {
        case warmup
        case measurement
    }
}
