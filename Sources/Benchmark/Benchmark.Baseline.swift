// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// A pure named reference value. Persistence belongs to the application layer.
    public struct Baseline<Value: Sendable>: Sendable {
        public let name: String
        public let value: Value

        public init(name: String, value: Value) {
            self.name = name
            self.value = value
        }
    }
}

extension Benchmark.Baseline: Equatable where Value: Equatable {}
extension Benchmark.Baseline: Hashable where Value: Hashable {}
extension Benchmark.Baseline: Codable where Value: Codable {}
