# swift-benchmark

Use this package to measure a workload with any instrument you can start and stop, and to reason about the results without committing to a storage format or a clock. Start from `Benchmark.run(plan:workload:probe:)`, which executes a `Benchmark.Workload` under a `Benchmark.Plan` and records what a `Benchmark.Probe` observes. Use `Benchmark.Complexity.analyze(_:classes:)` for growth-rate evidence across input sizes, and `Benchmark.Evaluation`, `Benchmark.Baseline`, `Benchmark.History` and `Benchmark.Trend` to compare results over time. For wall-clock probes and calibration, use the sibling swift-benchmark-clock. To turn results into test issues, use the sibling swift-test.

## Laws

- Each warmup iteration runs setup, `batch` operations and teardown. No probe runs and nothing is recorded.
- Each measured iteration runs setup, probe start, `batch` operations, probe stop and teardown, in that order. A measured iteration yields exactly one observation, which covers the whole batch. The package never divides it by the batch size. `Benchmark.Plan.work` is `measurements × batch`. Warmup does not count towards it.
- `Benchmark.Receipt.iterations` lists every warmup iteration before every measured iteration, in execution order. `Benchmark.Measurement.values` holds one observation per measured iteration, in the same order.
- The first failure stops the run, and the caller receives no partial receipt.
  - If an operation fails during a measured iteration, the probe is cancelled and the workload is torn down. A failure in that teardown is discarded, and the operation's failure is thrown.
  - If the probe fails to start or stop, the workload is torn down before the probe's failure is thrown. If that teardown also fails, the teardown's failure is thrown and the probe's failure is lost.
- `Benchmark.Probe.zip(_:)` nests probes. It starts the receiver first and stops it last, so the outer probe's measurement contains the inner probe's. Cancellation also runs inner first.
  - If the inner probe fails to start, the outer probe is cancelled. If the inner probe fails to stop, the outer probe is cancelled.
  - If the outer probe fails to stop, the inner probe's observation is dropped.
  - `Benchmark.Failure.first` carries the receiver's failure, and `Benchmark.Failure.second` carries the argument's.
- `Benchmark.Plan` requires `measurements > 0` and `batch > 0`. It also requires every count, and `measurements × batch`, to fit in `Int`.
- `Benchmark.Complexity.analyze(_:classes:)` discards points whose size is zero, or whose observation is not finite or not positive. It sorts the remaining points by size, and returns `nil` when fewer than two remain.
  - `Benchmark.Complexity.Exponent` is the slope of a linear fit of log₂ observation against log₂ size. A linear observation gives 1, and a quadratic one gives 2.
  - The candidates are ordered by r², best fit first. `Benchmark.Complexity.Class.logarithmic` uses log₂ n, and `Benchmark.Complexity.Class.exponential` uses 2ⁿ.
  - The trend is a Mann–Kendall test of the observations, taken in size order.
- `Benchmark.Trend` is `.stable` when the magnitude of the standardized statistic is at most `significance`, which defaults to 1.96 (two-sided 95%). Otherwise it is `.regressing` when the statistic's sign matches `regression`, and `.improving` when it does not. With the default `.increasing`, rising values count as regressions.
- `Benchmark.Evaluation` is called as `(current, baseline)`. The baseline's `name` takes no part in the comparison.
- `Benchmark.History` orders its entries by ascending `sequence`, whatever order they were given in. `latest` is the entry with the highest sequence.
- `Benchmark.consume(_:)` is an optimizer barrier. It keeps a value alive and observed without copying or consuming it, so that a workload's result is not eliminated as dead code.
