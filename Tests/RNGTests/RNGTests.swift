import XCTest
@testable import RNG

final class RNGTests: XCTestCase {
  var rng: XoshiroRNG = XoshiroRNG(seed: 0)

  override func setUp() async throws {
    self.rng = XoshiroRNG(seed: 0)
  }

  func testExample1() {
    let generator = String.words(
      5...10,
      from: Character.generator(in: .alpha).compacted(),
      ofLength: 3...8
    )
    .reduce(into: Always(Data())) { partialResult, nextElement in
      partialResult.append(contentsOf: nextElement.utf8)
    }
    .map { $0.base64EncodedString() }
    XCTAssertEqual("VmtGQWggRXBsY0EgQlRsa0toIGt2SSBQVG9P", generator.generate(with: &rng))
  }

  func testExample2() {
    let generator = Character.generator(in: .alpha).compacted()
    XCTAssertEqual(generator.generate(with: &rng), "f")
  }

  func testExample3() {
    let number = Int.generator(in: 1...50).map(Double.init)
    let generator = zip(number, number, number).flatMap { (a, b, c) in
      var (a, b) = (a, b)
      if a > b {
        swap(&a, &b)
      }
      return Double.generator(in: a...b).map { $0 * c }
    }
    .map(Int.init)
    XCTAssertEqual(generator.generate(with: &rng), 415)
  }
}
