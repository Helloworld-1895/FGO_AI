# FGO AI

Windows x64 上运行的《命运-冠位指定》MuMu/ADB 屏幕自动化工具。

当前版本：**1.1.4**。增加 ORT 模式、更新 UI。更新内容见 [v1.1.4 发布说明](docs/RELEASE_NOTES_v1.1.4.md)。

程序通过 ADB 获取模拟器画面，使用 OpenCV 模板匹配、OCR 和可选的模型服务识别界面，再按照本地规则执行受保护的点击与滑动操作。它不读取游戏进程内存、不注入游戏进程，也不修改游戏文件。

> 本项目是非官方工具，与游戏开发商、运营商、Bilibili、MuMu 或其他权利人没有隶属、赞助或认可关系。自动化操作可能违反游戏服务条款，使用前请自行评估风险。

## 测试体验与人工看护

**本项目仅供测试体验与技术交流，请勿长时间无人值守或启动后完全放任不管。** 画面识别、自动决策和恢复流程可能出错，安全守卫也不能保证覆盖所有情况。误操作、重复挑战或异常循环可能消耗体力、苹果等游戏道具、API 付费额度、网络流量和电力，并造成进度、账号或经济损失。

- 首次使用、更新版本、切换模式或修改配置后，先在低风险场景短时测试，人工确认进本、战斗与结算流程。
- 启动前核对队伍、目标关卡、体力补充、苹果额度和模型设置；不需要的资源消耗选项保持关闭，云模型费用同时在服务商侧设置预算并查看账单。
- 运行期间持续留意画面、日志和资源消耗；出现识别错误、反复点击、重复进本或长时间无进展时，立即停止自动化并人工检查。离开电脑或无法继续看护时，请先停止任务。

本工具不承诺稳定通关、零误操作、零资源消耗或零损失。请在了解游戏规则及上述风险后，自行决定是否测试使用。

## 功能

- ADB 截图、设备发现和模拟器连接
- 自由关卡首次清除：按起点章节探索地图、识别未清除条目，战斗结算后继续扫描
- 助战筛选、技能与宝具规则、目标选择和指令卡策略
- OpenCV 模板匹配与 OCR 识别
- 未知画面安全暂停，避免在无法确认状态时继续操作
- 可选的 OpenAI-compatible 接口或 Ollama 模型顾问
- CPU 默认运行；CUDA 包支持 OpenCV CUDA/混合匹配，源码另有可选语义检测接口

项目不包含游戏客户端、账号数据、云端 API key 或可选视觉模型权重。发布包内含 OCR 运行必需的三份 PaddleOCR ONNX 模型；其来源和许可见 [第三方组件说明](THIRD_PARTY_NOTICES.md)。

## 操作指南

完整的安装、设备连接、界面说明、四种模式、任务与补体力、战斗/助战策略、AI 配置、日志排障与版本更新，见 [FGO AI 操作指南（Word）](docs/FGO_AI操作指南.docx)。

该文档是公开包的一部分。功能、界面、默认值、配置字段或模式行为变化时，必须在同一改动中同步修订；每次更新 `FGO_AI_Public`、重新打包、提交或上传 GitHub 都必须携带该文档。

## 下载

当前 Windows 发布包（按硬件选择其一）：

