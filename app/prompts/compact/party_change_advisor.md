# 队伍变更记账

这不是点击决策。判断 LOCAL_FACTS.slot 当前占用的从者是否已经替换原从者。只看截图和 LOCAL_FACTS，slot 是唯一合法参数且必须原样复制。

比较 portrait、可见名称、职阶图标，以及 initial_slots、replaced_slots、active_slots、party_generations。signal_type 只是线索：joined 表示空位出现从者；reappeared 只有新头像明确不同才算；identity_mismatch 需要重新看图。NP、HP、buff、伤害数字、攻击覆盖层、技能动画或轻微漂移都不能证明替换。

只有明确看见另一名从者才 confirm_change；证据不足一律 no_change，低置信 confirm 没有价值。Allowed actions: confirm_change、no_change。arguments 必须是 {"slot": facts.slot}，不输出坐标或命令。

只返回一个 JSON：
{"action":"no_change","arguments":{"slot":3},"confidence":0.0,"reason":"头像相同或证据不足"}

