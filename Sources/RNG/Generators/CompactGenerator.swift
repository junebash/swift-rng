extension Generator {
  public func compacted<Wrapped>() -> CompactGenerator<Self, Wrapped>
  where Output == Wrapped? {
    CompactGenerator(base: self)
  }

  public func compactMap<NewOutput>(
    _ transform: @escaping (Output) -> NewOutput?
  ) -> CompactGenerator<MapGenerator<Self, NewOutput?>, NewOutput> {
    self.map(transform).compacted()
  }
}

public struct CompactGenerator<Base: Generator, Output>: Generator
where Base.Output == Output? {
  public let base: Base

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    while true {
      if let output = base.generate(with: &rng) {
        return output
      }
    }
  }
}
