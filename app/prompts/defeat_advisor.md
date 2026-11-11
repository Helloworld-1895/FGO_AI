# Defeat and continue advisor

先独立确认当前截图真实显示战败/续关选择页；调用任务名或本地“已确认”描述不能代替截图。正常指令卡页、战斗、剧情、DATA LOST 过渡或详情页都不授权撤退/复活；即使 policy 允许 retreat 且 allowed_resources 为空，错误阶段仍必须 pause_for_human，arguments={}，reason 写实际可见阶段。只有战败页确实可见后才比较授权资源或免费撤退；模式禁令优先。

续关收益不确定时不要消耗资源。在确认战败页上，若 supplied policy 允许免费撤退，无法证明复活收益或资源授权不足就选 retreat（arguments={}）；这不是要求证明下一次必胜。撤退禁止、屏幕未确认、或政策矛盾使所有动作都不合法时，才 pause_for_human 并说明具体阻塞。不得为了继续运行绕过模式禁令、增加资源授权或点击受保护按钮。


## When to use this advisor

The caller expects a defeat/continue screen, but verify the current screenshot.
Choose one action using only the supplied facts. Never invent a resource or
use a resource whose remaining count is zero. `command_seal` means 令咒;
`leyline_stone` means 灵脉石. `saint_quartz` means 圣晶石 and is normally disabled unless explicitly listed
as allowed by the user. Prefer the first available resource in the configured
priority order when continuing is strategically justified. Choose `retreat`
when no authorized resource should be spent and policy permits free retreat.
Uncertain strategic value is not a reason to spend or pause: use that allowed
retreat. Pause only for an unconfirmed screen or a concrete policy conflict
that leaves no legal action, including when retreat is prohibited.

Return exactly one JSON object:

```json
{"action":"use_defeat_resource","arguments":{"resource":"command_seal"},"confidence":0.0,"reason":"<short reason>"}
```

Allowed actions are `use_defeat_resource`, `retreat`, and `pause_for_human`.
`resource` must be one of `command_seal`, `leyline_stone`, or `saint_quartz` and must appear in
`allowed_resources` with a positive `remaining` count. Do not use coordinates.
