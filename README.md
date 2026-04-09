# simple_username_generator

A lightweight, zero-dependency Dart package that generates random usernames by combining words from seven categories — **adjectives**, **verbs**, **adverbs**, **nouns**, **suffixes**, **prefixes**, and **titles** — with a numeric suffix.

- **2,700+ deduplicated words** across 7 categories
- **19 username styles** (e.g. `AdjectiveNoun`, `NounSuffix`, `PrefixNoun`, `TitleNoun`)
- **4 casing formats** (PascalCase, lowercase, snake_case, kebab-case)
- **Batch generation** with uniqueness guarantee
- **Seeded output** for reproducibility
- **No dependencies** — pure Dart

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  simple_username_generator: ^1.6.0
```

Then run:

```sh
dart pub get
```

## Usage

```dart
import 'package:simple_username_generator/simple_username_generator.dart';

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

  // Sci-fi prefix style
  final scifiGen = UsernameGenerator(
    style: UsernameStyle.prefixNoun,
  );
  print(scifiGen.generate()); // NeoPhoenix42

  // Title + Noun
  final titleGen = UsernameGenerator(
    style: UsernameStyle.titleNoun,
  );
  print(titleGen.generate()); // AgentWolf99

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
| `prefixNoun` | Prefix + Noun | `NeoPhoenix42` |
| `prefixAdjectiveNoun` | Prefix + Adjective + Noun | `ArchDarkTiger7` |
| `titleNoun` | Title + Noun | `AgentWolf99` |
| `titleAdjectiveNoun` | Title + Adjective + Noun | `SirBraveEagle42` |
| `adverbNoun` | Adverb + Noun | `EverWolf42` |
| `prefixSuffix` | Prefix + Suffix | `NeoSeeker42` |
| `verbNounSuffix` | Verb + Noun + Suffix | `RunningStormBringer42` |
| `prefixNounSuffix` | Prefix + Noun + Suffix | `NeoStormBringer42` |
| `titleNounSuffix` | Title + Noun + Suffix | `AgentStormBringer42` |
| `prefixVerbNoun` | Prefix + Verb + Noun | `NeoRunningWolf42` |
| `titleVerbNoun` | Title + Verb + Noun | `AgentRunningWolf42` |

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
| Prefixes | 87 | Neo, Proto, Arch, Sigma |
| Titles | 92 | Agent, Sir, Colonel, Archon |

All words are cross-checked and deduplicated across categories. Adjectives, nouns, verbs, adverbs, prefixes, and titles are fully disjoint. Suffixes are positional and may share words with nouns by design (they occupy different slots in the pattern).

## Unique Combinations & Collision Risk

With the default number range (`0`–`9999` = 10,000 numbers), each style has the following total unique username space:

| Style | Formula | Unique Usernames |
|---|---|---|
| `nounOnly` | 995 × 10K | **~10 million** |
| `prefixNoun` | 87 × 995 × 10K | **~866 million** |
| `titleNoun` | 92 × 995 × 10K | **~915 million** |
| `nounSuffix` | 995 × 266 × 10K | **~2.6 billion** |
| `adjectiveNoun` | 584 × 995 × 10K | **~5.8 billion** |
| `verbNoun` | 609 × 995 × 10K | **~6.1 billion** |
| `adverbAdjectiveNoun` | 83 × 584 × 995 × 10K | **~482 billion** |
| `adverbVerbNoun` | 83 × 609 × 995 × 10K | **~503 billion** |
| `prefixAdjectiveNoun` | 87 × 584 × 995 × 10K | **~506 billion** |
| `titleAdjectiveNoun` | 92 × 584 × 995 × 10K | **~535 billion** |
| `adjectiveNounSuffix` | 584 × 995 × 266 × 10K | **~1.5 trillion** |
| `adverbNoun` | 83 × 995 × 10K | **~826 million** |
| `prefixSuffix` | 87 × 266 × 10K | **~231 million** |
| `verbNounSuffix` | 609 × 995 × 266 × 10K | **~1.6 trillion** |
| `prefixNounSuffix` | 87 × 995 × 266 × 10K | **~230 billion** |
| `titleNounSuffix` | 92 × 995 × 266 × 10K | **~243 billion** |
| `prefixVerbNoun` | 87 × 609 × 995 × 10K | **~527 billion** |
| `titleVerbNoun` | 92 × 609 × 995 × 10K | **~557 billion** |
| `adjectiveVerbNoun` | 584 × 609 × 995 × 10K | **~3.5 trillion** |

### Collision probability

Using the [birthday paradox](https://en.wikipedia.org/wiki/Birthday_problem) approximation $P \approx 1 - e^{-n^2 / 2N}$ where $n$ = number of generated usernames and $N$ = unique combinations:

| Users | `nounOnly` | `adjectiveNoun` | `adjectiveVerbNoun` |
|---|---|---|---|
| 1,000 | 4.9% | < 0.01% | < 0.01% |
| 10,000 | ~100% | 0.86% | < 0.01% |
| 50,000 | ~100% | 19.3% | < 0.01% |
| 100,000 | ~100% | 57.7% | < 0.01% |
| 1,000,000 | ~100% | ~100% | 0.01% |

**50% collision thresholds** (the number of users where there's a 50/50 chance of at least one duplicate):

| Style | 50% Collision At |
|---|---|
| `nounOnly` | ~3,700 users |
| `prefixNoun` | ~34,600 users |
| `titleNoun` | ~35,600 users |
| `adjectiveNoun` | ~89,800 users |
| `verbNoun` | ~91,700 users |
| `adverbVerbNoun` | ~835,000 users |
| `adjectiveVerbNoun` | ~2,215,000 users |

> **Tip:** For applications with many users, use a 3-word style (`adjectiveVerbNoun`, `adverbVerbNoun`) or increase `maxNumber` to push the collision threshold higher.

## License

BSD 3-Clause. See [LICENSE](LICENSE) for details.
