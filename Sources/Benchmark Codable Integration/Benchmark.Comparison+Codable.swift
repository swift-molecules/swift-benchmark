public import Benchmark

extension Benchmark.Comparison: Codable {
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
        case "improved": self = .improved
        case "unchanged": self = .unchanged
        case "regressed": self = .regressed
        case "inconclusive": self = .inconclusive
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
        case .improved:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("improved"))
        case .unchanged:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("unchanged"))
        case .regressed:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("regressed"))
        case .inconclusive:
            _ = container.nestedContainer(keyedBy: Benchmark.Coding.Key.self, forKey: .init("inconclusive"))
        }
    }
}
