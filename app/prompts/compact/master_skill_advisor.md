# Master 技能阶段决策

局部不确定只跳过该技能：身份、波次、伤害或某个目标收益不完整，不要求暂停整回合。有明确收益且 ready 的其余合法技能仍可规划；没有就 skip。不能输出 Servant 技能或用暂停代替本任务已有的 skip。


这是 Master/Mystic Code 阶段，不是 Servant 技能阶段。只使用截图和 LOCAL_FACTS 提供的 master skill id、合法目标、费用、冷却、重复限制、已执行动作和当前计划；不能猜技能效果，不能输出坐标或 Servant skill id。

先复核 panel_state.panel_open=true 且右侧御主面板确实展开；未展开就 skip，不自行点开。ready=false、cooldown_remaining>0 或明确 master_skills_sealed 时不可选；local_cooldown_ready 不等于实际按钮可用，visual_ready=null 时结合截图，暗色美术不单独证明冷却。used=true 只代表本场曾用，冷却结束且 ready=true 可再次使用。普通从者技能封印不自动等于御主技能封印。换人还须遵守当前 party_swap 合法集合和本次明确的前排状态限制；不能因双方有人就忽略禁止换人的状态。

按以下顺序判断：可信敌方威胁、当前攻击/NP 计划、实际目标充能缺口、控制/生存、多回合覆盖、减冷却顺序与后续资源。当前 wave 只能由 AI 直接看截图判断；不使用本地 wave 估计，场次看不清就保持 unknown。按共享战术规则比较整套效果：充能溢出不否决其他有效增益，短效爆发要当回合能用。当前阶段先于从者技能，不能假设未来从者技能已进入冷却来计算减冷却收益。冷却/目标/费用不合法就跳过；没有清晰收益就 skip，不因按钮可用而释放。

Allowed actions: master_skill_plan、plan、skip、pause_for_human。规划 arguments 必须是 {"master_skills":[{"id":"当前 master_skill_catalog 的 id","target":"按目标规则填写"}]}，只选 ready=true 的条目，不能混入 Servant 技能。none/ally_all 不带 target；ally_single 用当前合法前排字符串 "1"/"2"/"3"；enemy_single 用当前合法 "enemy1"/"enemy2"/"enemy3"；party_swap 用 {"frontline":"1","backline":"4"} 类对象且须符合当次目标、状态限制。没有安全子集返回 skip 且 arguments={}。

所有目标先确认实际占用，并属于本次合法集合。换人须确认前后排双方实际有人，不能因后排编号 4～6 存在就假定有替补；没有替补就跳过换人，单体技能不指向空槽，群体技能只计算实际在场者收益。

只返回一个 JSON：
{"action":"master_skill_plan","arguments":{"master_skills":[{"id":"mystic_code_40.skill_1","target":"1"}]},"confidence":0.0,"reason":"说明实际受益与执行依赖；示例ID和目标不是本轮授权"}

或者在当前三招都无有效用途时：
{"action":"skip","arguments":{},"confidence":0.0,"reason":"当前 Master 技能没有明确收益"}

