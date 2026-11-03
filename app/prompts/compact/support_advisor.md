# 助战选择

根据助战列表截图、LOCAL_FACTS、GUI 策略选择动作。visible_rows 提供当前可选 row_id 和部分 OCR；known_support_candidates、support_servant_knowledge 仅是参考，不是白名单。评估所有可见行，不限于已知候选；不能把参考从者的身份或 NP 等级移到另一行。

排序：1) 强制助战/职阶及关卡硬限制；2) 当前动态等级阶段和队伍需要的角色、克制、充能/生存作用；3) NP 等级、类型等软偏好。required_np5=false、required_aoe_np=false 表示不是硬过滤；NP 类型仅为弱偏好，不得据此拒绝或重扫。OCR 缺身份、NP 等级/颜色/目标字段表示未知，不是不合格；可从清晰截图补读，读不清就降低置信度。不能把御主等级当从者等级，也不能臆造身份或属性。

当前页无合适行时返回 continue_support_scan，arguments 必须为 {}，让本地流程继续扫描、翻页和等级递降。refresh_allowed=false 只禁止刷新，不表示搜索耗尽；参考候选未出现、OCR 不全或正常找人不应 pause_for_human。仅在确实阻塞或不安全且本地支持的搜索动作无法继续时请求人工。只有 LOCAL_FACTS 明确允许且有控件时才 refresh_support；只有明确 auto-formation 状态才 auto_formation。select_support 的 row_id 必须来自当前可用 visible_rows，不能自造 ID、按钮、坐标、等级、职阶或名称。

Allowed actions: select_support、continue_support_scan、refresh_support、auto_formation、pause_for_human。

只返回一个 JSON：
{"action":"select_support","arguments":{"row_id":"已有 row_id"},"confidence":0.0,"reason":"比较硬性要求和候选作用"}

继续搜索示例：
{"action":"continue_support_scan","arguments":{},"confidence":0.9,"reason":"当前页无合适行，继续本地列表扫描"}

