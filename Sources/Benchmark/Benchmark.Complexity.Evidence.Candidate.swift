public import Sample_Primitives

extension Benchmark.Complexity.Evidence {
    public struct Candidate: Sendable, Hashable {
        public let complexity: Benchmark.Complexity.Class
        public let fit: Sample.Regression.Fit

        public init(complexity: Benchmark.Complexity.Class, fit: Sample.Regression.Fit) {
            self.complexity = complexity
            self.fit = fit
        }
    }
}
