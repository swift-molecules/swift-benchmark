// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

import Real_Primitives
import Sample_Primitives
import Cardinal_Primitives

extension Benchmark {
    /// Empirical complexity semantics over dimensionless observations.
    public enum Complexity {}
}

extension Benchmark.Complexity {
    public static func analyze(
            _ points: [Point],
            classes: [Class] = Class.allCases
        ) -> Evidence? {
            let valid = points
                .filter { $0.size > 0 && $0.observation.isFinite && $0.observation > 0 }
                .sorted { $0.size < $1.size }
            guard valid.count >= 2 else { return nil }

            let logSizes = valid.map { Double.math.log2(Double(Int(clamping: $0.size))) }
            let logObservations = valid.map { Double.math.log2($0.observation) }
            let exponentFit = Sample.Regression.linear(x: logSizes, y: logObservations)
            var candidates = classes.map { complexity in
                Evidence.Candidate(
                    complexity: complexity,
                    fit: Sample.Regression.linear(
                        x: valid.map { complexity.transform(Double(Int(clamping: $0.size))) },
                        y: valid.map(\.observation)
                    )
                )
            }
            candidates.sort { $0.fit.rSquared > $1.fit.rSquared }
            let trend = Sample.Trend.mannKendall(valid, value: \.observation)
            return .init(
                exponent: .init(value: exponentFit.slope, fit: exponentFit),
                candidates: candidates,
                trend: trend,
                points: valid
            )
    }
}
