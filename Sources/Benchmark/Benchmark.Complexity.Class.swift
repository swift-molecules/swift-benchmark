import Real_Primitives

extension Benchmark.Complexity {
    public enum Class: String, Sendable, Hashable, Codable, CaseIterable {
        case constant
        case logarithmic
        case squareRoot
        case linear
        case linearithmic
        case quadratic
        case cubic
        case exponential
    }
}

extension Benchmark.Complexity.Class {
    public func transform(_ size: Double) -> Double {
            switch self {
            case .constant: 1
            case .logarithmic: Double.math.log2(size)
            case .squareRoot: size.squareRoot()
            case .linear: size
            case .linearithmic: size * Double.math.log2(size)
            case .quadratic: size * size
            case .cubic: size * size * size
            case .exponential: Double.math.exp2(size)
            }
    }
}
