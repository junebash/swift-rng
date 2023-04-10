extension String: Generator {
  public func generate(with rng: inout some RandomNumberGenerator) -> String { self }
}

extension Character {
  public static func generator(in set: [Character]) -> ElementGenerator<[Character]> {
    set.elementGenerator()
  }
}

public enum Characters {
  public static let lowercase: [Character] = .lowercase
  public static let uppercase: [Character] = .uppercase
  public static let alpha: [Character] = .alpha
  public static let numeric: [Character] = .numeric
  public static let alphanumeric: [Character] = .alphanumeric
}

extension Array where Element == Character {
  public static let lowercase: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
  public static let uppercase: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
  public static let alpha: [Character] = lowercase + uppercase
  public static let numeric: [Character] = Array("1234567890")
  public static let alphanumeric: [Character] = alpha + numeric
}

extension String {
  public static func words<
    WordCount: Generator<Int>,
    Characters: Generator<Character>,
    Length: Generator<Int>
  >(
    _ wordCount: WordCount,
    from characters: Characters,
    ofLength wordLength: Length
  ) -> WordsGenerator<WordCount, Characters, Length> {
    WordsGenerator(wordCount: wordCount, characters: characters, wordLength: wordLength)
  }
}

public struct WordsGenerator<
  WordCount: Generator<Int>,
  Characters: Generator<Character>,
  Length: Generator<Int>
>: Generator {
  let wordCount: WordCount
  let characters: Characters
  let wordLength: Length

  public func generate(with rng: inout some RandomNumberGenerator) -> String {
    let wordGenerator = String.generator(of: characters, count: wordLength)
    let totalWords = wordCount.generate(with: &rng)
    var words = ""
    var currentWordCount = 0
    while true {
      let word = wordGenerator.generate(with: &rng)
      guard !word.isEmpty else { continue }
      words.append(word)
      currentWordCount += 1
      if currentWordCount >= totalWords { break }
      words.append(" ")
    }
    return words
  }
}
