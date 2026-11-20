# FGO AI v1.1.13

- 新增模型 Token 用量统计与累计预算限制。
- 显示服务商返回的缓存用量信息。

升级前请备份设置，并按需启用 Token 预算上限。

## Apple Silicon Mac

- 本版同时提供 macOS 15+ 的 ARM64 独立运行包，无需安装 Python。模板匹配与 OCR 默认使用原生 CPU；可按 [Word 操作指南](FGO_AI操作指南.docx) 试用 Core ML。
- Mac 通过通用 ADB 连接 MuMu，端口以模拟器菜单「工具 → 打开 ADB」显示的值为准。后续版本与 Windows CPU、CUDA 包一起发布。
