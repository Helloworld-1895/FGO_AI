# 从者身份提取

战斗规划前、前排头像可见时调用。只提取截图能读到的文字；LOCAL_FACTS 和候选只作辅助，不能授权猜测。只包含实际占用的槽位，槽位键只能是 "1"、"2"、"3"。先确认有人再读身份：空槽省略，占用证据不足也不创建键；unknown 仅用于确认有人但身份不明，不能填满预留位置。active_slots/configured_slots 可能误检或过时，不代替当前占用检查；被遮挡也不自动等于空槽。槽位编号保持原位置，例如只有第1、第3格有人就只返回 "1"、"3"。
先逐格检查底部固定 HUD 左/中/右的占用，分别对应 1/2/3；两骑可能是 1+2、1+3、2+3，单骑可能是 1、2、3。不能按人数或战场立绘、卡面顺序重编号；只有一骑不等于槽位1，缺左位的两骑是2、3，不是1、2。

名称必须原样复制头像下方的本地化文字，包括标点；不能翻译、罗马化或换成昵称。名称和职阶都清晰时返回 {"name":"...","class":"..."}；名称不可读时返回 "unknown"。职阶图标本身不能证明从者身份。
姓名可读但职阶不清时，该槽位直接返回姓名字符串；不要为凑齐对象猜职阶，也不要因此丢掉可读姓名。
姓名只读底部从者 HUD 的姓名行；职阶、技能名、宝具名、卡面标题都不是姓名。"他人格"是 Alterego，"狂战士"才是 Berserker，不把模糊职阶字样当成新姓名。指令卡页五张卡不是五个队伍槽位。附加 HUD 裁剪图若有，来自同一帧，只放大文字，不是新增队友或新时间点。证据不足用 unknown，不用相似发音补字。

class 只能使用现有映射：Saber、Archer、Lancer、Rider、Caster、Assassin、Berserker、Shielder、Ruler、Avenger、MoonCancer、Alterego、Foreigner、Pretender、Beast。禁止编造 database id、技能、效果或坐标。correction_candidates 存在时，correct_identity 只能选择其中一个 candidate_id；无候选有证据时 candidate_id 用 "unknown"，仍返回完整 correct_identity JSON，不能返回裸 unknown。否则使用 identify_servants。

只返回一个 JSON：
{"action":"identify_servants","arguments":{"slots":{"1":{"name":"截图中的原名","class":"Saber"}}},"confidence":0.8,"reason":"仅第1格有从者且身份可读，其余空槽省略"}

仅第1格确认有人但身份不可读时：
{"action":"identify_servants","arguments":{"slots":{"1":"unknown"}},"confidence":0.8,"reason":"仅第1格确认有人但名称不可读；其余槽位不补人"}

其他缺人布局示例（unknown 表示确认有人但身份不可读；不把示例占用当本帧事实）：
{"action":"identify_servants","arguments":{"slots":{"2":"unknown"}},"confidence":0.8,"reason":"仅中位有人，保留2"}
{"action":"identify_servants","arguments":{"slots":{"3":"unknown"}},"confidence":0.8,"reason":"仅右位有人，保留3"}
{"action":"identify_servants","arguments":{"slots":{"1":"unknown","2":"unknown"}},"confidence":0.8,"reason":"左中有人，保留1、2"}
{"action":"identify_servants","arguments":{"slots":{"1":"unknown","3":"unknown"}},"confidence":0.8,"reason":"中位空，保留1、3"}
{"action":"identify_servants","arguments":{"slots":{"2":"unknown","3":"unknown"}},"confidence":0.8,"reason":"左位空，保留2、3"}

