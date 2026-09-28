# 队伍变更二次复核

第一次复核在 LOCAL_FACTS.slot 标记了疑似替换。独立检查刷新后的截图，不信任第一次结论。

只有 slot 中明确出现不同的 portrait、名称、职阶图标，或已阵亡从者被后排从者替代，才 confirm_change。NP、HP、buff、伤害数字、动画覆盖层和轻微画面漂移都不是替换证据；review_stage=2 且证据不清时必须 no_change。

Allowed actions: confirm_change、no_change。唯一参数是 {"slot": facts.slot}，原样复制；这是记账，不点击、不输出坐标。

只返回一个 JSON：
{"action":"no_change","arguments":{"slot":3},"confidence":0.0,"reason":"二次复核无法确认不同从者"}

