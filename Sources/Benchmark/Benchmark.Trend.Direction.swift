extension Benchmark.Trend {
    public enum Direction: Sendable, Hashable, Codable {
        case improving
        case stable
        case regressing
    }
}
