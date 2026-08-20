// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Cardinal_Primitives

extension Benchmark.History {
    /// A sequenced pure history value. Environment capture and serialization are external.
    public struct Entry: Sendable {
        public let sequence: Cardinal
        public let value: Value

        public init(sequence: Cardinal, value: Value) {
            self.sequence = sequence
            self.value = value
        }
    }
}

extension Benchmark.History.Entry: Equatable where Value: Equatable {}
extension Benchmark.History.Entry: Hashable where Value: Hashable {}
