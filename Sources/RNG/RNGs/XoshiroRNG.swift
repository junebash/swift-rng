/// An implementation of xoshiro256**: http://xoshiro.di.unimi.it.
public struct XoshiroRNG: RandomNumberGenerator, Hashable, Sendable {
  public struct State: Hashable, RawRepresentable, Sendable {
    public typealias RawValue = (UInt64, UInt64, UInt64, UInt64)

    @usableFromInline
    var a, b, c, d: UInt64

    @inlinable
    public var rawValue: RawValue {
      (a, b, c, d)
    }

    @inlinable
    public init(rawValue: (UInt64, UInt64, UInt64, UInt64)) {
      (a, b, c, d) = rawValue
    }

    @inlinable
    public init(a: UInt64, b: UInt64, c: UInt64, d: UInt64) {
      self.a = a
      self.b = b
      self.c = c
      self.d = d
    }

    @inlinable
    public var value: UInt64 {
      let x = a &* 5
      return ((x &<< 7) | (x &>> 57)) &* 9
    }

    @inlinable
    public mutating func perturb() {
      let t = b &<< 17
      c ^= a
      d ^= b
      b ^= c
      a ^= d
      c ^= t
      d = (d &<< 45) | (d &>> 19)
    }
  }

  /// Get the latest internal state of the RNG.
  ///
  /// Can be used in combination with `init(state:)` to run the RNG from a specific state,
  /// e.g. in the context of a property-based test.
  public var state: State

  @inlinable
  public static func randomSeed() -> Self {
    .init(seed: .random(in: .min ... .max))
  }

  @inlinable
  public init(seed: UInt64) {
    self.state = .init(a: seed, b: 18_446_744, c: 73_709, d: 551_615)
    for _ in 1...10 {
      state.perturb()
    }
  }

  @inlinable
  public init(byteSeed: some Sequence<UInt8>) {
    var rawState: State.RawValue = (0, 0, 0, 0)
    withUnsafeMutableBytes(of: &rawState) { buffer in
      var index = buffer.startIndex
      for byte in byteSeed {
        buffer[index] ^= byte
        buffer.formIndex(after: &index)
        if index >= buffer.endIndex {
          index = buffer.startIndex
        }
      }
    }
    self.init(state: .init(rawValue: rawState))
    for _ in 1...10 {
      state.perturb()
    }
  }

  @inlinable
  public init(textSeed: some StringProtocol) {
    self.init(byteSeed: textSeed.utf8)
  }

  @inlinable
  public mutating func next() -> UInt64 {
    let value = state.value
    state.perturb()
    return value
  }
}

extension XoshiroRNG {
  /// Initialize with a full state.
  ///
  /// Useful for getting an exact value from `next()` after multiple runs of the RNG.
  @inlinable
  public init(state: State) {
    self.state = state
  }
}
