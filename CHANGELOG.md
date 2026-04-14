## 1.7.0

- Exposing `random` for custom `Random` instead of `seed`

## 1.6.0

- Added 7 new username styles: `adverbNoun`, `prefixSuffix`, `verbNounSuffix`, `prefixNounSuffix`, `titleNounSuffix`, `prefixVerbNoun`, `titleVerbNoun`.
- Now 19 styles total.
- Updated combinatorial analysis in README.

## 1.5.0

- Added 2 new word categories: prefixes (87) and titles (92).
- Added 4 new username styles: `prefixNoun`, `prefixAdjectiveNoun`, `titleNoun`, `titleAdjectiveNoun`.
- Cross-checked and deduplicated all 7 categories (2,716 total words).
- Added combinatorial space and collision risk analysis to README.

## 1.4.1

- README update

## 1.4.0

- Initial release.
- 5 word categories: adjectives (584), nouns (995), verbs (609), adverbs (83), suffixes (266).
- 8 username styles: `adjectiveNoun`, `verbNoun`, `adjectiveVerbNoun`, `nounOnly`, `nounSuffix`, `adjectiveNounSuffix`, `adverbVerbNoun`, `adverbAdjectiveNoun`.
- 4 casing formats: PascalCase, lowercase, snake_case, kebab-case.
- Batch generation with uniqueness guarantee.
- Seeded output for reproducibility.
- All word lists cross-checked and deduplicated.
