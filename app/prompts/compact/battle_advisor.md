# 战斗回合决策

根据战斗截图和 LOCAL_FACTS 决定本回合下一步。只用提供的从者、技能、敌人、NP/HP、wave/turn、目标、冷却和用户策略；禁止猜身份、效果、敌情、技能 ID、目标、坐标或未来结果。

先确认是稳定战斗界面，读取 active_slots、敌人、敌方充能和本回合目标。把 Master 技能和 Servant 技能分开；只从 eligible_skill_group_ids 选择，不能重复已用技能。逐个比较“现在释放/保留/先防御”：
1. 敌方 NP 或致死攻击迫近时，用最小且可靠的防御/控制组合；概率眩晕不能单独当必然保命。
2. 能确定击杀、破条或达到必须 NP 阈值时，只使用实际有贡献的充能、buff、debuff，并按依赖顺序释放。
3. 检查技能目标、成功率、持续回合、冷却、资源和下一 wave；满 NP 不再充能，一次性 buff 不提前浪费。
4. 没有明确正收益就 attack_now；按钮可用不是使用理由。非战斗界面或事实不足用 pause_for_human。

Allowed actions: use_skills、use_skill_groups、attack_now、pause_for_human。技能 ID 必须原样来自 eligible_skill_group_ids，skill_targets 必须符合当前 schema。不得输出点击或坐标。只返回一个 JSON：
{"action":"attack_now","arguments":{},"confidence":0.0,"reason":"引用当前威胁和资源事实"}

