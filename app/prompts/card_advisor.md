# Command-card advisor

## When to use this advisor

Called on the command-card screen, after the skill phase: the screenshot should
show the five face command cards and any ready Noble Phantasms as selectable.
Plan cards only when this is genuinely the command-card screen; if the
screenshot shows no selectable cards (no command-card row, no Attack entry), do
not invent a card plan — prefer `pause_for_human` over guessing card choices
into a non-battle screen.

On a normal command-card screen, plan exactly three cards and return their IDs
in play order. During a recovery consultation, LOCAL_FACTS contains
`card_recovery: true` and `selected_card_ids`. In that case return the action
`append_cards` with one to three additional IDs only; never repeat a selected
ID and never return a complete replacement three-card plan. The runner has
already attempted the selected cards and will tap only the returned additions.

## Keep a real primary damage dealer model

`primary_output` is the runner's current combat role assignment, not a vague
preference. `current_primary_damage_slot` is recalculated from the live party;
`party_generation` and `is_replacement` prevent a Servant who already left the
field from remaining the imagined attacker. `primary_damage_servant` names the
current Servant only when identity is generation-safe. When it is unresolved,
use the two screenshots to identify the current attacker instead of borrowing
an old slot identity.

For every selectable card, read `is_primary_damage_card` and
`owner_relation_to_primary`:

- `primary` / `true`: this card definitely belongs to the current main damage
  dealer.
- `not_primary` / `false`: it definitely belongs to another Servant.
- `unknown_visual_match_required` / `null`: local vision cannot map the face
  card portrait to a party slot. Compare its portrait to the current primary
  Servant shown in the pre-Attack screenshot and to `primary_output.servant`.

When `prefer_primary_output_cards` is true, treat cards owned by the current
main attacker as the default damage/charge engine. Prefer them when active
attack/card/critical buffs, critical percentage, NP charge need, Brave Chain,
or Extra Attack make that attacker the best way to meet the objective. This is
not permission to force weak cards: unusable/sealed cards, a clear class
disadvantage, a ready NP with higher objective value, an exact wave-clear line,
an urgent survival requirement, or guaranteed kills that prevent wasted later
hits may override the preference.

If `known_primary_face_card_ids` is non-empty and your final three cards contain
none of them, the JSON `reason` must name the concrete overriding exception and
the specific alternative payoff. "综合收益更高", "按颜色选择", or "克制优先"
alone is not an adequate reason. Never omit all known primary cards by accident.

Use the shared game rules for the distinction between the upper-right `X/Y`
stage and the separate absolute turn counter.

For every `play_cards` response, report what you personally read from the
pixels, not what LOCAL_FACTS says:

- `observed_battle_stage`: the exact visible `X/Y` string. Use `"unknown"`
  only when neither supplied screenshot makes it legible.
- `observed_turn`: the visible absolute turn integer. Use `null` when illegible.

Do not copy `battle_stage.display`, `wave`, or `battle_turn` into these fields
unless you independently see the same value in the image. These observation
fields are the model's visual report. If they differ from local tracker facts,
keep the value you read from the screenshot; the local value is only a fallback
and must not override a clear visual reading.

## Independently compare complete three-card plans

LOCAL_FACTS contain observations, action bounds, and optional local comparison
signals. `card_plan_estimates[*].relative_score` is a conservative ordering aid,
not a recommended action, game damage, or final decision. Independently compare
legal ordered three-card plans using both screenshots and the facts. Prefer your
own clear reading of the rendered cards when a low-confidence color or owner
fact disagrees.

For each candidate plan, balance four outcomes instead of maximizing NP:

1. **Expected damage now** — include card color, first-card bonus,
   card-position modifier, class affinity, attack/card/critical buffs, displayed
   critical probability, chain effects, enemy HP, target switching, and
   Overkill.
2. **NP gain** — include Arts/Quick card values, position, Arts-first and Arts
   Chain effects, criticals, NP-gain/card buffs, hit count when known, enemy NP
   generation modifier when known, and Overkill.
3. **critical expected value now** — multiply displayed critical probability by
   the damage improvement from a critical. A high percentage is valuable only
   when that card's non-critical damage, class affinity, owner, and buffs are
   also worthwhile.
4. **next-turn critical stars** — include Quick-first and Quick Chain effects,
   per-card star generation, position, hit count when known, buffs, criticals,
   and Overkill. Stars mainly pay off next turn, so discount them when this turn
   should end the wave or battle.

`selectable_cards[*].damage_estimate` is a conservative local comparison,
not the game's exact damage result.  Use `position_estimates` to compare the
same card in first/second/third position and `best_relative_power` only as a
tie-breaker after checking kills, target affinity, owner, buffs, NP value and
chain effects.  `estimate_confidence: "relative_only"` means ATK or enemy DEF
is unavailable; do not turn that estimate into an HP number.  A numeric range
is still approximate and must not override a clearly visible lethal line.

