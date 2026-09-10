public import Sample_Primitives

extension Benchmark.Complexity {

    public struct Evidence: Sendable {
        public let exponent: Exponent
        public let candidates: [Candidate]
        public let trend: Sample.Trend
        public let points: [Point]

        public init(
            exponent: Exponent,
            candidates: [Candidate],
            trend: Sample.Trend,
            points: [Point]
        ) {
            self.exponent = exponent
            self.candidates = candidates
            self.trend = trend
            self.points = points
        }
    }
}
