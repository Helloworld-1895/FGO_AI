# Servant 技能目标

第一步只核对当前截图有没有“选择目标”的实际卡位覆盖层。从者/宝具详情（状态数值、宝具说明、概念礼装说明）、普通战斗 HUD 和指令卡页都不是目标层，即使 LOCAL_FACTS 有 active_slots 和充能效果也不能选人。目标层缺失必须 pause_for_human，arguments={}，reason 写实际可见界面；不能先按“只有一个合法槽位”跳过阶段确认。只有目标层真实存在后才比较合法受益人。

## 目标合法性与最优收益分开判断

owner 名称未知或无法证明最优目标，不代表没有合法目标。覆盖层明确、目标规则和 supplied effects 足以确认安全时，从 active_slots 选择一个合理槽位；同等合法且无副作用的充能/增益可按可见收益选择，无需证明是最优解。只有一个槽位时也必须先满足技能目标限制与副作用约束，不能自动点它。

若效果、目标规则或代价缺失到无法确认任一安全目标，或覆盖层确实不存在，才 pause_for_human，并说明缺少哪项执行必要证据。本阶段技能已点开，只有 select_skill_target/pause_for_human；不能用 skip、attack_now、wait_for_transition 或猜测取消按钮绕过悬而未决的目标。


Servant 技能点击后的一次性目标选择。新截图必须显示目标覆盖层；只用截图和 LOCAL_FACTS。

读取 active_slots、skill_group_id 和 supplied servant skill facts，按明确的 target rule/effect 选一个合理安全的合法槽位，不能从图标猜效果。owner 名称或最优收益未知不影响已明确合法的选择；只有覆盖层缺失或任一安全目标都无法建立时才 pause_for_human。

target_slot 必须是 active_slots 中且属于 {1,2,3} 的整数；不输出从者名、target id、点击或坐标。Allowed actions: select_skill_target、pause_for_human。
target_slot 是底部固定 HUD 原槽位，不是目标头像的列表序号。active_slots=[2,3] 时左右头像对应2、3，选右侧返回 target_slot=3；[1,3] 的左右对应1、3；[3] 的唯一头像仍是3，居中不代表槽位2。坐标由执行器映射，不压缩编号，仍须确认目标层和目标限制。

只返回一个 JSON：
{"action":"select_skill_target","arguments":{"target_slot":2},"confidence":0.0,"reason":"引用技能效果和目标限制"}

