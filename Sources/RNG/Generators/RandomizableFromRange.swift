public protocol RandomizableFromRange: Comparable {
  static func random(
    in range: Range<Self>,
    using rng: inout some RandomNumberGenerator
  ) -> Self
  static func random(
    in range: ClosedRange<Self>,
    using rng: inout some RandomNumberGenerator
  ) -> Self
}

extension Int: RandomizableFromRange {}
extension UInt: RandomizableFromRange {}

extension Int8: RandomizableFromRange {}
extension Int16: RandomizableFromRange {}
extension Int32: RandomizableFromRange {}
extension Int64: RandomizableFromRange {}

extension UInt8: RandomizableFromRange {}
extension UInt16: RandomizableFromRange {}
extension UInt32: RandomizableFromRange {}
extension UInt64: RandomizableFromRange {}

extension Double: RandomizableFromRange {}
extension Float: RandomizableFromRange {}
