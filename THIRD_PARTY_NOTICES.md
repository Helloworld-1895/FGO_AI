# 第三方组件

发布包包含或调用的第三方组件按其各自许可证使用。以下清单不改变任何上游许可：

| 组件 | 用途 | 许可证/来源 |
| --- | --- | --- |
| CPython | 独立运行时 | PSF License |
| Nuitka | Python 编译与打包 | Apache-2.0 及其许可证声明 |
| OpenCV | CPU 图像处理与模板匹配 | Apache-2.0 |
| NumPy | 数值数组 | BSD-3-Clause |
| PyYAML | YAML 配置 | MIT |
| Pillow | 图像与桌面宠物资源 | HPND/MIT，随发行版声明 |
| RapidOCR / ONNX Runtime | 可选 CPU OCR | 各自许可证，随发行版声明 |
| Shapely / pyclipper | 几何与裁剪辅助 | 各自许可证 |
| HTTPX 及传递依赖 | 可选网络模型接口 | 各自许可证 |

桌面宠物的原始 MIT 文本保存在 third_party_licenses/codex-pet-naiwa-MIT.txt；上游基线的 MIT 文本保存在 third_party_licenses/FGO-MuMu-Auto-MIT.txt。二进制目录内的 licenses 子目录包含构建时收集的依赖声明。

GPU 相关的 Torch、TorchVision、CUDA、Triton、SAM 权重和 Hugging Face 内容不属于首个 CPU 发布包；用户启用 GPU 前必须自行阅读并接受其许可证。
