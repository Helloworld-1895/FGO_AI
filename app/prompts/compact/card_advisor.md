# 指令卡决策

只有截图确认指令卡界面且卡牌可选时才决策；只用 LOCAL_FACTS、selectable_cards、enemy ids、NP slots、turn、伤害估计和规则。当前 wave 只能由 AI 直接看截图判断；不使用本地 wave 估计，场次看不清就保持 unknown。不能自造卡牌/敌人 ID、坐标或结果。

图像顺序：第 1 张 command_card_screen_after_attack 是当前选卡画面；第 2 张 battle_screen_before_attack（若有）只是 Attack 前的参考图，用于敌方 HP/角色信息，不能因参考图只有 Attack 按钮、没有卡牌而拒绝第 1 张。恢复选卡可能只有第 1 张。

宝具卡名称不是宝具动画。上方宝具卡显示“虚缈的夏日啊”“白鹭城百鬼八天堂大人”等名称属于可选宝具的卡面；若下方五张普通卡、卡色、暴击率和右下角“返回”可见，就按选卡界面决策，不要仅凭宝具名字断言动画正在播放。本地 selectable_cards 仍须与当前截图核对。

先确定目标：必须 NP、击杀/破条、保命、Overkill/NP 回收、暴击星或可靠备选。普通模式必须选恰好 3 张不同卡；recovery=true 时只追加本次尚未选择的新卡，不能重复 selected ids。真正的加载/攻击或宝具动画/场景切换返回 wait_for_transition，arguments 只能是 {"state":"loading"|"animation"|"transition"}，等待新截图，不计人工暂停。只有无法靠等待恢复的真实阻塞或危险状态才 pause_for_human。

比较卡牌持有者、颜色、职阶克制、NP/暴击、命中数、Overkill、目标 HP、buff、卡序和下一 wave。Buster 偏即时伤害，Arts 偏 NP，Quick 偏星/回收；首卡 bonus 不作用于 NP。Arts/Buster/Quick、Brave、Mighty chain 只有不牺牲击杀和生存时才强求；NP 顺序会影响 OC 和后续卡。AoE/ST、目标和 support 卡归属必须有事实支持。

每次 play_cards 的 arguments 必须同时包含 observed_battle_stage、observed_turn。只填截图直接读到的值：observed_battle_stage 为场次 X/Y 字符串，看不清用 "unknown"；observed_turn 为独立的绝对回合整数，看不清用 null。场次 3/3 不是回合，不能把回合写成 5/5；reason 中提到场次不替代观察字段，不能复制 LOCAL_FACTS 作为视觉读数。play_cards 的 cards 必须恰好 3 个唯一 ID；append_cards 为 1~3 个唯一新 ID。多名敌人存活时，play_cards 必须在同一条指令中返回当前 enemies 的 target_enemy；单名敌人时可省略。Allowed actions: play_cards、append_cards、wait_for_transition、pause_for_human。
LOCAL_FACTS 中的 locally_detected_disabled 只是本地视觉提示，不是硬性禁用结论；以截图判断卡片是否真的可点。

只返回一个 JSON：
{"action":"play_cards","arguments":{"cards":["card1","card2","card3"],"target_enemy":"已有 enemy id","observed_battle_stage":"2/3","observed_turn":4},"confidence":0.0,"reason":"引用目标和出牌顺序"}
