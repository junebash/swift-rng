public struct ConstantRNG: RandomNumberGenerator, Sendable {
  public var value: UInt64

  public init(_ value: UInt64) {
    self.value = value
  }

  public func next() -> UInt64 {
    value
  }
}
