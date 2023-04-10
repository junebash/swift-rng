// MARK: - Int

extension FixedWidthInteger {
  public static func generator(in range: ClosedRange<Self>) -> FixedWidthIntegerGenerator<Self> {
    FixedWidthIntegerGenerator(range: range)
  }

  public static func generator(in range: Range<Self>) -> FixedWidthIntegerGenerator<Self> {
    FixedWidthIntegerGenerator(range: range.lowerBound...(range.upperBound + 1))
  }
}

public struct FixedWidthIntegerGenerator<Output: FixedWidthInteger>: Generator {
  public let range: ClosedRange<Output>

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    Output.random(in: range, using: &rng)
  }
}

// MARK: - Float

extension BinaryFloatingPoint {
  public static func generator(in range: ClosedRange<Self>) -> FloatingPointGenerator<Self>
  where RawSignificand: FixedWidthInteger {
    FloatingPointGenerator(range: range)
  }

  public static func generator(in range: Range<Self>) -> FloatingPointGenerator<Self>
  where RawSignificand: FixedWidthInteger {
    FloatingPointGenerator(range: range.lowerBound...(range.upperBound - 1))
  }
}

public struct FloatingPointGenerator<Output: BinaryFloatingPoint>: Generator
where Output.RawSignificand: FixedWidthInteger {
  public let range: ClosedRange<Output>

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    Output.random(in: range, using: &rng)
  }
}
