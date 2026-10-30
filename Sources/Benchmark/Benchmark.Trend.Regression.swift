extension Benchmark.Trend {
    public enum Regression: Sendable, Hashable {
        case increasing
        case decreasing
    }
}

#if !hasFeature(Embedded)
    extension Benchmark.Trend.Regression: Codable {}
#endif
