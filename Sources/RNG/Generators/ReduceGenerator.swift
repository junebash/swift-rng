public struct ReduceGenerator<
  Upstream: Generator,
  State: Generator
>: Generator where Upstream.Output: Sequence {
  public let upstream: Upstream
  public let state: State
  public let reducer: (inout State.Output, Upstream.Output.Element) -> Void

  public func generate(with rng: inout some RandomNumberGenerator) -> State.Output {
    upstream
      .generate(with: &rng)
      .reduce(into: state.generate(with: &rng), reducer)
  }
}

extension Generator where Output: Sequence {
  public func reduce<State: Generator>(
    into state: State,
    _ reduce: @escaping (_ partialResult: inout State.Output, _ nextElement: Output.Element) -> Void
  ) -> ReduceGenerator<Self, State> {
    ReduceGenerator(upstream: self, state: state, reducer: reduce)
  }

  public func reduce<State: Generator>(
    _ state: State,
    _ reduce: @escaping (_ currentValue: State.Output, _ nextElement: Output.Element) -> State.Output
  ) -> ReduceGenerator<Self, State> {
    ReduceGenerator(upstream: self, state: state) { value, element in
      value = reduce(value, element)
    }
  }
}