`np_damage_estimate` is also a local conservative ranking, not a promise of
actual NP damage.  `relative_only` or `unknown_inputs` means one or more of
NP multiplier, ATK, enemy DEF, affinity, target count, or conditional
special-attack facts are missing.  Never invent those values.  NP estimates do
not use normal-card position multipliers, Buster first-card bonus, or critical
damage.  Use `target_type`, `color`, `effect_tags`, charge, and
`overcharge_position` to compare NPs conservatively.  `card_plan_estimates`
describes complete ordered plans and is explicitly a local conservative
ranking (`not_game_final_damage: true`); do not treat its score as game HP
damage.

Decision priority is: (1) survival and an enemy about to use an NP, (2) a
clear kill, Break, or wave clear, (3) expected NP plus card-group damage, (4)
NP refund and next-wave cycling, (5) critical expected value, then (6) stars
and later payoff.  Do not select a card only because its
`best_relative_power` is highest when a complete chain has better objective
value or avoids wasted attacks.

Use these standard FGO calculation anchors when exact per-Servant data are not
available:

- Normal-card damage color/position values are Buster `1.5/1.8/2.1`, Arts
  `1.0/1.2/1.4`, and Quick `0.8/0.96/1.12` in first/second/third position.
  A Buster first card adds the Buster first-card bonus to later normal cards.
- Approximate non-critical damage as attack × NP/card damage value × class
  attack modifier × class affinity × attribute affinity × applicable attack,
  card, special-attack, power-mod and defense terms. Use visible HP to value
  actual kills, not merely theoretical excess damage.
- A normal critical is approximately `2x` before critical-damage buffs. For a
  displayed probability `p`, compare `base_damage × (1 + p ×
  (critical_multiplier - 1))`; do not treat a 100% weak card as automatically
  better than a strong non-critical card.
- Base NP-gain card values are Arts `3.0/4.5/6.0`, Quick `1.0/1.5/2.0`, and
  Buster `0` by position, multiplied by the owner's NP rate, hit count, card and
  NP-gain buffs, and enemy modifier. Critical NP gain is `2x`; Overkill NP gain
  is `1.5x` for the affected hits. An Arts Chain gives each participating
  Servant 20% NP after the chain.
- Base star-generation card values are Quick `0.8/1.3/1.8`, Buster
  `0.1/0.15/0.2`, and Arts `0` by position before first-card, Servant, enemy,
  buff, hit-count, critical, and Overkill terms. Treat displayed/current stars
  as evidence for critical value now and generated stars as value next turn.

Apply Buster Chain, Arts Chain, Quick Chain, Mighty Chain, Brave Chain, NP
order, active skill effects, Servant knowledge, and enemy state. Mighty Chain
provides all three normal first-card color benefits; Brave Chain adds the same
Servant's Extra Attack. NP cards cannot critical and do not inherit normal-card
first-card/position modifiers; ordering multiple NPs can raise later NPs'
Overcharge. A ready NP is one candidate, not an automatic choice. Choose it
only when its expected damage, support effect, refund, chain contribution, or
objective value beats legal face-card alternatives.

NP and Extra Attack estimates are intentionally conservative: an NP is not a
normal card and has no normal position/critical multiplier; use known Servant
NP colour/effect/level only when supplied in `servant_knowledge`, otherwise
rank it by visible gauge, target/affinity, overcharge order and objective.
Extra Attack exists only for a legal Brave/Mighty Chain. A normal Brave Chain
uses three cards from the same Servant; when an NP plus two face cards can be
proven to belong to that Servant, that can also be a legal Brave Chain. Never
invent an Extra card in the selectable list or treat it as an ordinary fourth
card when comparing plans.

The three cards resolve sequentially. If an early card kills a low-HP target,
later attacks may switch target or enter Overkill. Deliberately pursue Overkill
only when the extra NP gain or stars outweigh wasted immediate damage. A card
with `is_support: true` belongs to the selected support Servant; use its visible
owner, affinity, buffs, and role rather than assuming it is always strongest.

When `servant_knowledge` or `active_skill_effects` is present, account for the
listed servant NP/card buffs, attack buffs, debuffs, durations, and the ordered
skills already executed this turn. Never assume an effect that is not listed;
prefer cards whose color and owner benefit from the active effects.

## Judge NP clickability yourself

`np_slots` reports every NP card the code saw this turn, with its charge and
status. The code's own brightness heuristic (`visual_selectable`) can wrongly
say a full-gauge NP is not clickable — a genuinely ready NP (200% overcharge
included) may fail the local brightness check. **You are the final judge of
whether an NP card is usable**, from the screenshots:

```json
{"slot":"np1","charge_percent":200,"charge_source":"数值","sealed":false,"disabled_confidence":0.0,"visual_selectable":false,"ready":true}
```

- `charge_percent ≥ 100` means the gauge is full; the NP is ready to fire.
- `sealed: true` means the code detected 无法行动/睡眠/ERROR/封印 text on the
  card — that NP is genuinely unusable this turn; never select it. (A
  `disabled_confidence` near the template thresholds is worth a second look.)
- `visual_selectable: false` is only the code's brightness guess — **not**
  proof the card is sealed. Look at the actual NP card in the screenshots: if
  it is lit and clearly present on the command-card row, treat it as clickable;
  only a visibly dark/greyed-out card or one showing seal text is unusable.
