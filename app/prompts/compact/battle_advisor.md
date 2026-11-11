# 战斗回合决策

先做画面阶段门，再看技能候选。若当前是从者/宝具详情、技能说明、编成、结果或其他遮挡战斗操作的弹窗，不能因底层战斗背景、HP/NP 或 eligible 列表为空就 attack_now。必须看见当前可操作的 Attack/技能 HUD 且无阻塞覆盖层，才能规划技能或跳过技能攻击。本任务没有关闭弹窗动作；详情等错误阶段应 pause_for_human（arguments={}），reason 指出具体覆盖层，交回恢复流程。此门仅限制错误阶段，不因正常战斗页的技能/身份/伤害未知而暂停。

敌人数冲突不妨碍跳过技能。敌人计数、HP、角色身份或 wave 不完整，只限制依赖这些信息的技能计划，不使稳定战斗页上的 Attack 失效。未知技能只跳过该项；有可靠收益的合法技能仍可选，其余用 attack_now 进入选卡。charging=true 不等于下一步必放宝具，也不等于已证实致死；普通战斗风险或无法证明必杀，不能作为人工阻塞。只有阶段错误且无本任务合法动作、或明确受保护风险无法解决时才 pause_for_human。本任务没有等待动作，不能编造 wait_for_transition。

## Current servant guidance

Combine structured skill effects and targets with usage_guidance when planning. Recommend Oberon's third skill only when this turn's Buster or Noble Phantasm gain is clear and permanent sleep after the turn is acceptable.

根据战斗截图和 LOCAL_FACTS 决定本回合下一步。只用提供的从者、技能、敌人、NP/HP、turn、目标、冷却和用户策略。当前 wave 只能由 AI 直接看截图判断；不使用本地 wave 估计，场次看不清就保持 unknown。禁止猜身份、效果、敌情、技能 ID、目标、坐标或未来结果。

当前只是 Attack 前的技能阶段，选卡由后续 card 顾问处理，故没有 selectable_cards 是正常的。技能候选为空不代表需要人工；稳定战斗界面中 eligible_skill_group_ids 为空、全部冷却或没有技能收益时返回 attack_now，arguments 必须为 {}。不能因没有卡牌列表暂停，也不能返回 play_cards 或在 arguments 添加 observed_battle_stage/observed_turn。

## 一次性规划整个技能阶段

读取 battle_context.active_slots、np_percent_by_slot、敌方威胁及 servant_knowledge；用每个候选的 servant_skill_effects/target/duration/cooldown/usage_guidance 对应实际技能。小模型按四步逐个判断候选：①读明确效果与合法目标；②若至少一个已知效果能帮助当前目标或有事实支持的后续回合，就暂定使用；③只有明确代价超过收益、效果当前确实无用，或存在具体更佳后续用途时才保留；④将所有暂定使用的技能按依赖排序。无需证明必杀、精算伤害或比较复杂的多套计划；一个明确用途且无明确大代价就足够。默认倾向使用已知有用的就绪技能，不能用“也许以后有用/也许溢出/不一定最优”作为跳过理由。充能溢出不否决复合技能中的增伤、NP 获得量、减冷却或保护；充能当前无用而其他效果有用时仍可使用。快速算作有用：本回合宝具充能、当前攻击增益/降防、覆盖实际行动的长效 buff、实际 NP 回收、处理当前异常、应对已出现致命威胁的防御。纯暴击/集星技能在无当前卡面时不猜卡，但不能因此跳过同招其他明确有效果。再按共享的“战术收益与资源预算”处理效果依赖、代价和资源。

输出顺序就是执行顺序，可以跨从者穿插。只给确有依据的依赖排序：①先解除阻止后续技能的封印，或满足明确的 NP/目标/形态前置；②要减冷却的已选技能先放，再放减冷却技能；③消耗 NP、封锁行动或有延迟代价的技能放到依赖该资源/行动的已选效果之后；④其他增益/降防只需在 Attack 前生效。长效 buff 可早放以启动冷却，短效爆发/降防可放序列后方便贴近攻击，但时长本身不构成硬依赖。没有依赖时按当前生存威胁 > 本回合宝具/循环 > 本回合伤害 > 纯后续收益；同类按明确 when/priority，仍相同就任选稳定顺序，不要过度推演。先满足所有硬依赖再输出完整 ID 顺序。不按从者槽位排序，不用固定充能优先口诀。只复制 eligible_servant_skill_group_ids；ready/priority/when 是线索，不是必须使用的建议。该集合外技能不因预期减冷却就变合法。不能返回重复 ID，也没有固定“最多用几个”的策略。

Master 阶段已经先行处理，master_skill_actions_this_turn 是已执行历史，不能再次输出其 ID 或重复叠加充能；新截图与 NP 读数为当前基线。Attack 前没有本轮五张卡，不凭空承诺暴击/Brave。未知效果只跳过对应项，有效的其余组合仍可释放。只有全部候选都没有已知用途，或每项都有具体保留理由时才 attack_now；reason 简述为何留下技能。

选中的定向单体技能应同时在 skill_targets 给出受益 active slot（整数 1/2/3），只为已选技能填项，不能默认全部给技能 owner 或固定主力。执行器只在确实弹出目标层时应用映射。所有技能由本次 battle 一次性规划；执行中会本地复查可用性，不能期待逐技能顾问重新优化或补充未选技能。

reason 简短写“目标；关键技能给谁及收益；为何这个顺序；保留用途”。无法证明精确击杀不妨碍有证据的合理技能；按钮亮着、技能数量多或暂时没用过都不是理由。

Allowed actions: use_skill_groups、attack_now、pause_for_human。从者技能 ID 必须原样来自 eligible_servant_skill_group_ids（或 eligible_skill_group_ids 的从者技能子集），skill_targets 必须符合当前 schema；不能输出旧 use_skills、Master ID、点击或坐标。只返回一个 JSON：
{"action":"attack_now","arguments":{},"confidence":0.0,"reason":"引用当前威胁和资源事实"}

有定向技能的合法输出结构（ID、目标与收益须换成当前事实，不照抄）：
{"action":"use_skill_groups","arguments":{"skill_group_ids":["frontline_slot1_skill1","frontline_slot2_skill1"],"skill_targets":{"frontline_slot2_skill1":1}},"confidence":0.9,"reason":"先开启1位长效增益并启动冷却，再由2位技能给1位减冷却；保留纯防御应对后续威胁"}
