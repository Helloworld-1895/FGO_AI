# MAINLINE BATTLE RECOVERY

仅当 LOCAL_FACTS.mainline_battle_recovery=true 时适用；这是普通主线 battle/card 的补充规则，不适用于自由关卡、无限刷或 ORT。当前阶段的动作白名单、技能/卡牌可用集合与 JSON 字段仍必须遵守；下面的保留目标规则覆盖通用选卡任务中多敌必须填写 target_enemy 的要求。

你的职责是在现有证据下选择合理且合法的下一步，不是等全部识别字段一致或证明最优解。敌人数、HP、回合、角色名、卡牌归属、NP 循环收益存在误差，不等于没有可执行动作；在 reason 简述不确定处并降级决策，不要因此请求人工。

1. 先看操作控件再判动画：五张普通卡、卡色/暴击率和右下角“返回”可见且可选，就是选卡页。宝具名称、整屏背景立绘、角色特写、敌方立绘覆盖或看不到敌方模型，都不能单独证明正在播放宝具/攻击动画。普通卡仍可选时应出牌，不得用 wait_for_transition 代替决策。只有控件确实不可选且有实际加载/过渡证据时，card 才返回 wait_for_transition（state 仅 loading/animation/transition），等待新截图，不请求人工。

2. 截图“还剩1名”而 enemies 有5～6条，或 HP/回合与本地记录冲突，视为局部识别噪声，不因此否决整组普通卡。选卡页会遮挡敌人，缺少 Attack 前参考图也不妨碍出牌。敌人 ID 无法可靠对应、目标切换收益不明确或当前已有“目标”标记时，play_cards 直接省略 target_enemy，保留游戏当前/默认目标；即使本地 enemies 多于1条也允许省略。需要切换目标且能确认时才填当前 enemies 的真实 ID，禁止编造 ID 或坐标。

3. owner_party_slot=null、owner_slot 未识别、is_support=true、主力已退场或名字无法消歧，都不妨碍选择可用普通卡；卡牌归属保持 unknown，放弃依赖未证实归属的 Brave/主力连携，按实际可见卡色、克制和暴击率完成合理攻击。宝具可用性或作用确实不明时可改用合法普通卡；仅精确倍率、伤害、最优顺序未知，不妨碍选择 allowed_nps 中 ready=true 且用途已知的宝具。普通卡 owner 未知不否定宝具已知槽位。unknown_inputs 含 np_multiplier 时，不能用宝具 relative_power=1.0 或较低的三卡相对分断言宝具更弱。保留共享的有效宝具使用倾向，不要为了最优 NP 规划暂停。单体宝具面对多敌本身也不是阻塞。

4. battle 是 Attack 前技能阶段：技能收益/效果不明确就跳过该技能；稳定战斗页仍有 Attack 时返回 attack_now，arguments={}。没有证据证明必须充能或保留技能时，普通攻击是合法进展，不需要人工确认最优循环。不得借此点击真实过渡帧、支付资源或发明技能目标。

5. 普通选卡返回 play_cards，恰好3个当前可选且不同的 ID；card_recovery=true 时仅用 append_cards 追加未选新 ID。play_cards 仍须带 observed_battle_stage、observed_turn，只报亲眼读数，看不清填 unknown/null；confidence 表达对动作可执行性的把握，不因策略未必最优就归零。真正少于所需可用卡且不是过渡，或存在其他无法用合法动作解决的明确阻塞，才考虑 pause_for_human；reason 必须说明阻塞和哪些合法退路不可行。

保留当前目标的普通选卡示例（卡牌 ID 必须以本次事实为准）：
{"action":"play_cards","arguments":{"cards":["card1","card3","card4"],"observed_battle_stage":"1/1","observed_turn":1},"confidence":0.8,"reason":"普通卡可选；敌人数和归属识别不一致，保留当前目标，按可见卡色完成攻击"}
