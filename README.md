# FGO AI

Windows x64 的《命运-冠位指定》MuMu/ADB 屏幕自动化工具。工具结合 ADB 截图、OpenCV 模板匹配、显式规则和 **AI 辅助决策**，根据当前画面与队伍状态为助战、技能、宝具、目标和指令卡提供建议，并在本地安全检查后执行。它不读取游戏内存、不注入游戏进程、不修改游戏文件。

首个公开版本提供 **CPU 优先的编译运行包**，用于个人研究、可访问性和重复性操作实验。AI 服务需要用户自行配置；项目不附带密钥、付费额度或云模型。

> 本项目是非官方工具，与游戏开发商、运营商、Bilibili、MuMu 或任何相关权利人没有隶属、赞助或认可关系。自动化操作可能违反游戏服务条款并导致账号处罚；请自行承担使用风险。

如果这个项目对你有帮助，求一个右上角的 Star，感谢支持。

## 公开范围

本仓库发布的是可直接运行的 Windows 二进制版本，不包含完整项目源码。程序以 Nuitka Windows standalone 形式打包；第三方组件仍按各自许可证使用，见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

## 快速开始

1. Windows 10/11 64 位，安装并启动 MuMu Windows 版，在模拟器内打开游戏。
2. 从 GitHub Releases 下载 `FGO_AI-vX.Y.Z-Windows-CPU.zip`，完整解压到可写目录。
3. 双击 `启动FGO_AI.bat`。发布包已携带自己的 CPython 运行时和 CPU 依赖，不需要安装 Python。
4. 首次打开控制面板后连接 MuMu，再按需开启自动推进。推荐先用测试账号和低风险关卡验证。
5. 关闭工具后，运行目录中的 `logs`、`runs`、`state` 只保存在本机，不要上传到 Issue。

Release 压缩包包含完整的 CPU `app` 运行目录，解压后的正常启动不需要联网。通过 Git 克隆仓库时，如果 `app` 缺失或损坏，启动器会下载对应 Release 资产，先校验 SHA-256 再修复；下载失败不会替换现有文件。

## 默认行为

- 模板匹配默认使用 CPU。
- CUDA、OpenCV GPU/混合模式、SAM/YOLOX 语义检测默认关闭。
- GUI 中 GPU 选项默认不勾选。GPU 是高级自配功能，见 [docs/GPU_SETUP.md](docs/GPU_SETUP.md)。
- 模型顾问和联网服务默认不携带密钥。需要使用时只能在本地被忽略的配置中填写。
- AI 决策需要自行配置 OpenAI-compatible 云端接口，或本地部署 Ollama；便宜模型和价格会变化，请自行比较服务商。
- 控制面板会累计显示服务商返回的输入、缓存输入和输出 token；费用取决于模型单价、图片计费方式、上下文长度和调用频率。
- 程序没有遥测，也不会主动上传截图或运行日志。

## 运行要求

- Windows 10/11 x64，Intel/AMD CPU；
- MuMu Windows 版或兼容的 ADB 设备；
- 游戏画面建议为 `1600 x 900`；
- 运行包必须完整解压，不能直接在 ZIP 内运行。

## 配置和故障排查

默认配置位于 `profiles/fgo_cn_1600x900.yaml`，首次运行会创建本地 `profiles/user.yaml`。只修改 `user.yaml`，不要把它提交或发送给他人。

AI 配置和 token 估算见 [docs/AI_SETUP.md](docs/AI_SETUP.md)。

如果窗口没有打开，查看本机 `logs/setup.log` 和 `logs/control-panel-startup.log`。如果识别不稳定，确认模拟器分辨率、缩放比例、前台窗口和 ADB 授权状态。未知画面应暂停并人工确认，不要为了继续运行而关闭安全检查。

## 许可证和来源

Helloworld-1895 拥有的新增发布组织、文档和专有编译部分按 [LICENSE.md](LICENSE.md) 授权。项目基线借鉴自 [`zelovv/FGO-MuMu-Auto`](https://github.com/zelovv/FGO-MuMu-Auto)，桌面宠物素材来自 [`timerring/codex-pet-naiwa`](https://github.com/timerring/codex-pet-naiwa)，均保留原许可证和归属。完整清单见 [NOTICE.md](NOTICE.md) 和 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

## 问题反馈

提交 Issue 前请删除账号名、设备序列号、绝对路径、API key、截图中的个人信息和完整日志。请说明版本、Windows 版本、CPU、模拟器版本、是否 CPU 默认模式，以及可重复的最小步骤。

本项目不提供绕过服务条款、账号处罚、付费操作或游戏数据修改的支持。
