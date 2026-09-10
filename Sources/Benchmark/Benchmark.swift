public enum Benchmark {}

extension Benchmark {

    @inline(never)
    public static func consume<Value: ~Copyable>(_ value: borrowing Value) {
        _fixLifetime(value)
    }
}
