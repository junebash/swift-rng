public protocol Generator<Output> {
  associatedtype Output

  func generate(with rng: inout some RandomNumberGenerator) -> Output
}

extension Generator {
  public func generate() -> Output {
    var rng = SystemRandomNumberGenerator()
    return self.generate(with: &rng)
  }
}
