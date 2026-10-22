public import Benchmark

extension Benchmark.Trend.Regression: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: Benchmark.Coding.Key.self)
        guard container.allKeys.count == 1, let key = container.allKeys.first else {
            throw DecodingError.typeMismatch(
                Self.self,
                .init(codingPath: decoder.codingPath, debugDescription: "Expected exactly one enum case.")
            )
        }
        _ = try container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: key)
        switch key.stringValue {
        case "increasing": self = .increasing
        case "decreasing": self = .decreasing
        default:
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: container,
                debugDescription: "Unknown enum case."
            )
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: Benchmark.Coding.Key.self)
        switch self {
        case .increasing:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("increasing"))
        case .decreasing:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("decreasing"))
        }
    }
}
