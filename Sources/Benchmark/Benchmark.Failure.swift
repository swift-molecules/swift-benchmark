extension Benchmark {

    public enum Failure<First: Swift.Error, Second: Swift.Error>: Swift.Error {
        case first(First)
        case second(Second)
    }
}
