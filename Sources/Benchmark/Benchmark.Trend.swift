public import Sample_Primitives

extension Benchmark {

    public struct Trend: Sendable, Hashable {
        public let evidence: Sample.Trend
        public let direction: Direction

        public init(
            evidence: Sample.Trend,
            regression: Regression = .increasing,
            significance: Double = 1.96
        ) {
            self.evidence = evidence
            if evidence.standardized.magnitude <= significance {
                self.direction = .stable
            } else if (evidence.standardized > 0) == (regression == .increasing) {
                self.direction = .regressing
            } else {
                self.direction = .improving
            }
        }
    }
}
