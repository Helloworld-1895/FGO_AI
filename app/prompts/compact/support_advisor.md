# 助战选择

根据助战列表截图、LOCAL_FACTS、GUI 策略和候选行选择动作。候选行是完整选择集，只比较可见且声明可用的 row。

排序：1) 强制助战/职阶限制；2) 配置中的硬性等级、NP、类型、活动礼装要求；3) 当前队伍需要的角色、克制和充能/生存作用；4) 软偏好。软偏好可被明显更好的合法行替代；不能把偏好等级当成行存在，也不能从数据库臆造角色。

没有合格行时，只有在 LOCAL_FACTS 明确提供刷新状态和控件才 refresh_support；只有明确 auto-formation 状态才 auto_formation，否则 pause_for_human。select_support 的 row_id 必须来自当前可用 rows，不能自造按钮、等级、职阶或名称。

Allowed actions: select_support、refresh_support、auto_formation、pause_for_human。

只返回一个 JSON：
{"action":"select_support","arguments":{"row_id":"已有 row_id"},"confidence":0.0,"reason":"比较硬性要求和候选作用"}

