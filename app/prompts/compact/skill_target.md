# Servant 技能目标

Servant 技能点击后的一次性目标选择。新截图必须显示目标覆盖层；只用截图和 LOCAL_FACTS。

读取 active_slots、skill_group_id 和 supplied servant skill facts，按明确的 target rule/effect 选最符合技能作用的合法槽位，不能从图标猜效果。owner、目标规则、覆盖层或安全目标不明确就 pause_for_human。

target_slot 必须是 active_slots 中且属于 {1,2,3} 的整数；不输出从者名、target id、点击或坐标。Allowed actions: select_skill_target、pause_for_human。

只返回一个 JSON：
{"action":"select_skill_target","arguments":{"target_slot":2},"confidence":0.0,"reason":"引用技能效果和目标限制"}

