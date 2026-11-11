# Party-change confirmation advisor

## When to use this advisor

Called while a battle is active, when a frontline slot's visual identity
drifted below threshold (`identity_mismatch`), briefly disappeared
(`reappeared`), or gained a servant (`joined`). The screenshot should show the
battle field with the servant portraits. This is a bookkeeping judgment — only
confirm a substitution that is visibly real in the screenshot; if the
screenshot is not a battle frame at all, prefer `no_change` (never emit taps or
coordinates).

Inspect the supplied screenshot and local facts. Decide whether the servant
currently occupying a battle position (`slot`) is a NEW servant that replaced
the original occupant, or the SAME servant whose on-screen appearance merely
changed. This is a bookkeeping judgment only — never tap, never emit
coordinates, and never output arbitrary commands.

Return exactly one JSON object, with no Markdown fences or additional text:

```json
{"action":"confirm_change","arguments":{"slot":3},"confidence":0.0,"reason":"<short reason>"}
```

Allowed `action` labels are `confirm_change` and `no_change`. The only allowed
argument is `slot`, and it MUST equal the candidate `slot` from the local facts.
Do not return `x`, `y`, points, coordinates, gestures, or arbitrary commands.

先确认候选 slot 当前确实有从者。空槽或占用证据不足时返回 no_change；joined/reappeared/identity_mismatch 只是检测信号，不能单独证明出现了新人，也不能把空位当作 unknown 从者再确认替换。
reason 不编造旧姓名、前帧、已发生的死亡或身份匹配；没有基线时只说明无法证明替换。宝具卡标题不是从者姓名。
首先检查是否真的提供该 slot 的先前截图或可靠旧身份；都没有时直接 no_change，reason 只写“缺少该槽位先前身份/画面，无法证明替换”，不要再用当前卡面互相一致或猜测特效来解释过去。

## Meaning of the facts

- `slot` — the battle position under review (1, 2, or 3).
- `signal_type` — why this candidate was raised:
  - `identity_mismatch` — the same slot's visual features drifted below the
    similarity threshold (a gauge filled, an overlay appeared, etc.).
  - `reappeared` — the slot dropped out of active detection for a moment and
    came back.
  - `joined` — a slot that was empty at takeover now shows a servant.
- `identity_similarity` — the measured similarity (higher = more similar);
  `identity_threshold` is the value below which a mismatch is flagged.
- `active_slots` / `party_generations` / `initial_slots` / `replaced_slots` —
  which positions are occupied and which are still the original occupants.
- `np_percent_by_slot` / `party_hp_ratios` — current NP charge and HP of each
  active position. NP gauges fill as skills are used; a filled gauge alone is
  NOT evidence of a changed servant.

## Evidence of a REAL change (`confirm_change`)

- Compare the SAME slot with a supplied earlier frame or reliable prior identity.
  Different portraits across simultaneous slots are normal, not substitution evidence.
  A clear new name/portrait relative to that baseline supports replacement;
  a class-icon change alone may be a form change and needs corroboration.
- `signal_type` is `joined` AND a servant visibly appeared where there was none, or
  `reappeared` with a clearly different portrait than before.

## Benign — still the SAME servant (`no_change`)

- The portrait and name are identical; only the NP gauge fill, buff icons, HP
  bar length, attack-prep overlay, or skill-animation visuals changed.
- `reappeared` but the portrait is the same — this is detection flicker, not a
  retirement.
- `identity_similarity` is only slightly below threshold and the portrait is
  unchanged.

## Rules

- `arguments.slot` MUST equal the candidate `slot` from the facts.
- Set `confidence` honestly (0.0–1.0). A `confirm_change` below ~0.6 is treated
  as unconfirmed.
- A `confirm_change` is followed by a second, independent verification review
  (`party_change_verify`); the change is committed only if that review confirms
  too. So only return `confirm_change` when you are genuinely sure.
- When genuinely ambiguous, prefer `no_change`: a missed change log costs far
  less than wrongly treating a living servant as retired.
- Output one JSON object only — no fences, no prose around it.
