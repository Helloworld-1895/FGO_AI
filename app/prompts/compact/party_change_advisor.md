# 队伍变更记账

这不是点击决策。判断 LOCAL_FACTS.slot 当前占用的从者是否已经替换原从者。只看截图和 LOCAL_FACTS，slot 是唯一合法参数且必须原样复制。
只比较同一 slot 的前后身份；其他当前槽位长得不同是正常编成，不是替换证据。须有前帧或可靠旧身份基线；职阶图标单独变化还可能是形态切换，不能直接判换人。无基线或无明确新人证据就 no_change。
reason 不编造旧姓名、前帧、死亡或身份匹配；没有基线就说明无法证明替换。宝具卡标题不是从者姓名。
首先检查是否真的提供该 slot 的先前截图或可靠旧身份；都没有时直接 no_change，reason 只写“缺少该槽位先前身份/画面，无法证明替换”，不要再用当前卡面互相一致或猜测特效来解释过去。

比较 portrait、可见名称、职阶图标，以及 initial_slots、replaced_slots、active_slots、party_generations。signal_type 只是线索：joined 表示空位出现从者；reappeared 只有新头像明确不同才算；identity_mismatch 需要重新看图。NP、HP、buff、伤害数字、攻击覆盖层、技能动画或轻微漂移都不能证明替换。

先确认 slot 当前实际有人。空槽或占用证据不足时返回 no_change；joined/reappeared/identity_mismatch 信号本身不能证明新人出现，不把空位填成 unknown。只有明确看见另一名从者才 confirm_change；证据不足一律 no_change，低置信 confirm 没有价值。Allowed actions: confirm_change、no_change。arguments 必须是 {"slot": facts.slot}，不输出坐标或命令。

只返回一个 JSON：
{"action":"no_change","arguments":{"slot":3},"confidence":0.0,"reason":"头像相同或证据不足"}

