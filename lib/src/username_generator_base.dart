import 'dart:math';

import 'words/adjectives.dart';
import 'words/adverbs.dart';
import 'words/nouns.dart';
import 'words/prefixes.dart';
import 'words/suffixes.dart';
import 'words/titles.dart';
import 'words/verbs.dart';

/// The pattern used to construct a username.
enum UsernameStyle {
  /// `{Adjective}{Noun}{Number}` e.g. "BraveTiger42"
  adjectiveNoun,

  /// `{Verb}{Noun}{Number}` e.g. "DashingWolf99"
  verbNoun,

  /// `{Adjective}{Verb}{Noun}{Number}` e.g. "SwiftRunningEagle7"
  adjectiveVerbNoun,

  /// `{Noun}{Number}` e.g. "Phoenix2024"
  nounOnly,

  /// `{Noun}{Suffix}{Number}` e.g. "StormBringer42"
  nounSuffix,

  /// `{Adjective}{Noun}{Suffix}{Number}` e.g. "DarkStormBringer42"
  adjectiveNounSuffix,

  /// `{Adverb}{Verb}{Noun}{Number}` e.g. "EverBurningPhoenix7"
  adverbVerbNoun,

  /// `{Adverb}{Adjective}{Noun}{Number}` e.g. "TrulyBraveWolf99"
  adverbAdjectiveNoun,

  /// `{Prefix}{Noun}{Number}` e.g. "NeoPhoenix42"
  prefixNoun,

  /// `{Prefix}{Adjective}{Noun}{Number}` e.g. "ArchDarkTiger7"
  prefixAdjectiveNoun,

  /// `{Title}{Noun}{Number}` e.g. "AgentWolf99"
  titleNoun,

  /// `{Title}{Adjective}{Noun}{Number}` e.g. "SirBraveEagle42"
  titleAdjectiveNoun,
}

/// The casing/separator style for generated usernames.
enum UsernameCasing {
  /// PascalCase with no separator: "BraveTiger42"
  pascalCase,

  /// All lowercase with no separator: "bravetiger42"
  lowerCase,

  /// Lowercase with underscores: "brave_tiger_42"
  snakeCase,

  /// Lowercase with hyphens: "brave-tiger-42"
  kebabCase,
}

/// A generator that creates random usernames by combining words from
/// seven categories (adjectives, adverbs, verbs, nouns, suffixes, prefixes,
/// titles) with a numeric suffix.
class UsernameGenerator {
  /// Minimum value for the numeric suffix (inclusive).
  final int minNumber;

  /// Maximum value for the numeric suffix (inclusive).
  final int maxNumber;

  /// The pattern used to build the username.
  final UsernameStyle style;

  /// The casing/separator style for the output.
  final UsernameCasing casing;

  final Random _random;

  /// Creates a [UsernameGenerator].
  ///
  /// - [style] determines which word categories are used (default: [UsernameStyle.adjectiveNoun]).
  /// - [casing] determines the output format (default: [UsernameCasing.pascalCase]).
  /// - [minNumber] is the inclusive lower bound for the numeric suffix (default: 0).
  /// - [maxNumber] is the inclusive upper bound for the numeric suffix (default: 9999).
  /// - [seed] optional seed for reproducible output.
  UsernameGenerator({
    this.style = UsernameStyle.adjectiveNoun,
    this.casing = UsernameCasing.pascalCase,
    this.minNumber = 0,
    this.maxNumber = 9999,
    int? seed,
  }) : _random = seed != null ? Random(seed) : Random();

  /// Generates a single random username.
  String generate() {
    final parts = _buildParts();
    final number = _randomNumber();
    return _format(parts, number);
  }

  /// Generates a list of [count] usernames.
  ///
  /// If [unique] is `true` (default), all returned usernames will be distinct.
  /// Throws [StateError] if more unique usernames are requested than the
  /// combinatorial space can provide.
  List<String> generateBatch(int count, {bool unique = true}) {
    if (!unique) {
      return List.generate(count, (_) => generate());
    }

    final results = <String>{};
    final maxAttempts = count * 10;
    var attempts = 0;

    while (results.length < count) {
      results.add(generate());
      attempts++;
      if (attempts >= maxAttempts) {
        throw StateError(
          'Could not generate $count unique usernames after $maxAttempts attempts. '
          'Try increasing the number range or using a different style.',
        );
      }
    }

    return results.toList();
  }

  List<String> _buildParts() {
    return switch (style) {
      UsernameStyle.adjectiveNoun => [_pick(adjectives), _pick(nouns)],
      UsernameStyle.verbNoun => [_pick(verbs), _pick(nouns)],
      UsernameStyle.adjectiveVerbNoun => [
        _pick(adjectives),
        _pick(verbs),
        _pick(nouns),
      ],
      UsernameStyle.nounOnly => [_pick(nouns)],
      UsernameStyle.nounSuffix => [_pick(nouns), _pick(suffixes)],
      UsernameStyle.adjectiveNounSuffix => [
        _pick(adjectives),
        _pick(nouns),
        _pick(suffixes),
      ],
      UsernameStyle.adverbVerbNoun => [
        _pick(adverbs),
        _pick(verbs),
        _pick(nouns),
      ],
      UsernameStyle.adverbAdjectiveNoun => [
        _pick(adverbs),
        _pick(adjectives),
        _pick(nouns),
      ],
      UsernameStyle.prefixNoun => [_pick(prefixes), _pick(nouns)],
      UsernameStyle.prefixAdjectiveNoun => [
        _pick(prefixes),
        _pick(adjectives),
        _pick(nouns),
      ],
      UsernameStyle.titleNoun => [_pick(titles), _pick(nouns)],
      UsernameStyle.titleAdjectiveNoun => [
        _pick(titles),
        _pick(adjectives),
        _pick(nouns),
      ],
    };
  }

  String _pick(List<String> list) => list[_random.nextInt(list.length)];

  int _randomNumber() => minNumber + _random.nextInt(maxNumber - minNumber + 1);

  String _format(List<String> words, int number) {
    final numberStr = number.toString();

    return switch (casing) {
      UsernameCasing.pascalCase => '${words.map(_capitalize).join()}$numberStr',
      UsernameCasing.lowerCase =>
        '${words.map((w) => w.toLowerCase()).join()}$numberStr',
      UsernameCasing.snakeCase =>
        '${words.map((w) => w.toLowerCase()).join('_')}_$numberStr',
      UsernameCasing.kebabCase =>
        '${words.map((w) => w.toLowerCase()).join('-')}-$numberStr',
    };
  }

  String _capitalize(String word) => word.isEmpty
      ? word
      : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
}
