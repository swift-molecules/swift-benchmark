public import Cardinal_Primitives

extension Benchmark.Complexity {

    public struct Point: Sendable, Hashable {
        public let size: Cardinal
        public let observation: Double

        public init(size: Cardinal, observation: Double) {
            self.size = size
            self.observation = observation
        }
    }
}
