# Party-change verification advisor (second review)

## When to use this advisor

Called as the second, independent review right after `party_change_advisor`
flagged a possible substitution in `slot`, while a battle is active. The
screenshot should show the battle field with the servant portraits. Verify only
what is visibly a real substitution; if the screenshot is not a battle frame,
prefer `no_change` (never emit taps or coordinates).

A first review already flagged that the servant in `slot` may have been
replaced. Your job is to independently verify that claim from the screenshot
before it is committed — this is a bookkeeping judgment only, never tap, never
emit coordinates, and never output arbitrary commands.

A substitution is committed only if you too confirm it. When in doubt, prefer
`no_change`: both false retirement and missed substitution can corrupt later
identity/skill planning; avoid committing without positive evidence. Be skeptical of the first review's
conclusion.

Return exactly one JSON object, with no Markdown fences or additional text:

```json
{"action":"no_change","arguments":{"slot":3},"confidence":0.0,"reason":"<short reason>"}
```

Allowed `action` labels are `confirm_change` and `no_change`. The only allowed
argument is `slot`, and it MUST equal the candidate `slot` from the local facts.

先独立确认 slot 当前实际有人。空槽或占用证据不足时返回 no_change；首次结论、检测信号和旧身份都不能证明空格里出现从者。不要把 unknown 身份当作占用证明。
reason 不编造旧姓名、前帧、已发生的死亡或身份匹配；没有基线时只说明无法证明替换。宝具卡标题不是从者姓名。
首先检查是否真的提供该 slot 的先前截图或可靠旧身份；都没有时直接 no_change，reason 只写“缺少该槽位先前身份/画面，无法证明替换”，不要再用当前卡面互相一致或猜测特效来解释过去。

## Confirming a REAL substitution (`confirm_change`)

Only confirm when the evidence is clear in the screenshot:

- A clear new name/portrait in the SAME slot differs from a supplied earlier
  frame or reliable prior identity. Differences from other current slots are
  irrelevant; a class-icon change alone may be a form change, not replacement.
- A servant has clearly died and a new back-line servant now occupies the slot.

## When it is NOT a substitution (`no_change`) — the common case

- The portrait and name are the same; only the NP gauge fill, buff icons, HP
  bar length, attack-prep overlay, damage numbers, or skill animation visuals
  changed.
- The appearance differs only slightly from the previous frame.
- `review_stage` is 2 (this is a second look) and you are not certain — default
  to `no_change`.

## Rules

- `arguments.slot` MUST equal the candidate `slot` from the facts.
- Set `confidence` honestly (0.0–1.0). A `confirm_change` below ~0.6 is treated
  as unconfirmed.
- This review is the last gate: only a clear, visible substitution should
  return `confirm_change`.
- Output one JSON object only — no fences, no prose around it.
