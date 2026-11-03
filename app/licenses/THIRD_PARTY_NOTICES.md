# 第三方组件说明

发布包包含或调用的第三方组件按各自许可证使用。本清单用于指引来源，不会改变上游许可证的权利和义务。

| 组件 | 用途 | 许可证或来源 |
| --- | --- | --- |
| CPython | Windows 独立运行时 | PSF License |
| Nuitka | Python 编译与打包 | Apache-2.0 及随包声明 |
| OpenCV | 图像处理与模板匹配 | Apache-2.0 |
| NumPy | 数值数组 | BSD-3-Clause |
| PyYAML | 配置解析 | MIT |
| Pillow | 图像处理与界面资源 | HPND/MIT，随包声明 |
| RapidOCR / ONNX Runtime | OCR 与推理 | 各自许可证，随包声明 |
| PaddleOCR PP-OCRv4 检测/识别与方向分类 ONNX 模型 | 内置 CPU OCR | Apache-2.0；模型源自 PaddleOCR |
| Shapely / pyclipper | 几何处理 | 各自许可证 |
| HTTPX 及传递依赖 | 可选网络接口 | 各自许可证 |

完整声明位于发布包 app/licenses/ 和仓库 third_party_licenses/。CPU 包和 CUDA 包均内置上述 OCR ONNX 模型，但不包含 Torch、TorchVision、Triton、SAM runtime 或 SAM/YOLOX 等可选模型权重。CUDA 包额外附有 NVIDIA 运行库许可文本。

