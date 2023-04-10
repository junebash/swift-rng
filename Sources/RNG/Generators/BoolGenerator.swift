extension Bool {
  public static func generator() -> BoolGenerator {
    BoolGenerator()
  }
}

public struct BoolGenerator: Generator {
  public func generate(with rng: inout some RandomNumberGenerator) -> Bool {
    Bool.random(using: &rng)
  }
}
