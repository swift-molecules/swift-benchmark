// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

/// Metric-independent benchmark vocabulary and execution.
public enum Benchmark {}

extension Benchmark {
    /// Keeps a value alive through the call boundary so benchmark workloads can
    /// explicitly consume results that would otherwise be optimized away.
    @inline(never)
    public static func consume<Value: ~Copyable>(_ value: borrowing Value) {
        _fixLifetime(value)
    }
}
