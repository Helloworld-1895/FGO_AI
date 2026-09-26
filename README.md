# FGO AI

Windows x64 的《命运-冠位指定》MuMu/ADB 屏幕自动化工具。当前 GitHub `v1.0.1` Release 是本次重新编译的修正版，旧的恶性 bug 资产会被原地替换。

工具通过 ADB 获取画面，结合 OpenCV 模板匹配、OCR、显式规则和可选的 AI 辅助决策，为助战、技能、宝具、目标和指令卡提供建议，并在本地安全检查后执行。它不读取游戏内存、不注入游戏进程、不修改游戏文件。

本项目是非官方工具，与游戏开发商、运营商、Bilibili、MuMu 或其他权利人没有隶属、赞助或认可关系。自动化操作可能违反游戏服务条款并导致账号处罚，请自行评估风险。

## 下载与验证

- Release：`FGO_AI-v1.0.1-Windows-CPU.zip`
- 校验：同一 Release 的 `SHA256SUMS.txt` 和仓库根目录 `release-manifest.json`
- 运行包：Windows 10/11 x64，完整解压后双击 `启动FGO_AI.bat`

版本号刻意保持 `1.0.1`，以便启动器和固定下载地址继续指向修正版。请不要缓存或转发旧 ZIP；下载后以 SHA-256 校验值为准。

## 快速开始

1. 安装并启动 MuMu Windows 版，在模拟器内打开游戏。
2. 下载并完整解压 `FGO_AI-v1.0.1-Windows-CPU.zip` 到可写目录。
3. 双击 `启动FGO_AI.bat`。公开包自带 CPython 和 CPU 依赖，不需要预装 Python，也不需要联网才能正常启动。
4. 在控制面板连接 MuMu，确认游戏画面为 `1600x900` 后再开启自动推进。建议先使用测试账号和低风险关卡。
5. `logs`、`runs`、`state` 和 `profiles/user.yaml` 只保存在本机，切勿上传到 Issue。

如果 `app` 缺失或校验失败，启动器会从 `release-manifest.json` 指定的 GitHub 地址下载同一版本资产，先验证 SHA-256，再以临时目录原子替换；失败时不会破坏已有安装。

## 默认行为与限制

- 模板匹配默认使用 CPU；CUDA、OpenCV GPU/混合模式和语义检测默认关闭。
- AI 服务需要用户自行配置 OpenAI-compatible 接口或 Ollama；项目不附带密钥、付费额度、云模型或模型权重。
- 不包含游戏客户端、账号数据和任何绕过服务限制的功能。
- 程序没有遥测；启用云模型后，截图和提示词会按用户选择的服务商接口发送。
- GPU 是高级自配路径，不属于本 CPU 发布包的可用性承诺。完整步骤见 [docs/GPU_SETUP.md](docs/GPU_SETUP.md)。

## 配置

运行包内默认配置为 `app/profiles/fgo_cn_1600x900.yaml`，首次启动会生成本地 `app/profiles/user.yaml`。只修改 `user.yaml`，不要把它提交或发送给他人。

通用 ADB 设备示例：

```yaml
 device:
   backend: adb
   adb_path: C:/Android/platform-tools/adb.exe
   serial: ""
```

`serial` 留空会自动发现在线设备；填写后固定使用该设备。连接问题可在模拟器的 ADB 目录执行 `adb devices -l`。

模型配置请复制本地示例并把密钥保存在被 Git 忽略的文件中。不要在日志、截图或 Issue 中暴露 API key、账号标识、设备序列号或绝对路径。

## 故障排查

- 启动窗口未出现：查看 `logs/setup.log`、`logs/control-panel-startup.log`；
- 连接失败：确认模拟器启动、ADB 已授权且设备状态为 `device`；
- 识别不稳：确认 `1600x900`、100% 缩放、无裁剪和无遮挡；
- 环境损坏：关闭工具，删除本地 `.venv` 后重新双击启动器；
- 未知画面：保留安全暂停，检查 `runs` 中截图后人工处理，不要关闭保护逻辑。

## 许可证、版权与隐私

本仓库按 [LICENSE.md](LICENSE.md) 发布新增代码和文档；第三方组件及素材按各自许可证使用，详见 [NOTICE.md](NOTICE.md)、[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) 和 `third_party_licenses/`。游戏客户端、游戏图片、模型权重、账号数据、密钥和云服务额度不属于本项目授权范围，不应提交或打包分发。使用者必须自行确认游戏服务条款、模拟器许可、模型许可证、API 条款和当地法律。

## 反馈

提交 Issue 前请删除账号名、设备序列号、API key、绝对路径、完整日志和含个人信息的截图。请说明 `v1.0.1`、Windows 版本、模拟器版本、CPU/GPU 模式和可重复的最小步骤。本项目不提供绕过服务条款、账号处罚、付费操作或游戏数据修改的支持。
