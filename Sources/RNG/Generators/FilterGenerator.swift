extension Generator {
  public func filter(_ isIncluded: @escaping (Output) -> Bool) -> FilterGenerator<Self> {
    .init(base: self, predicate: isIncluded)
  }
}

public struct FilterGenerator<Base: Generator>: Generator {
  public let base: Base
  public let predicate: (Base.Output) -> Bool

  public func generate(with rng: inout some RandomNumberGenerator) -> Base.Output {
    while true {
      let output = base.generate(with: &rng)
      if predicate(output) {
        return output
      }
    }
  }
}
