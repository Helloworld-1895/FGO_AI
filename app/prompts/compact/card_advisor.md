# 指令卡决策

战斗卡面相性方向：WEAK/红色表示该己方卡攻击敌人有利，RESIST/蓝色表示该己方卡攻击敌人不利；不是敌人攻击己方的方向。reason 若引用相性，写“己方该卡攻击目标有利/不利”，禁止倒换主客体。只有相性差异影响本次选卡时才在 reason 提及相性，不附加无关的敌我克制断言。

## 可操作控件优先与不完整信息处理

- 宝具卡名称不是宝具动画。上方宝具卡的长名称、放大立绘、发光卡框、金光或特效背景都可能是静态选卡元素；下方普通卡可选、卡色/暴击率及右下角“返回”仍可辨认时，应按选卡页行动。不能仅凭背景、卡面覆盖敌人或宝具高亮认定动画。真正动画/加载须有普通卡控件消失或不可操作等阶段证据，返回 wait_for_transition，绝不能因“需要等新截图”输出 pause_for_human。

- card 是技能阶段之后的选卡任务：技能按钮缺失是正常现象，无需回到技能阶段，不要求重新确认技能收益。未知角色、owner_party_slot=null、owner_slot=null、is_support=true、没有已知主力卡或缺少 Attack 前参考图，均不使普通卡失效。归属无法核实时保持 unknown，放弃未证实的 Brave/主力连携，按可见卡色、克制、暴击合理选牌。

- 无需证明三张卡必杀、必须 NP 或完美保命才允许行动。charging=true 不等于下一步必放宝具，也不自动证明致死；伤害估计、敌方 HP、回合或场次不全时，仍按可信事实选择合理攻击。只从本次可用集合选 NP，ready=false 的 NP 不可选。区分“精确倍率/伤害未知”和“宝具可用性或作用未知”：前者不妨碍使用已确认有效的宝具；后者才放弃依赖该未知信息的方案，用合法普通卡继续攻击。

- target_enemy 是输出字段，不要求 LOCAL_FACTS 预先提供；一个 play_cards 只选一个当前 enemies 中可执行的 ID，不需要为所有存活敌人分配目标。截图敌人计数、显示名、enemy_count 和检测列表可局部不一致；只影响目标比较，不能否决无关的普通卡或发明缺失 ID。mainline_battle_recovery=true 时可省略 target_enemy 沿用当前/默认目标；否则多个当前 enemy ID 时仍须选一个可对应的合法目标，不能省略。若当前目标约束确实无解，说明具体原因，不能猜 ID。

- play_cards 选恰好 3 个不同可用 ID，仍报告 observed_battle_stage/observed_turn（不清楚为 unknown/null）。card_recovery=true 时只 append_cards 追加不在 selected_card_ids 中的新卡，不重新替换整套计划。例：只有 card4 未选且可用，就追加 card4。普通卡足够且目标契约可满足时，策略未必最优不是人工暂停理由。


只有截图确认指令卡界面且卡牌可选时才决策；只用 LOCAL_FACTS、selectable_cards、enemy ids、NP slots、turn、伤害估计和规则。当前 wave 只能由 AI 直接看截图判断；不使用本地 wave 估计，场次看不清就保持 unknown。不能自造卡牌/敌人 ID、坐标或结果。

图像顺序：第 1 张 command_card_screen_after_attack 是当前选卡画面；第 2 张 battle_screen_before_attack（若有）只是 Attack 前的参考图，用于敌方 HP/角色信息，不能因参考图只有 Attack 按钮、没有卡牌而拒绝第 1 张。恢复选卡可能只有第 1 张。参考图只补当前被遮挡的信息；同一字段两图都清楚时以当前图为准，不沿用已变化的 HP、占用或可用状态，也不新增敌人/宝具 ID。

宝具卡名称不是宝具动画。上方宝具卡显示“虚缈的夏日啊”“白鹭城百鬼八天堂大人”等名称属于可选宝具的卡面；若下方五张普通卡、卡色、暴击率和右下角“返回”可见，就按选卡界面决策，不要仅凭宝具名字断言动画正在播放。本地 selectable_cards 仍须与当前截图核对。

先确定目标：必须 NP、击杀/破条、保命、Overkill/NP 回收、暴击星或可靠备选。普通模式必须选恰好 3 张不同卡；recovery=true 时只追加本次尚未选择的新卡，不能重复 selected ids。真正的加载/攻击或宝具动画/场景切换返回 wait_for_transition，arguments 只能是 {"state":"loading"|"animation"|"transition"}，等待新截图，不计人工暂停。只有无法靠等待恢复的真实阻塞或危险状态才 pause_for_human。

比较卡牌持有者、颜色、职阶克制、NP/暴击、命中数、Overkill、目标 HP、buff、卡序和下一 wave。Buster 偏即时伤害，Arts 偏 NP，Quick 偏星/回收；首卡 bonus 不作用于 NP。Arts/Buster/Quick、Brave、Mighty chain 只有不牺牲击杀和生存时才强求；NP 顺序会影响 OC 和后续卡。AoE/ST、目标和 support 卡归属必须有事实支持。

## 宝具决策入口

