// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Cardinal_Primitives

extension Benchmark {
    /// A validated, metric-independent execution plan.
    public struct Plan: Sendable, Hashable {
        public let warmup: Cardinal
        public let measurements: Cardinal
        public let batch: Cardinal
        public let work: Cardinal

        public init(
            warmup: Cardinal = 1,
            measurements: Cardinal = 10,
            batch: Cardinal = 1
        ) throws(Error) {
            guard measurements > 0 else { throw .emptyMeasurement }
            guard batch > 0 else { throw .emptyBatch }
            let warmupCount = Int(clamping: warmup)
            let measurementCount = Int(clamping: measurements)
            let batchCount = Int(clamping: batch)
            guard Cardinal(UInt(warmupCount)) == warmup,
                Cardinal(UInt(measurementCount)) == measurements,
                Cardinal(UInt(batchCount)) == batch
            else { throw .overflow }
            let (work, overflow) = measurementCount.multipliedReportingOverflow(by: batchCount)
            guard !overflow else { throw .overflow }
            self.warmup = warmup
            self.measurements = measurements
            self.batch = batch
            self.work = Cardinal(UInt(work))
        }
    }
}
