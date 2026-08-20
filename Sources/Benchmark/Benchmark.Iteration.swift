// This source file is part of the swift-benchmark open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-benchmark project authors
// Licensed under Apache License v2.0

public import Cardinal_Primitives

extension Benchmark {
    /// Identity and work-unit accounting for one planned iteration.
    public struct Iteration: Sendable, Hashable {
        public let phase: Phase
        public let index: Cardinal
        public let batch: Cardinal

        public init(phase: Phase, index: Cardinal, batch: Cardinal) {
            self.phase = phase
            self.index = index
            self.batch = batch
        }
    }
}