- [FGO_AI-v1.1.4-Windows-CPU.zip](https://github.com/Helloworld-1895/FGO_AI/releases/tag/v1.1.4)
- [FGO_AI-v1.1.4-Windows-CUDA.zip](https://github.com/Helloworld-1895/FGO_AI/releases/tag/v1.1.4)：内置 CUDA OpenCV 和模板匹配所需运行库，体积较大，需要兼容的 NVIDIA 显卡与驱动
- 同一 Release 中的 SHA-256 校验文件
- 仓库中的 [release-manifest.json](release-manifest.json)

下载后请完整解压到可写目录，再运行 `启动FGO_AI.bat`。不要直接在 ZIP 内运行，也不要使用未通过 SHA-256 校验的旧副本。

## 快速开始

1. 安装并启动 MuMu Windows 版，在模拟器中打开游戏。
2. 将发布包完整解压到普通目录，例如 `D:\FGO_AI`。
3. 双击 `启动FGO_AI.bat`。
4. 在控制面板中连接 MuMu，确认游戏画面为 `1600x900`。
5. 先使用观察或低风险流程确认识别结果，再开启自动推进。

CPU 发布包自带独立运行时和 CPU 依赖，正常启动不需要预装 Python。首次运行会在本地生成用户配置和运行日志；这些文件不应上传到 Issue 或公开仓库。

CUDA 包也不需要安装 Python 或 Conda；随包提供模板匹配需要的 CUDA DLL。两个包首次启动均默认使用 CPU，CUDA 包用户可在控制面板切换“GPU”或“混合”匹配并保存，重启自动化后生效。请通过 `启动FGO_AI.bat --self-test-cuda` 验证 GPU 实际匹配能力；详见 [CUDA 运行要求与自检](docs/GPU_SETUP.md)。请将两个包分别解压，不要互相覆盖。

## 运行要求

- Windows 10/11 x64
- MuMu Windows 版或兼容的 ADB 设备
- 推荐游戏画面分辨率：`1600x900`
- 模拟器窗口保持 100% 缩放，不裁剪、不遮挡

## 配置

默认配置位于 `app/profiles/fgo_cn_1600x900.yaml`。首次启动后，在同一目录编辑生成的 `user.yaml`，不要修改默认模板。

ADB 配置示例：

```yaml
device:
  backend: adb
  adb_path: C:/Android/platform-tools/adb.exe
  serial: ""
```

`serial` 留空时会自动使用在线设备；需要固定设备时填写 `adb devices -l` 显示的序列号。

模型顾问配置见 [docs/AI_SETUP.md](docs/AI_SETUP.md)。GPU 和本地模型运行时见 [docs/GPU_SETUP.md](docs/GPU_SETUP.md)。

## 自由关卡清除

1. 在任务设置中勾选“自由关卡开关”，选择“起点”章节。
2. 按需配置“大模型辅助”、队伍、战斗策略和体力补充。
3. 点击 **“保存任务与自由关卡设置”**，再启动或重启自动化。只勾选开关不会保存运行配置。
4. 从游戏主界面、主线记录或目标章节地图开始，观察日志中的 explorer 阶段，确认已进入自由关卡探索。

程序识别可挑战的未清除关卡，处理详情列表与地图扫描，在战斗和结算后返回探索；已完成、未解锁和非目标条目会跳过。自由关卡探索开启时优先于无限刷，主线推进保持独立。它不能代替尚未通关的主线解锁章节，也不保证所有活动或特殊战斗都能自动完成。

操作步骤、配置示例、识别边界与故障排查见 [自由关卡清除说明](docs/FREE_QUEST.md)。

## 故障排查

- **窗口没有出现**：查看 `logs/setup.log` 和 `logs/control-panel-startup.log`。
- **无法连接设备**：确认模拟器已启动、ADB 已授权，且设备状态为 `device`。
- **识别不稳定**：确认分辨率为 `1600x900`，窗口没有缩放、裁剪或遮挡。
- **自由关卡开关没有生效**：先点“保存任务与自由关卡设置”，确认 `app/profiles/user.yaml` 的 `free_quest.enabled` 为 `true`，再重启自动化。启动日志“已开启自动推进主线”是通用文案，不能据此判断模式。
- **运行环境损坏**：关闭程序，将同版本完整 ZIP 重新解压到新目录；或者运行仓库启动器，按 `release-manifest.json` 校验并修复 `app`。编译包不使用本地 `.venv`。
- **修复后的本地设置**：启动器会保留用户配置和 `secrets`，并留下 `.app-backup-*` 旧目录供恢复自定义模板等数据。确认新包正常、所需文件已迁移后再手动清理备份；不要上传备份。
- **出现未知画面**：保留安全暂停，检查 `runs` 中的截图并人工确认。

## 目录与隐私

运行时生成的 `logs/`、`runs/`、`state/` 和 `app/profiles/user.yaml` 可能包含截图、设备信息、文件路径或用户配置。分享日志前请先脱敏。隐私边界见 [PRIVACY.md](PRIVACY.md)，安全问题见 [SECURITY.md](SECURITY.md)。

## 许可证与归属

本项目原创代码和文档按 [MIT License](LICENSE.md) 发布，大家可以自由使用、修改和再发布。第三方组件、素材和上游项目不自动适用本项目许可证，具体来源和许可证见 [NOTICE.md](NOTICE.md)、[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) 和 `third_party_licenses/`。

游戏名称、角色、界面、图像、文本、商标以及 MuMu 名称归各自权利人所有。本项目不主张拥有这些内容的权利。

## 参考项目与致谢

- 项目早期设计和部分代码基线参考了 [zelovv/FGO-MuMu-Auto](https://github.com/zelovv/FGO-MuMu-Auto)，感谢原作者及贡献者。
- 桌面宠物图像素材来自 [timerring/codex-pet-naiwa](https://github.com/timerring/codex-pet-naiwa)，感谢原作者及贡献者。
- 其他依赖和素材的来源、许可证及随包声明见 [NOTICE.md](NOTICE.md) 和 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

如果发现来源、许可证或归属信息需要更正，请通过 [GitHub Issues](https://github.com/Helloworld-1895/FGO_AI/issues) 提供具体文件路径和原始来源链接，维护者会核查后更新说明。

## 反馈

提交 Issue 前请删除 API key、账号信息、设备序列号、绝对路径、完整日志和含个人信息的截图。请提供版本号、Windows 版本、模拟器版本、复现步骤以及 CPU/GPU 模式。
