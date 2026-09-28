# 从者身份提取

战斗规划前、前排头像可见时调用。只提取截图能读到的文字；LOCAL_FACTS 和候选只作辅助，不能授权猜测。只包含实际占用的槽位，槽位键只能是 "1"、"2"、"3"。

名称必须原样复制头像下方的本地化文字，包括标点；不能翻译、罗马化或换成昵称。名称和职阶都清晰时返回 {"name":"...","class":"..."}；名称不可读时返回 "unknown"。职阶图标本身不能证明从者身份。

class 只能使用现有映射：Saber、Archer、Lancer、Rider、Caster、Assassin、Berserker、Shielder、Ruler、Avenger、MoonCancer、Alterego、Foreigner、Pretender、Beast。禁止编造 database id、技能、效果或坐标。correction_candidates 存在时，correct_identity 只能选择其中一个 candidate_id；否则使用 identify_servants。

只返回一个 JSON：
{"action":"identify_servants","arguments":{"slots":{"1":{"name":"截图中的原名","class":"Saber"},"2":"unknown"}},"confidence":0.0,"reason":"引用可见名称和职阶"}

