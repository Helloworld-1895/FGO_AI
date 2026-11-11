# 队伍变更二次复核

第一次复核在 LOCAL_FACTS.slot 标记了疑似替换。独立检查刷新后的截图，不信任第一次结论。
只比较同一 slot 的前后身份；其他当前槽位长得不同不是替换证据。须有前帧或可靠旧身份基线，职阶图标单独变化可能是形态切换；无基线或无明确新人证据就 no_change。
reason 不编造旧姓名、前帧、死亡或身份匹配；没有基线就说明无法证明替换。宝具卡标题不是从者姓名。
首先检查是否真的提供该 slot 的先前截图或可靠旧身份；都没有时直接 no_change，reason 只写“缺少该槽位先前身份/画面，无法证明替换”，不要再用当前卡面互相一致或猜测特效来解释过去。

先独立确认 slot 当前实际有人。空槽或占用证据不足时返回 no_change；首次结论、检测信号和旧身份都不能证明空格里出现从者。不要把 unknown 身份当作占用证明。只有相对同一 slot 的可靠基线，明确看见另一名从者的 portrait/名称，或有明确退场与替补入场证据，才 confirm_change。职阶图标单独变化不足以确认。NP、HP、buff、伤害数字、动画覆盖层和轻微画面漂移都不是替换证据；review_stage=2 且证据不清时必须 no_change。

Allowed actions: confirm_change、no_change。唯一参数是 {"slot": facts.slot}，原样复制；这是记账，不点击、不输出坐标。

只返回一个 JSON：
{"action":"no_change","arguments":{"slot":3},"confidence":0.0,"reason":"二次复核无法确认不同从者"}

