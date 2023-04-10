public struct AnyRNG: RandomNumberGenerator {
  public var underlyingRNG: any RandomNumberGenerator

  public init(_ rng: any RandomNumberGenerator) {
    self.underlyingRNG = rng
  }

  public mutating func next() -> UInt64 {
    underlyingRNG.next()
  }
}
