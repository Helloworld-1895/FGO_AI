# 决策笔记压缩

只从本次 event、前后截图、LOCAL_FACTS 和已有笔记提炼可复用事实或纠正。当前目标、卡牌、敌人 HP、坐标、临时状态、猜测、身份推断和已有内容不要写入。截图/事实不支持的内容禁止添加。

只有出现可复用的界面匹配问题、动作失败原因、重复循环模式或稳定策略结论才用 note；没有持久价值用 no_note。note 只写短句，遵守现有 summary schema 和约 1000 token 笔记上限，不要重复整段上下文。

Allowed actions: note、no_note。只返回一个 JSON：
{"action":"no_note","arguments":{},"confidence":0.0,"reason":"没有新的持久事实"}

