public struct MutatingRNG: RandomNumberGenerator {
  private var value: UInt64
  private var _mutate: (inout UInt64) -> Void

  public init(
    initialValue: UInt64,
    _ mutate: @escaping (inout UInt64) -> Void
  ) {
    self.value = initialValue
    self._mutate = mutate
  }

  mutating public func next() -> UInt64 {
    _mutate(&value)
    return value
  }
}

public struct MutatingSendableRNG: RandomNumberGenerator, Sendable {
  private var value: UInt64
  private var _mutate: @Sendable (inout UInt64) -> Void

  public init(
    initialValue: UInt64,
    _ mutate: @escaping @Sendable (inout UInt64) -> Void
  ) {
    self.value = initialValue
    self._mutate = mutate
  }

  mutating public func next() -> UInt64 {
    _mutate(&value)
    return value
  }
}
