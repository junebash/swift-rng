public struct Always<Output>: Generator {
  public let value: Output

  public init(_ value: Output) {
    self.value = value
  }

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    value
  }
}
