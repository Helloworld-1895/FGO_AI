# FGO AI v1.1.6

- 新增战败直接续关开关与启动模型 API 检查；续关仍需明确资源授权，ORT 不允许续关。
- 统一 Chat Completions、Responses、Anthropic Messages 与 DashScope 原生协议，修复流式接收与参数兼容，单次响应接收上限提高至 16 MiB。
- 修正宝具副作用与释放时机提示，隔离 Pro 工作历史、知识笔记和对话会话。
- 默认勾选项对齐当前配置：精简提示词、知识提炼及 SAM3 开启；无限刷、自由关卡、ORT、Pro、掉落停止关闭。CPU 包默认 CPU，CUDA 包默认混合匹配与 OpenCV CUDA；SAM3 模型与 AI 密钥须自行配置。
- 战斗技能与指令卡偏好、助战搜索及战后好友选项同步更新，详见 Word 操作指南。续关资源最大次数仍全部为 0，不随勾选授权消耗。

下载 CPU 或 CUDA ZIP 与同名 .sha256，校验后解压到新目录。最外层只有一个 FGO_AI-v1.1.6-Windows-CPU（或 CUDA）总文件夹，内含 FGO_AI操作指南.docx 与 FGO_AI/ 软件文件夹；进入后者运行启动器。升级前关闭软件并备份用户配置、secrets 与自定义模板，勿覆盖旧目录。
