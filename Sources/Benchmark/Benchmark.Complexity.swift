import Cardinal
import Numeric
import Sample

extension Benchmark {

    public enum Complexity {}
}

extension Benchmark.Complexity {
    public static func analyze(
        _ points: [Point],
        classes: [Class] = Class.allCases
    ) -> Evidence? {
        let valid =
            points
            .filter { $0.size > 0 && $0.observation.isFinite && $0.observation > 0 }
            .sorted { $0.size < $1.size }
        let logSizes = valid.map { Double.math.log2(Double(Int(clamping: $0.size))) }
        let logObservations = valid.map { Double.math.log2($0.observation) }
        guard
            let exponentFit = try? Sample.Regression.linear(
                Array(zip(logSizes, logObservations).map { (x: $0, y: $1) })
            )
        else { return nil }
        let observations = valid.map { $0.observation }
        var candidates = classes.map { complexity in
            Evidence.Candidate(
                complexity: complexity,
                fit: fit(
                    x: valid.map { complexity.transform(Double(Int(clamping: $0.size))) },
                    y: observations
                )
            )
        }
        candidates.sort { $0.fit.rSquared > $1.fit.rSquared }
        let trend = Sample.Trend.mannKendall(valid) { $0.observation }
        return .init(
            exponent: .init(value: exponentFit.slope, fit: exponentFit),
            candidates: candidates,
            trend: trend,
            points: valid
        )
    }

    /// The least-squares fit of `y` on `x`, for at least two points with
    /// at least two distinct sizes.
    ///
    /// When every `x` is equal, as for the constant class, `y` does not
    /// depend on `x`, and the best fit is the horizontal line through the
    /// mean of `y`, which explains none of its variance.
    private static func fit(x: [Double], y: [Double]) -> Sample.Regression.Fit {
        do {
            return try Sample.Regression.linear(Array(zip(x, y).map { (x: $0, y: $1) }))
        } catch {
            let n = Double(y.count)
            let mean = y.reduce(0, +) / n
            let sumOfSquares = y.reduce(0.0) { $0 + ($1 - mean) * ($1 - mean) }
            return Sample.Regression.Fit(
                slope: 0,
                intercept: mean,
                rSquared: 0,
                meanSquaredError: sumOfSquares / (n - 1)
            )
        }
    }
}
