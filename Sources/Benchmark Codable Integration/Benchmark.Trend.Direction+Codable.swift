public import Benchmark

extension Benchmark.Trend.Direction: Codable {
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
        case "improving": self = .improving
        case "stable": self = .stable
        case "regressing": self = .regressing
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
        case .improving:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("improving"))
        case .stable:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("stable"))
        case .regressing:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("regressing"))
        }
    }
}
