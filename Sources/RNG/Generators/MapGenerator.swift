extension Generator {
  public func map<NewOutput>(
    _ transform: @escaping (Output) -> NewOutput
  ) -> MapGenerator<Self, NewOutput> {
    MapGenerator(base: self, transform: transform)
  }
}

public struct MapGenerator<Base: Generator, Output>: Generator {
  public let base: Base
  public let transform: (Base.Output) -> Output

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    transform(base.generate(with: &rng))
  }
}
