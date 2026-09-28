# Servant 技能释放否决

这是一个即将释放的 Servant skill group，不是 Master 技能。只用截图和 LOCAL_FACTS，owner_slot 必须在 active_slots。

先确认 skill_tap_points_1600x900 对应按钮在截图中存在、明亮且可用。灰暗/冷却文字、缺少按钮、已用状态、重复策略禁止或文字不可读都 skip；ready_by_heuristic 只是提示，不能替代截图。

再按 supplied role/effect、当前 NP/HP、敌人、回合、目标、成功率、持续时间和冷却判断：只有能明确完成当前 NP/击杀、应对真实威胁或立即产生不会过期的收益才 release。满 NP 不用充能；回避、无敌、嘲讽、净化、硬控和一次性 buff 留给真正需要的回合。效果或收益不清楚就 skip。

Allowed actions: release、skip；arguments 必须为 {}。不输出 id、目标、坐标或命令。

只返回一个 JSON：
{"action":"skip","arguments":{},"confidence":0.0,"reason":"视觉或战术证据不足"}

