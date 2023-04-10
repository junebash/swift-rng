public func zip<A: Generator, B: Generator>(_ a: A, _ b: B) -> Zip2Generator<A, B> {
  Zip2Generator(a: a, b: b)
}

public struct Zip2Generator<A: Generator, B: Generator>: Generator {
  public let a: A
  public let b: B

  public func generate(with rng: inout some RandomNumberGenerator) -> (A.Output, B.Output) {
    (a.generate(with: &rng), b.generate(with: &rng))
  }
}

public func zip<
  A: Generator,
  B: Generator,
  C: Generator
>(
  _ a: A,
  _ b: B,
  _ c: C
) -> Zip3Generator<
  A,
  B,
  C
> {
  Zip3Generator(a: a, b: b, c: c)
}

public struct Zip3Generator<
  A: Generator,
  B: Generator,
  C: Generator
>: Generator {
  public let a: A
  public let b: B
  public let c: C

  public func generate(
    with rng: inout some RandomNumberGenerator
  ) -> (
    A.Output,
    B.Output,
    C.Output
  ) {
    (
      a.generate(with: &rng),
      b.generate(with: &rng),
      c.generate(with: &rng)
    )
  }
}

public func zip<
  A: Generator,
  B: Generator,
  C: Generator,
  D: Generator
>(
  _ a: A,
  _ b: B,
  _ c: C,
  _ d: D
) -> Zip4Generator<
  A,
  B,
  C,
  D
> {
  Zip4Generator(a: a, b: b, c: c, d: d)
}

public struct Zip4Generator<
  A: Generator,
  B: Generator,
  C: Generator,
  D: Generator
>: Generator {
  public let a: A
  public let b: B
  public let c: C
  public let d: D

  public func generate(
    with rng: inout some RandomNumberGenerator
  ) -> (
    A.Output,
    B.Output,
    C.Output,
    D.Output
  ) {
    (
      a.generate(with: &rng),
      b.generate(with: &rng),
      c.generate(with: &rng),
      d.generate(with: &rng)
    )
  }
}

public func zip<
  A: Generator,
  B: Generator,
  C: Generator,
  D: Generator,
  E: Generator
>(
  _ a: A,
  _ b: B,
  _ c: C,
  _ d: D,
  _ e: E
) -> Zip5Generator<
  A,
  B,
  C,
  D,
  E
> {
  Zip5Generator(a: a, b: b, c: c, d: d, e: e)
}

public struct Zip5Generator<
  A: Generator,
  B: Generator,
  C: Generator,
  D: Generator,
  E: Generator
>: Generator {
  public let a: A
  public let b: B
  public let c: C
  public let d: D
  public let e: E

  public func generate(
    with rng: inout some RandomNumberGenerator
  ) -> (
    A.Output,
    B.Output,
    C.Output,
    D.Output,
    E.Output
  ) {
    (
      a.generate(with: &rng),
      b.generate(with: &rng),
      c.generate(with: &rng),
      d.generate(with: &rng),
      e.generate(with: &rng)
    )
  }
}
