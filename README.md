# Benchmark

[![CI](https://github.com/swift-primitives/swift-benchmark/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-primitives/swift-benchmark/actions/workflows/ci.yml)

Metric-independent benchmark plans, workloads, probes, measurements, evaluation, history, and complexity semantics for Swift.

## Use

```swift
import Benchmark

let plan = try Benchmark.Plan(warmup: 2, measurements: 10, batch: 5)
let workload = Benchmark.Workload(
    setup: { [1, 2, 3] },
    operation: { values in Benchmark.consume(values.sorted()) },
    teardown: { _ in }
)
```

Concrete duration and memory observation belong to Benchmark Clock and Benchmark Memory. Test failure mapping belongs to Test Benchmark. Persistence, environment capture, reporting, and CLI translation belong to Test Application.

This package has no dependency on Test, Apple Testing, Clock, Memory, JSON, FileSystem, Console, SwiftSyntax, or reporters.

## Installation

```swift
.package(
    url: "https://github.com/swift-primitives/swift-benchmark.git",
    branch: "main"
)
```

Depend on `.product(name: "Benchmark", package: "swift-benchmark")`.

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
