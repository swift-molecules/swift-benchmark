extension Benchmark.Iteration {
    public enum Phase: String, Sendable, Hashable {
        case warmup
        case measurement
    }
}

#if !hasFeature(Embedded)
    extension Benchmark.Iteration.Phase: Codable {}
#endif
