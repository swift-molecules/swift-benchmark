import Benchmark
import Cardinal
import Sample
import Testing

@Suite
struct `Benchmark Complexity Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

    @Test
    func `linear and quadratic controls produce their expected exponents`() throws {
        let linear = Benchmark.Complexity.analyze(
            [UInt(1), 2, 4, 8].map {
                .init(size: Cardinal($0), observation: Double($0))
            }
        )
        let quadratic = Benchmark.Complexity.analyze(
            [UInt(1), 2, 4, 8].map {
                .init(size: Cardinal($0), observation: Double($0 * $0))
            }
        )

        #expect(abs(try #require(linear).exponent.value - 1) < 0.000_001)
        #expect(abs(try #require(quadratic).exponent.value - 2) < 0.000_001)
        #expect(linear?.candidates.first?.complexity == .linear)
        #expect(quadratic?.candidates.first?.complexity == .quadratic)
    }

    @Test
    func `insufficient and nonfinite evidence is inconclusive`() {
        #expect(Benchmark.Complexity.analyze([]) == nil)
        #expect(
            Benchmark.Complexity.analyze([
                .init(size: 1, observation: .nan),
                .init(size: 2, observation: .infinity),
            ]) == nil
        )
    }

    @Test
    func `a single distinct size is inconclusive`() {
        #expect(
            Benchmark.Complexity.analyze([
                .init(size: 4, observation: 1),
                .init(size: 4, observation: 2),
            ]) == nil
        )
    }

    @Test
    func `the constant class fits the horizontal line through the mean`() throws {
        let evidence = try #require(
            Benchmark.Complexity.analyze(
                [UInt(1), 2, 4, 8].map {
                    .init(size: Cardinal($0), observation: Double($0))
                },
                classes: [.constant]
            )
        )
        let fit = try #require(evidence.candidates.first).fit
        #expect(fit.slope == 0)
        #expect(fit.intercept == 3.75)
        #expect(fit.rSquared == 0)
        #expect(fit.meanSquaredError.isFinite)
    }

    @Test
    func `benchmark trend interprets canonical Sample evidence`() {
        let evidence = Sample.Trend.mannKendall([1.0, 2, 3, 4, 5], value: { $0 })
        let trend = Benchmark.Trend(evidence: evidence, significance: 0)
        #expect(trend.direction == .regressing)
    }
}
