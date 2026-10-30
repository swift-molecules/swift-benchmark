extension Benchmark.Trend {
    public enum Direction: Sendable, Hashable {
        case improving
        case stable
        case regressing
    }
}

#if !hasFeature(Embedded)
    extension Benchmark.Trend.Direction: Codable {}
#endif
