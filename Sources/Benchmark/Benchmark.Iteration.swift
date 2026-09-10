public import Cardinal_Primitives

extension Benchmark {

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
