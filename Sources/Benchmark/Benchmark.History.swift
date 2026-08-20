// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

extension Benchmark {
    /// Ordered, storage-independent benchmark history.
    public struct History<Value: Sendable>: Sendable {
        public let entries: [Entry]

        public init(entries: [Entry]) {
            self.entries = entries.sorted { $0.sequence < $1.sequence }
        }

    }
}

extension Benchmark.History {
    public var latest: Entry? { entries.last }
}

extension Benchmark.History: Equatable where Value: Equatable {}
extension Benchmark.History: Hashable where Value: Hashable {}
