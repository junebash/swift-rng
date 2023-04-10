// MARK: - RangeReplaceable

extension RangeReplaceableCollection {
  public static func generator<Base: RNG.Generator<Element>, Count: RNG.Generator<Int>>(
    of base: Base,
    count: Count
  ) -> CollectionGenerator<Base, Count, Self> {
    CollectionGenerator(base: base, count: count)
  }
}

public struct CollectionGenerator<
  Base: Generator,
  Count: Generator<Int>,
  Output: RangeReplaceableCollection
>: Generator where Output.Element == Base.Output {
  public let base: Base
  public let count: Count

  public func generate(with rng: inout some RandomNumberGenerator) -> Output {
    let size = count.generate(with: &rng)
    var output = Output()
    output.reserveCapacity(size)
    for _ in 0..<size {
      output.append(base.generate(with: &rng))
    }
    return output
  }
}

// MARK: - Element

extension Collection {
  public func elementGenerator() -> ElementGenerator<Self> {
    ElementGenerator(source: self)
  }
}

extension Generator where Output: Collection {
  public func element() -> FlattenGenerator<MapGenerator<Self, ElementGenerator<Output>>> {
    self.flatMap { $0.elementGenerator() }
  }
}

public struct ElementGenerator<Source: Collection>: Generator {
  public let source: Source

  public func generate(with rng: inout some RandomNumberGenerator) -> Source.Element? {
    source.randomElement(using: &rng)
  }
}

// MARK: - Shuffled

extension Collection {
  public func shuffleGenerator() -> ShuffleGenerator<Self> {
    ShuffleGenerator(source: self)
  }
}

extension Generator where Output: Collection {
  public func shuffled() -> FlattenGenerator<MapGenerator<Self, ShuffleGenerator<Output>>> {
    self.flatMap { $0.shuffleGenerator() }
  }
}

public struct ShuffleGenerator<Source: Collection>: Generator {
  public let source: Source

  public func generate(with rng: inout some RandomNumberGenerator) -> [Source.Element] {
    source.shuffled(using: &rng)
  }
}

// MARK: - CaseIterable

extension CaseIterable {
  public static func generator() -> CompactGenerator<ElementGenerator<AllCases>, Self> {
    Self.allCases.elementGenerator().compacted()
  }
}
