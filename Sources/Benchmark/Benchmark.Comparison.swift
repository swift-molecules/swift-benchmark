extension Benchmark {

    public enum Comparison: Sendable, Hashable, Codable {
        case improved
        case unchanged
        case regressed
        case inconclusive
    }
}
