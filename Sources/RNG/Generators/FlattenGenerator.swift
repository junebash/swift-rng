extension Generator {
  public func flattened() -> FlattenGenerator<Self>
  where Output: Generator {
    FlattenGenerator(base: self)
  }

  public func flatMap<NewGenerator: Generator>(
    _ transform: @escaping (Output) -> NewGenerator
  ) -> FlattenGenerator<MapGenerator<Self, NewGenerator>> {
    self.map(transform).flattened()
  }
}

public struct FlattenGenerator<Base: Generator>: Generator
where Base.Output: Generator {
  public let base: Base

  public func generate(with rng: inout some RandomNumberGenerator) -> Base.Output.Output {
    base.generate(with: &rng).generate(with: &rng)
  }
}
