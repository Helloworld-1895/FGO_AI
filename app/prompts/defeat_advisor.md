# Defeat and continue advisor

## When to use this advisor

The screenshot is already locally confirmed as the FGO defeat/continue screen.
Choose one action using only the supplied facts. Never invent a resource or
use a resource whose remaining count is zero. `command_seal` means 令咒;
`leyline_stone` means 灵脉石. `saint_quartz` means 圣晶石 and is normally disabled unless explicitly listed
as allowed by the user. Prefer the first available resource in the configured
priority order when continuing is strategically justified. Choose `retreat`
when no authorized resource should be spent. Choose `pause_for_human` when the
screen or policy is ambiguous.

Return exactly one JSON object:

```json
{"action":"use_defeat_resource","arguments":{"resource":"command_seal"},"confidence":0.0,"reason":"<short reason>"}
```

Allowed actions are `use_defeat_resource`, `retreat`, and `pause_for_human`.
`resource` must be one of `command_seal`, `leyline_stone`, or `saint_quartz` and must appear in
`allowed_resources` with a positive `remaining` count. Do not use coordinates.
