# username_generator

A lightweight, zero-dependency Dart package that generates random usernames by combining words from five categories — **adjectives**, **verbs**, **adverbs**, **nouns**, and **suffixes** — with a numeric suffix.

- **2,500+ deduplicated words** across 5 categories
- **8 username styles** (e.g. `AdjectiveNoun`, `NounSuffix`, `AdverbVerbNoun`)
- **4 casing formats** (PascalCase, lowercase, snake_case, kebab-case)
- **Batch generation** with uniqueness guarantee
- **Seeded output** for reproducibility
- **No dependencies** — pure Dart

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  username_generator: ^1.0.0
```

Then run:

```sh
dart pub get
```

## Usage

```dart
import 'package:username_generator/username_generator.dart';

void main() {
  // Default: AdjectiveNoun + PascalCase
  final gen = UsernameGenerator();
  print(gen.generate()); // BraveTiger42

  // Verb + Noun in snake_case
  final snakeGen = UsernameGenerator(
    style: UsernameStyle.verbNoun,
    casing: UsernameCasing.snakeCase,
  );
  print(snakeGen.generate()); // dashing_wolf_99

  // Fantasy-style compound names
  final fantasyGen = UsernameGenerator(
    style: UsernameStyle.nounSuffix,
  );
  print(fantasyGen.generate()); // StormBringer42

  // Batch of 10 unique usernames
  final batch = gen.generateBatch(10);
  batch.forEach(print);

  // Reproducible with a seed
  final seeded = UsernameGenerator(seed: 42);
  print(seeded.generate()); // Always the same
}
```

## Username Styles

| Style | Pattern | Example |
|---|---|---|
| `adjectiveNoun` | Adjective + Noun | `BraveTiger42` |
| `verbNoun` | Verb + Noun | `DashingWolf99` |
| `adjectiveVerbNoun` | Adjective + Verb + Noun | `SwiftRunningEagle7` |
| `nounOnly` | Noun | `Phoenix2024` |
| `nounSuffix` | Noun + Suffix | `StormBringer42` |
| `adjectiveNounSuffix` | Adjective + Noun + Suffix | `DarkStormBringer42` |
| `adverbVerbNoun` | Adverb + Verb + Noun | `EverBurningPhoenix7` |
| `adverbAdjectiveNoun` | Adverb + Adjective + Noun | `TrulyBraveWolf99` |

## Casing Formats

| Format | Example |
|---|---|
| `pascalCase` | `BraveTiger42` |
| `lowerCase` | `bravetiger42` |
| `snakeCase` | `brave_tiger_42` |
| `kebabCase` | `brave-tiger-42` |

## API

### `UsernameGenerator`

```dart
UsernameGenerator({
  UsernameStyle style = UsernameStyle.adjectiveNoun,
  UsernameCasing casing = UsernameCasing.pascalCase,
  int minNumber = 0,
  int maxNumber = 9999,
  int? seed,
})
```

| Parameter | Description | Default |
|---|---|---|
| `style` | Word combination pattern | `adjectiveNoun` |
| `casing` | Output casing/separator | `pascalCase` |
| `minNumber` | Minimum numeric suffix (inclusive) | `0` |
| `maxNumber` | Maximum numeric suffix (inclusive) | `9999` |
| `seed` | Random seed for reproducible output | `null` |

### Methods

- **`String generate()`** — Returns a single random username.
- **`List<String> generateBatch(int count, {bool unique = true})`** — Returns `count` usernames. When `unique` is `true`, all values are distinct.

## Word Categories

| Category | Count | Examples |
|---|---|---|
| Adjectives | 584 | Brave, Dark, Swift, Cosmic |
| Nouns | 995 | Wolf, Storm, Phoenix, Blade |
| Verbs | 609 | Running, Blazing, Forging |
| Adverbs | 83 | Ever, Truly, Deeply, Boldly |
| Suffixes | 266 | Bringer, Seeker, Born, Blade |

All words are cross-checked for duplicates across categories (adjectives, nouns, verbs, adverbs are fully disjoint; suffixes are positional and may share words with nouns by design).

## License

BSD 3-Clause. See [LICENSE](LICENSE) for details.