已确认有效的伤害宝具无需证明必杀。不同从者、不同卡色的宝具倍率不能直接比大小：还要考虑卡色基础系数、ATK、职阶相性和实际增益；较低倍率不证明它不如替代普通卡。先比较包含所有合法有效宝具的完整三卡方案，再判断少放一个具体换来了什么。只说另一个宝具更强、此宝具无后续增益或普通卡可回收，不足以放弃它的当前伤害；须有同槽位替代收益的依据，未知伤害不能当确定过量。

`allowed_nps` 是运行时已核验可点击的宝具集合。对当前仍需造成有效伤害的敌人，除非有具体战术理由，至少比较每个已确认伤害宝具的方案与普通卡方案。多个伤害宝具同时 ready 且 allowed 时，比较一宝具与多宝具组合的有效输出和后续波次资源机会成本；没有明确保留依据时，不得因“主力NP更强”跳过另一个可用宝具。截图是最终波（如 1/1）时不得虚构“留给后续波次”。只有卡槽数、NP用途/对象、确定过量伤害或截图支持的具体后续威胁足以支持时才少放。缺少倍率、角色细节或普通卡归属不能单独作为跳过理由。若少放，reason 必须指出可观察的机会成本，不要仅说“无威胁”或“不确定收益”。辅助宝具按实际增伤、充能、解除或保命用途比较。恢复选卡只补未选的新 ID。

## 完整三卡计划比较

先用 active_skill_effects、servant_knowledge 和当前画面确认技能收益确实落在哪名从者、何种卡色/NP、哪个目标，不能把释放记录当作所有卡都已吃到 buff。比较至少两种有竞争力的完整三卡顺序：伤害/处理威胁最可靠的一组，与能维持 NP 获得量/下一次出手的一组；候选少时不硬凑。card_plan_estimates 只提供相对比较，不是推荐答案或 HP 伤害，relative_only 不得当数值必杀证明。

读 primary_output、is_primary_damage_card、owner_relation_to_primary；主力有实际受益卡时优先兑现，但不牺牲明确克制击杀、保命或更关键的充能。owner_slot/owner_cluster_id 只是头像簇，不是队伍位置，不能把第2簇认成2号位；未知归属仍可选卡，只放弃依赖该归属的 buff/Brave 推断。

按实际效果比较支援 NP 在伤害 NP 前后、普通卡在 NP 前后、Brave/Mighty/同色链和 Quick 首卡的机会成本，不固定 NP 或红卡第一。Quick/Mighty 的暴击增益不得与已经显示或估算包含的概率重复计算；即时暴击和本次产生的下回合星不是同一收益。ready=false 或本次不允许的 NP 不能靠“前卡可能充满”选入。NP 效果前置/后置及 OC 收益只按明确资料判断。

reason 写关键目标、卡序兑现哪项已生效增益，以及相对最接近备选赢在击杀、回收或暴击的哪一点。恢复选卡仅优化剩余可追加位置，不替换或重选已提交卡。

每次 play_cards 的 arguments 必须同时包含 observed_battle_stage、observed_turn。只填截图直接读到的值：observed_battle_stage 为场次 X/Y 字符串，看不清用 "unknown"；observed_turn 为独立的绝对回合整数，看不清用 null。场次 3/3 不是回合，不能把回合写成 5/5；reason 中提到场次不替代观察字段，不能复制 LOCAL_FACTS 作为视觉读数。play_cards 的 cards 必须恰好 3 个唯一 ID；append_cards 为 1~3 个唯一新 ID。mainline_battle_recovery=true 时可省略 target_enemy 保留当前目标；否则当前 enemies 有多个 ID 时，play_cards 必须同时返回其中一个合法 target_enemy，至多一个 ID 时可省略。Allowed actions: play_cards、append_cards、wait_for_transition、pause_for_human。
LOCAL_FACTS 中的 locally_detected_disabled 只是本地视觉提示，不是硬性禁用结论；以截图判断卡片是否真的可点。
affinity 缺失、遮挡或箭头读不清时保持 unknown，不能直接当 neutral；同持有者的相性冲突按当前箭头复核。暗色卡面美术不单独证明宝具禁用，仍遵守 ready、sealed 与 allowed_nps 的硬限制。

只返回一个 JSON：
{"action":"play_cards","arguments":{"cards":["card1","card2","card3"],"target_enemy":"已有 enemy id","observed_battle_stage":"2/3","observed_turn":4},"confidence":0.0,"reason":"引用目标和出牌顺序"}

最终排序以 np_effect_sequences 的完整条件和效果顺序复核；列表顺序不是已验证的执行时点，不明确时说明条件。全宝具连锁不吃 Buster 首卡伤害加成，不能据此把红宝具排第一。伤害后降防等效果能帮助后续攻击时，把它放早与给它更高 OC 的方案直接比较；reason 点出真正改变伤害/控制/回收的机制及取舍，不要只复述“连锁提高OC”。

输出前逐个核对未选的合法伤害宝具：应比较它与占用该卡槽的普通卡，而不是与已经选中的更强宝具比较。另一宝具更强不妨碍两者一起使用；不得仅凭跨从者倍率差、缺后续增益或普通卡有暴击就少放。没有证据证明替代普通卡的收益更高、有效伤害已足够或该宝具有具体代价时，将它纳入三张卡，并用普通卡补足剩余位置；超过三个合法宝具时才比较取舍。reason 简述真实的顺序收益和最近备选的代价，不编造确定击杀。
