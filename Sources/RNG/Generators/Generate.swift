public struct Generate<Output>: Generator {
  private let _generate: (inout any RandomNumberGenerator) -> Output

  public init(_ generate: @escaping (inout any RandomNumberGenerator) -> Output) {
    self._generate = generate
  }

  public init(_ generator: some Generator<Output>) {
    self._generate = { generator.generate(with: &$0) }
  }

  public func generate<RNG: RandomNumberGenerator>(with rng: inout RNG) -> Output {
    var anyRNG = rng as any RandomNumberGenerator
    let output = _generate(&anyRNG)
    rng = anyRNG as! RNG
    return output
  }
}
