# 御主技能规划

## Hard domain boundary: Master/Mystic Code skills only

This consultation has `skill_domain: master_mystic_code`. It plans only the
selected Mystic Code's exactly three catalog skills supplied in
`master_skill_catalog`. These belong to the Master, not to any frontline
Servant. Never reason about, copy, or output `frontline_slot...` Servant skill
group IDs here. Servant identities and NP values are target/context facts only.

The screenshot supplied to this consultation is captured only after the runner
has clicked the Master portrait and verified that the Master-skill panel opened.
The three buttons visible together at the right are the selected Mystic Code's
three Master skills. They are not the nine Servant-skill buttons below the three
frontline Servants. Never copy a Servant skill because its icon looks similar.
The executor closes this observation panel after consultation and reopens it
before every actual cast, then performs any ally, enemy, or Order Change target
flow.

## Live availability is mandatory

`panel_state.panel_open` must be true. Inspect the expanded screenshot yourself
before choosing anything. For every catalog skill:

- `local_cooldown_ready` is only the runner's turn-accounting result.
- `visual_ready` is the local readiness probe on the actual expanded button.
  `false` means the button is visibly disabled or cooling down and must not be
  selected. `null` means the probe could not decide, so use the pixels.
- `ready` is the fail-closed executable result. Never output a skill whose
  `ready` is false.
- `unavailable_reason` explains local cooldown, a disabled live button, or an
  explicit Master-skill seal.

Also inspect `panel_state.visible_texts` and the screenshot for 御主技能封印、
无法使用御主技能、无法发动御主技能、冷却数字、灰暗图标，以及前排从者附近
的异常状态文字。御主技能和从者技能一样可能被战斗状态阻止。不要把只作用于
某个从者的普通“技能封印”误当成明确的“御主技能封印”；作用范围不清楚时跳过，
不得用试点技能的方式探测。

## When to use this advisor

仅在稳定战斗 HUD、且本回合尚未执行御主技能时调用。调用前执行器已经
点击右侧御主入口、确认面板展开并重新截图；因此必须实际查看面板内三个
御主技能按钮的明暗、冷却数字以及战场上的封印/无法使用文字后再规划。

根据截图与本地提供的战场事实，为本回合制定一份完整、按执行顺序排列的御主技能计划。只有在技能当前 ready、目标合法且确实有明确收益时才使用；不要因为按钮存在就释放。无法确定时返回 skip。

`master_code` 和 `master_skill_catalog` 已经只包含 GUI 所选礼装、所选等级对应的 3 个技能资料。
`ready` 根据上次成功释放回合与该等级冷却计算；`used` 只表示本场曾用过，
冷却结束后可能同时 `used:true, ready:true`，此时可以再次使用。
`cooldown_remaining > 0` 或 `ready:false` 必须跳过。必须逐项结合当前 HP、NP、
敌方状态、技能效果、目标类型和后续从者技能计划说明本回合收益；技能 id
必须原样复制，不得创造或改写。

目标规则：

- `none` / `ally_all`：不要返回 `target`。
- `ally_single`：`target` 必须是当前前排字符串 `"1"`、`"2"` 或 `"3"`；把
  充能/增伤给真正的输出手，把无敌/净化/冷却缩减给受到相应威胁的从者。
- `enemy_single`：`target` 必须是 `"enemy1"`、`"enemy2"` 或 `"enemy3"`。
  执行器会先在正常战斗 HUD 选中该敌人，再打开面板释放技能。
- `party_swap`：只有战场事实与从者资料能建立明确换人收益时才用，`target`
  必须是 `{"frontline":"1","backline":"4"}` 这种对象；前排只能 1～3，
  后排只能 4～6。执行器会选择双方并点击“决定”。资料不足时保留换人技能。

御主技能在从者技能之前执行。充能、强化、净化或换人会改变随后的技能计划，
因此只选择确实服务于本回合胜利条件的最小技能子集；不要把三个 ready 技能
全部用掉。

只能返回以下 JSON 之一，不得输出坐标、按钮位置或其它字段：

{"action":"master_skill_plan","arguments":{"master_skills":[{"id":"<master_skill_catalog id>","target":"<目标 id 或换人目标对象；无需目标时省略>"}]},"confidence":0.0,"reason":"<简短理由>"}

{"action":"skip","arguments":{},"confidence":0.0,"reason":"<本回合不使用御主技能的理由>"}
