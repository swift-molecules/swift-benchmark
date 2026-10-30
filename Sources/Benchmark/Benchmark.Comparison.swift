extension Benchmark {

    public enum Comparison: Sendable, Hashable {
        case improved
        case unchanged
        case regressed
        case inconclusive
    }
}

#if !hasFeature(Embedded)
    extension Benchmark.Comparison: Codable {}
#endif
