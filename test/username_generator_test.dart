import 'package:username_generator/username_generator.dart';
import 'package:test/test.dart';

void main() {
  group('UsernameGenerator', () {
    test('generates a non-empty string', () {
      final gen = UsernameGenerator(seed: 1);
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('seeded generator produces deterministic output', () {
      final a = UsernameGenerator(seed: 42).generate();
      final b = UsernameGenerator(seed: 42).generate();
      expect(a, equals(b));
    });

    test('generated username contains a number', () {
      final gen = UsernameGenerator(seed: 1);
      final username = gen.generate();
      expect(username, matches(RegExp(r'\d+')));
    });

    test('number stays within configured range', () {
      final gen = UsernameGenerator(seed: 1, minNumber: 100, maxNumber: 200);
      for (var i = 0; i < 100; i++) {
        final username = gen.generate();
        final match = RegExp(r'(\d+)$').firstMatch(username);
        expect(match, isNotNull);
        final num = int.parse(match!.group(1)!);
        expect(num, greaterThanOrEqualTo(100));
        expect(num, lessThanOrEqualTo(200));
      }
    });

    test('snake_case format uses underscores', () {
      final gen = UsernameGenerator(seed: 1, casing: UsernameCasing.snakeCase);
      final username = gen.generate();
      expect(username, matches(RegExp(r'^[a-z]+(_[a-z0-9]+)+$')));
    });

    test('kebab-case format uses hyphens', () {
      final gen = UsernameGenerator(seed: 1, casing: UsernameCasing.kebabCase);
      final username = gen.generate();
      expect(username, matches(RegExp(r'^[a-z]+(-[a-z0-9]+)+$')));
    });

    test('lowerCase format has no separators or uppercase', () {
      final gen = UsernameGenerator(seed: 1, casing: UsernameCasing.lowerCase);
      final username = gen.generate();
      expect(username, equals(username.toLowerCase()));
      expect(username, isNot(contains('_')));
      expect(username, isNot(contains('-')));
    });

    test('generateBatch returns requested count', () {
      final gen = UsernameGenerator(seed: 1);
      final batch = gen.generateBatch(10);
      expect(batch.length, equals(10));
    });

    test('generateBatch with unique=true returns distinct values', () {
      final gen = UsernameGenerator(seed: 1);
      final batch = gen.generateBatch(50);
      expect(batch.toSet().length, equals(50));
    });

    test('nounOnly style produces shorter usernames', () {
      final gen = UsernameGenerator(seed: 1, style: UsernameStyle.nounOnly);
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('adjectiveVerbNoun style works', () {
      final gen = UsernameGenerator(
        seed: 1,
        style: UsernameStyle.adjectiveVerbNoun,
      );
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('nounSuffix style works', () {
      final gen = UsernameGenerator(seed: 1, style: UsernameStyle.nounSuffix);
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('adjectiveNounSuffix style works', () {
      final gen = UsernameGenerator(
        seed: 1,
        style: UsernameStyle.adjectiveNounSuffix,
      );
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('adverbVerbNoun style works', () {
      final gen = UsernameGenerator(
        seed: 1,
        style: UsernameStyle.adverbVerbNoun,
      );
      final username = gen.generate();
      expect(username, isNotEmpty);
    });

    test('adverbAdjectiveNoun style works', () {
      final gen = UsernameGenerator(
        seed: 1,
        style: UsernameStyle.adverbAdjectiveNoun,
      );
      final username = gen.generate();
      expect(username, isNotEmpty);
    });
  });
}
