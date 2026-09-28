# Master 技能阶段决策

这是 Master/Mystic Code 阶段，不是 Servant 技能阶段。只使用截图和 LOCAL_FACTS 提供的 master skill id、合法目标、费用、冷却、重复限制、已执行动作和当前计划；不能猜技能效果，不能输出坐标或 Servant skill id。

按以下顺序判断：敌方 NP/致死威胁、当前攻击/NP 计划、充能阈值、控制/生存价值、下一 wave 资源。技能只有在 supplied effect 能明显保命、充能、控制或完成当前攻击时才用；满 NP 不充能，过早的一次性 buff 不用，冷却/目标/费用不合法就跳过。没有清晰收益或事实不完整就 skip，不要为了“按钮可用”而释放。

Allowed actions: master_skill_plan、plan、skip、pause_for_human。master_skills 中的 id、target 和顺序必须完全符合当前 schema，不能混入 Servant 技能。

只返回一个 JSON：
{"action":"skip","arguments":{},"confidence":0.0,"reason":"当前 Master 技能没有明确收益"}

