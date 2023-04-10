extension Range: Generator where Bound: RandomizableFromRange {
  public func generate(with rng: inout some RandomNumberGenerator) -> Bound {
    Bound.random(in: self, using: &rng)
  }
}

extension ClosedRange: Generator where Bound: RandomizableFromRange {
  public func generate(with rng: inout some RandomNumberGenerator) -> Bound {
    Bound.random(in: self, using: &rng)
  }
}
