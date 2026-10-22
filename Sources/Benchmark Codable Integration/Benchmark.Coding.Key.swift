import Benchmark

extension Benchmark.Coding {
    struct Key {
        let stringValue: String

        init(_ stringValue: String) {
            self.stringValue = stringValue
        }
    }
}

extension Benchmark.Coding.Key: CodingKey {
    var intValue: Int? { nil }

    init?(stringValue: String) {
        self.init(stringValue)
    }

    init?(intValue: Int) {
        return nil
    }
}