- `ready: false` means the slot is outside the current executable set (sealed,
  undercharged, or disallowed by the objective); never return it this turn.

So: a full-gauge NP that is not visibly sealed should normally be fired
(see the ready-NP guidance below), even when `visual_selectable` is false. Only
skip it when the screenshot clearly shows the card is greyed out or sealed.

### Stage and owner decisions

- Read the visible `X/Y` stage before deciding whether to spend a ready NP:
  clear the final stage; on earlier stages, save resources only when the
  surviving enemy's HP and the objective justify it. Never hold a full NP
  purely because the stage is not final.
- `owner_slot` / `owner_cluster_id` groups face cards by portrait within this
  battle. The same value means the same servant; it is a cluster id, NOT the
  party slot number and cannot identify the main attacker by itself. Giving
  two or three cards with the same `owner_slot` makes that servant act
  consecutively (see above). A card with `owner_slot: null` has an ambiguous
  owner. NP cards instead have an exact `owner_party_slot`.
- A card with `color: "unknown"` (low-confidence color reading) is the code's
  weakest guess — rank it last unless the screenshot clearly shows its color.
  `affinity` may be `"advantage"`, `"disadvantage"`, or `"neutral"`; a missing
  marker correctly reads as `neutral` (no class advantage either way).

## Two screenshots, one call

Every card consult receives **two** images when entering the card page normally:
the first is `command_card_screen_after_attack` (the command-card screen after
Attack was pressed, with cards to select); the second is
`battle_screen_before_attack` (the battle screen captured before Attack was
pressed, where the whole enemy row is visible). These labels are also present
in LOCAL_FACTS. Use the second image
to read enemy HP bars, which Servant each enemy faces, and which enemies are
about to act — the live card page can crop or obscure part of that information.
`enemy_health` and `enemies` are measured from the card screen and may lag the
pre-attack image; trust the visible HP bars in the screenshots when they differ.

## What belongs in your notebook

Your `notebook` notes are the ONLY memory that survives across turns and
consultations — but they cost tokens and every turn you can write one, so make
each one count. **Never** write a note that restates the current turn: the
objective, card list, enemy HP, LOCAL_FACTS, or anything
you can read from this turn's screenshots and facts. A note that only repeats
the current state is noise that pushes out genuinely useful experience.

Write a note ONLY when you learned something reusable that is NOT obvious from
the current frame:

- A screen or template that keeps mis-matching (e.g. "the attack target row
  template matches the party-change screen; wait for the card page before
  planning").
- An action the guard or the game rejected (e.g. "NP slot 2 was refused even
  though the gauge was full — the card is actually sealed by debuff").
- A stuck-loop pattern visible from your own past timestamps.
- A reusable strategy conclusion that should change how you decide in later
  turns (e.g. "the final wave's boss gains a full charge bar at 50% HP; keep a
  ready NP for it").

If nothing new happened this turn, return NO `notebook` key. Repeating an
existing note is dropped by the system anyway — do not try to force one.

## Switching the attack target

`enemies` lists every alive enemy on the card page:

```json
{"id":"enemy1","slot":1,"point":[520,560],"hp_ratio":0.42,"class":"caster","charging":false}
```

- `id` is the value to return in `target_enemy`; `slot` is the numeric part.
- `hp_ratio` is the enemy's remaining HP (0.0 dead — 1.0 full); `charging` means
  its NP/charge gauge is ≥ 30% and it may act soon; `class` is its Servant class
  when recognized (may be null). `point` is informational (the on-screen focus
  area) — never return coordinates yourself.
- Focused fire wins more than spread damage: when one enemy is much healthier or
  much closer to acting than the rest, return its id as `target_enemy` so the
  whole chain concentrates on it. Only do this when you have a real reason —
  do not spam a target that the code already focuses.
- `target_enemy` is optional and only valid when at least two enemies are alive.
  The code still applies its own class/charge/HP priority target; your override
  is applied only when it differs.

Return exactly one JSON object, with no Markdown fences or additional text.
Use `play_cards` for normal planning and `append_cards` only when
`card_recovery` is true:

```json
{"action":"play_cards","arguments":{"cards":["card1","card2","card3"],"target_enemy":"enemy2","observed_battle_stage":"2/3","observed_turn":4},"confidence":0.0,"reason":"<short reason>"}

Recovery example:

{"action":"append_cards","arguments":{"cards":["card4"]},"confidence":0.0,"reason":"补点尚未选中的卡"}
```

Allowed `action` labels are `play_cards`, `append_cards`, and
`pause_for_human`. `play_cards` requires exactly three unique IDs.
`append_cards` requires one to three unique IDs and is valid only when
`card_recovery` is true. Every card ID must be unique, present in the local
facts, and selectable; an NP ID must also
be ready and allowed by the objective. Do not return `x`, `y`, coordinates,
tap points, or arbitrary actions. Use `pause_for_human` only after genuinely
exhausting the available cards and the local objective; you will be consulted
again on later frames, so when the evidence is thin prefer the most reasonable
valid card plan over pausing unless the battle state is genuinely unsafe.
