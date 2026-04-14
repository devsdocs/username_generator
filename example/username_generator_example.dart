import 'dart:math';

import 'package:simple_username_generator/simple_username_generator.dart';

void main() {
  // Default: AdjectiveNoun + number in PascalCase
  final generator = UsernameGenerator();
  print(generator.generate()); // e.g. BraveTiger42

  // Verb + Noun style with snake_case
  final snakeGen = UsernameGenerator(
    style: UsernameStyle.verbNoun,
    casing: UsernameCasing.snakeCase,
  );
  print(snakeGen.generate()); // e.g. dashing_wolf_99

  // Three-word style with custom number range
  final epicGen = UsernameGenerator(
    style: UsernameStyle.adjectiveVerbNoun,
    minNumber: 100,
    maxNumber: 999,
  );
  print(epicGen.generate()); // e.g. SwiftRunningEagle457

  // Compound suffix style — great for fantasy/gaming
  final compoundGen = UsernameGenerator(style: UsernameStyle.nounSuffix);
  print(compoundGen.generate()); // e.g. StormBringer42

  // Sci-fi prefix style
  final scifiGen = UsernameGenerator(style: UsernameStyle.prefixNoun);
  print(scifiGen.generate()); // e.g. NeoPhoenix42

  // Title + Noun
  final titleGen = UsernameGenerator(style: UsernameStyle.titleNoun);
  print(titleGen.generate()); // e.g. AgentWolf99

  // Adverb + Verb + Noun
  final adverbGen = UsernameGenerator(style: UsernameStyle.adverbVerbNoun);
  print(adverbGen.generate()); // e.g. EverBurningPhoenix7

  // Generate a batch of 5 unique usernames
  final batch = generator.generateBatch(5);
  for (final name in batch) {
    print(name);
  }

  // Reproducible output with a seed
  final seeded = UsernameGenerator(random: Random(42));
  print(seeded.generate()); // Always the same for seed 42
}
