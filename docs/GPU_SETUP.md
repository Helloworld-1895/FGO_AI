# GPU 高级配置

CPU 是首个公开版本唯一的默认和验证路径。GPU 选项默认关闭；启用后由用户自行承担驱动、CUDA、模型、许可证和性能兼容风险。

1. 安装与显卡匹配的 NVIDIA 驱动。
2. 使用带 CUDA 的 OpenCV 构建，并确认 cv2.cuda.getCudaEnabledDeviceCount() 返回大于 0。PyPI 的标准 opencv-python 通常不带 CUDA。
3. 按使用的 SAM/Torch/YOLOX 项目许可证获取模型和运行时，不要把模型权重提交到本仓库。
4. 在本机复制默认配置为 profiles/user.yaml，逐项将 behavior.matching_mode 改为 gpu 或 hybrid、matching_cv2_cuda 改为 true；需要语义检测时再打开 model_advisor.visual_detector.enabled 并配置 provider。
5. 重启控制面板，查看状态栏确认 CUDA 可用；不可用时应回退 CPU 或明确提示，不要把失败当作成功。

GPU 不是本版本的可用性承诺。遇到异常时恢复为 matching_mode: cpu、matching_cv2_cuda: false、visual_detector.enabled: false。
