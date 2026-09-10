public import Sample_Primitives

extension Benchmark.Complexity {
    public struct Exponent: Sendable, Hashable {
        public let value: Double
        public let fit: Sample.Regression.Fit

        public init(value: Double, fit: Sample.Regression.Fit) {
            self.value = value
            self.fit = fit
        }
    }
}
