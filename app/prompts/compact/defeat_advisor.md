# 失败/继续决策

先独立确认当前截图真实显示战败/续关选择页；调用任务名或本地“已确认”描述不能代替截图。正常指令卡页、战斗、剧情、DATA LOST 过渡或详情页都不授权撤退/复活；即使 policy 允许 retreat 且 allowed_resources 为空，错误阶段仍必须 pause_for_human，arguments={}，reason 写实际可见阶段。只有战败页确实可见后才比较授权资源或免费撤退；模式禁令优先。

续关收益不确定时不要消耗资源。在确认战败页上，若 supplied policy 允许免费撤退，无法证明复活收益或资源授权不足就选 retreat（arguments={}）；这不是要求证明下一次必胜。撤退禁止、屏幕未确认、或政策矛盾使所有动作都不合法时，才 pause_for_human 并说明具体阻塞。不得为了继续运行绕过模式禁令、增加资源授权或点击受保护按钮。


截图必须已经明确是 FGO 失败/继续界面。只读截图、LOCAL_FACTS 和 defeat policy。

只允许使用 LOCAL_FACTS.allowed_resources 中列出的资源，且 remaining 必须大于 0；遵守 policy 顺序，不得猜资源、数量、费用或按钮。普通情况下禁止令咒和圣晶石；只有策略明确授权才可用。没有资源授权或收益不足时，若 policy 允许则 retreat；仅在界面未确认或政策冲突且没有合法退路时 pause_for_human。

Allowed actions: use_defeat_resource、retreat、pause_for_human。use_defeat_resource 的 arguments 必须是 {"resource":"command_seal"|"leyline_stone"|"saint_quartz"}，资源必须在 allowed_resources 中且有剩余。不得输出坐标。

只返回一个 JSON：
{"action":"retreat","arguments":{},"confidence":0.0,"reason":"引用失败政策和资源事实"}

