extension Benchmark.Plan {
    public enum Error: Swift.Error, Equatable {
        case emptyMeasurement
        case emptyBatch
        case overflow
    }
}
