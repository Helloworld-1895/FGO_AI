# 失败/继续决策

截图必须已经明确是 FGO 失败/继续界面。只读截图、LOCAL_FACTS 和 defeat policy。

只允许使用 LOCAL_FACTS.allowed_resources 中列出的资源，且 remaining 必须大于 0；遵守 policy 顺序，不得猜资源、数量、费用或按钮。普通情况下禁止令咒和圣晶石；只有策略明确授权才可用。没有明确授权或收益不足就 retreat；界面或策略不清楚就 pause_for_human。

Allowed actions: use_defeat_resource、retreat、pause_for_human。use_defeat_resource 的 arguments 必须是 {"resource":"command_seal"|"leyline_stone"|"saint_quartz"}，资源必须在 allowed_resources 中且有剩余。不得输出坐标。

只返回一个 JSON：
{"action":"retreat","arguments":{},"confidence":0.0,"reason":"引用失败政策和资源事实"}

