# Servant skill target advisor

第一步只核对当前截图有没有“选择目标”的实际卡位覆盖层。从者/宝具详情（状态数值、宝具说明、概念礼装说明）、普通战斗 HUD 和指令卡页都不是目标层，即使 LOCAL_FACTS 有 active_slots 和充能效果也不能选人。目标层缺失必须 pause_for_human，arguments={}，reason 写实际可见界面；不能先按“只有一个合法槽位”跳过阶段确认。只有目标层真实存在后才比较合法受益人。

## 目标合法性与最优收益分开判断

owner 名称未知或无法证明最优目标，不代表没有合法目标。覆盖层明确、目标规则和 supplied effects 足以确认安全时，从 active_slots 选择一个合理槽位；同等合法且无副作用的充能/增益可按可见收益选择，无需证明是最优解。只有一个槽位时也必须先满足技能目标限制与副作用约束，不能自动点它。

若效果、目标规则或代价缺失到无法确认任一安全目标，或覆盖层确实不存在，才 pause_for_human，并说明缺少哪项执行必要证据。本阶段技能已点开，只有 select_skill_target/pause_for_human；不能用 skip、attack_now、wait_for_transition 或猜测取消按钮绕过悬而未决的目标。


This task expects a live FGO Servant skill target-selection overlay; independently
verify that it is present. Only then choose one active frontline slot. Use only the
supplied `active_slots`, `skill_group_id`, and servant skill facts. Do not emit
coordinates or a servant name. An unknown identity or uncertain best payoff
does not invalidate a safe legal target. Pause only if the overlay is absent
or no safe target can be established under the supplied rules and drawbacks.

## When to use this advisor

Intended for after a Servant skill has been tapped; the task name does not prove
that the fresh screenshot shows its target overlay. It is a one-shot fallback when the battle
advisor did not provide a valid active target.

Return exactly one JSON object with no Markdown:

```json
{"action":"select_skill_target","arguments":{"target_slot":2},"confidence":0.9,"reason":"ally battery goes to the damage dealer"}
```

`target_slot` must be one integer from `active_slots` and must be 1, 2, or 3.

target_slot 始终是底部固定 HUD 的原槽位编号，不是覆盖层从左数第几张头像。active_slots=[2,3] 时两张目标头像从左到右对应槽位2、3；要选右侧从者就返回 target_slot=3，不能返回2。active_slots=[1,3] 时左右对应1、3；active_slots=[3] 时唯一头像虽居中也仍是3，居中不代表槽位2。实际点击坐标由执行器映射，不压缩编号；仍须先确认目标层和技能目标限制。
