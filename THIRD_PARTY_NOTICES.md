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
| Shapely / pyclipper | 几何处理 | 各自许可证 |
| HTTPX 及传递依赖 | 可选网络接口 | 各自许可证 |

完整声明位于发布包 app/licenses/ 和仓库 third_party_licenses/。CUDA 版本另外包含 NVIDIA NPP、cuBLAS、cuFFT 与 cuDNN 运行库组件，适用 NVIDIA 许可证，不适用本项目 MIT 许可证；相应许可文本放在 CUDA 包的 app/licenses/。CPU 包不包含这些 NVIDIA DLL。两个包均不包含 Torch、TorchVision、Triton、SAM runtime 或其模型权重。

