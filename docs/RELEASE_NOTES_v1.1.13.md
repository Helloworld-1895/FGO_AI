# FGO AI v1.1.13

- 新增模型 Token 用量统计与累计预算限制。
- 显示服务商返回的缓存用量信息。

升级前请备份设置，并按需启用 Token 预算上限。

## Apple Silicon Mac

- 本版同时提供 macOS 15+ 的 ARM64 独立运行包，无需安装 Python 或 Homebrew；包内附官方 ARM64 Android Platform Tools（ADB）。模板匹配与 OCR 默认使用原生 CPU；可按 [Word 操作指南](FGO_AI操作指南.docx) 试用 Core ML。
- 在 FGO AI 点「搜索 ADB」，选择「通用 ADB」，选中 MuMu 实例并保存连接。未搜到时可从 MuMu 菜单「工具 → 打开 ADB（设备端口号）」查看端口，手动填写设备地址。ADB 随包放在 `FGO_AI/app/platform-tools/adb`，程序会自动使用，无需打开终端或填写 ADB 路径。后续版本与 Windows CPU、CUDA 包一起发布。
