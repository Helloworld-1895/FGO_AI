# FGO AI

Windows x64 上运行的《命运-冠位指定》MuMu/ADB 屏幕自动化工具。

程序通过 ADB 获取模拟器画面，使用 OpenCV 模板匹配、OCR 和可选的模型服务识别界面，再按照本地规则执行受保护的点击与滑动操作。它不读取游戏进程内存、不注入游戏进程，也不修改游戏文件。

> 本项目是非官方工具，与游戏开发商、运营商、Bilibili、MuMu 或其他权利人没有隶属、赞助或认可关系。自动化操作可能违反游戏服务条款，使用前请自行评估风险。

## 功能

- ADB 截图、设备发现和模拟器连接
- 助战筛选、技能与宝具规则、目标选择和指令卡策略
- OpenCV 模板匹配与 OCR 识别
- 未知画面安全暂停，避免在无法确认状态时继续操作
- 可选的 OpenAI-compatible 接口或 Ollama 模型顾问
- CPU 默认运行；源码路径支持 OpenCV CUDA、混合匹配和可选语义检测

项目不包含游戏客户端、账号数据、云端 API key、第三方模型权重，也不提供绕过服务限制或修改游戏数据的功能。

## 下载

当前 Windows CPU 发布包：

- [FGO_AI-v1.0.1-Windows-CPU.zip](https://github.com/Helloworld-1895/FGO_AI/releases/tag/v1.0.1)
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

## 故障排查

- **窗口没有出现**：查看 `logs/setup.log` 和 `logs/control-panel-startup.log`。
- **无法连接设备**：确认模拟器已启动、ADB 已授权，且设备状态为 `device`。
- **识别不稳定**：确认分辨率为 `1600x900`，窗口没有缩放、裁剪或遮挡。
- **运行环境损坏**：关闭程序后删除本地 `.venv`，再次运行启动器。
- **出现未知画面**：保留安全暂停，检查 `runs` 中的截图并人工确认。

## 目录与隐私

运行时生成的 `logs/`、`runs/`、`state/` 和 `app/profiles/user.yaml` 可能包含截图、设备信息、文件路径或用户配置。分享日志前请先脱敏。隐私边界见 [PRIVACY.md](PRIVACY.md)，安全问题见 [SECURITY.md](SECURITY.md)。

## 许可证与归属

新增发布内容适用 [LICENSE.md](LICENSE.md)。第三方组件、素材和上游项目的许可证见 [NOTICE.md](NOTICE.md)、[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) 和 `third_party_licenses/`。

游戏名称、角色、界面、图像、文本、商标以及 MuMu 名称归各自权利人所有。本项目不主张拥有这些内容的权利。

## 反馈

提交 Issue 前请删除 API key、账号信息、设备序列号、绝对路径、完整日志和含个人信息的截图。请提供版本号、Windows 版本、模拟器版本、复现步骤以及 CPU/GPU 模式。
