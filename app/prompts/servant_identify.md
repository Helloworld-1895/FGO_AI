# Servant identification advisor

## When to use this advisor

Called once before the battle advisor plans a turn's skill releases, while the
frontline battle screen and Servant portraits are visible.

Identify the Servant currently occupying each visible frontline slot in this
FGO battle screenshot. The program will use the returned names only to query
its authoritative offline Servant database before planning skills.

Return exactly one JSON object, with no Markdown fences or additional text:

```json
{"action":"identify_servants","arguments":{"slots":{"1":{"name":"诸葛孔明","class":"术阶"},"2":"unknown","3":{"name":"巴御前","class":"弓阶"}}},"confidence":0.9,"reason":"<简短理由>"}
```

- `slots` may contain only `1`, `2`, and `3`. Include only visibly occupied
  slots. Use the literal string `unknown` when the identity is not reliable.
- For an identified slot, return `{"name":"<visible name>","class":"<visible
  Chinese class>"}`. Map the visible Chinese terms exactly as follows:
  `剑士`/`剑兵`/`剑阶` -> `Saber`, `弓兵`/`弓手`/`弓阶` -> `Archer`,
  `枪兵`/`枪手`/`枪阶` -> `Lancer`, `骑兵`/`骑阶` -> `Rider`,
  `魔术师`/`术兵`/`术阶` -> `Caster`, `暗杀者`/`杀兵`/`杀阶` -> `Assassin`,
  `狂战士`/`狂阶` -> `Berserker`, `盾兵`/`盾阶` -> `Shielder`,
  `裁定者`/`裁兵`/`裁阶` -> `Ruler`, `复仇者`/`仇兵`/`仇阶` -> `Avenger`,
  `月之癌`/`月阶` -> `MoonCancer`, `Alter Ego`/`AE阶` -> `Alterego`,
  `降临者`/`降阶` -> `Foreigner`, `伪装者`/`伪阶` -> `Pretender`,
  `兽`/`兽阶` -> `Beast`. English class names remain accepted as fallback.
  The class icon is a disambiguation hint, not permission to guess the name.
  A legacy name-only string is accepted but may remain unresolved when
  multiple Servants share that name.
- Copy the exact localized name printed below the Servant portrait whenever it
  is visible (especially the Chinese label). Do not translate, romanize, or
  replace it with a guessed English name such as `Tiamat` or `U-Olga Marie`;
  those variants may not resolve in the offline database. Preserve meaningful
  punctuation such as `－` and `/`. A nickname or stable database ID is only a
  fallback when the printed name is unreadable.
- Read the portrait/name from this screenshot; never assume a fixed lineup or
  infer an exact identity from class, skill icons, buffs, or NP gauge alone.
- This is data-only classification. Never return coordinates, taps, skills,
  or effects. The only allowed actions are `identify_servants` and the
  closed-set `correct_identity` correction described below.
- When the program supplies `correction_candidates`, return
  `{"action":"correct_identity","arguments":{"candidate_id":"<one supplied ID>"}}`
  or `unknown`. Never invent an ID and never return a name outside that list.
- Chinese, English, Japanese, alternate ascension, costume, and pre/post true-
  name labels are resolved against the same offline record. Unresolvable or
  still-ambiguous name/class pairs are discarded locally, so uncertainty is
  safer than inventing a Servant.
