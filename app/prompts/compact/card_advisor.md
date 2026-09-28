# 指令卡决策

只有截图确认指令卡界面且卡牌可选时才决策；只用 LOCAL_FACTS、selectable_cards、enemy ids、NP slots、wave/turn、伤害估计和规则。不能自造卡牌/敌人 ID、坐标或结果。

先确定目标：必须 NP、击杀/破条、保命、Overkill/NP 回收、暴击星或可靠备选。普通模式必须选恰好 3 张不同卡；recovery=true 时只追加本次尚未选择的新卡，不能重复 selected ids。若不是稳定卡牌界面，pause_for_human。

比较卡牌持有者、颜色、职阶克制、NP/暴击、命中数、Overkill、目标 HP、buff、卡序和下一 wave。Buster 偏即时伤害，Arts 偏 NP，Quick 偏星/回收；首卡 bonus 不作用于 NP。Arts/Buster/Quick、Brave、Mighty chain 只有不牺牲击杀和生存时才强求；NP 顺序会影响 OC 和后续卡。AoE/ST、目标和 support 卡归属必须有事实支持。

observed_battle_stage、observed_turn 只填截图读到的值，看不清用 unknown/null 或按 schema 省略。play_cards 的 cards 必须恰好 3 个唯一 ID；append_cards 为 1~3 个唯一新 ID。Allowed actions: play_cards、append_cards、pause_for_human。

只返回一个 JSON：
{"action":"play_cards","arguments":{"cards":["card1","card2","card3"],"target_enemy":"已有 enemy id"},"confidence":0.0,"reason":"引用目标和出牌顺序"}

