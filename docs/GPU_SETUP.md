# GPU 配置（高级、自行维护）

CPU 是 v1.0.1 公开包唯一默认且验证过的路径。GPU 需要用户自己准备 NVIDIA 驱动、CUDA 运行时、带 CUDA 的 OpenCV 和可选模型；公开 ZIP 不携带这些组件，也不会自动安装驱动。GPU 不是本版本的可用性承诺，启用后由用户自行承担驱动、模型、许可证和性能兼容风险。

## 1. 下载清单与目录

先准备以下项目，版本必须相互兼容：

1. NVIDIA 官方 Windows 驱动，并确认 nvidia-smi 能显示显卡。
2. Miniconda/Anaconda，用于创建独立 GPU 环境。
3. 与驱动匹配的 PyTorch CUDA wheel（从 PyTorch 安装选择器复制命令）。
4. 带 CUDA 编译的 OpenCV。PyPI 的 opencv-python 通常不带 CUDA，必须使用自己编译或可信的 CUDA 构建，不能与另一份 OpenCV 混装。
5. 可选 EfficientSAM3-LiteText runtime、checkpoint，或已有的 YOLOX ONNX 模型。模型按上游许可证下载，不要提交到 GitHub。

GPU 配置应在源码仓库目录中完成；v1.0.1 Windows ZIP 只负责 CPU 编译包。源码目录建议如下：

    FGO_Auto_Optimized_improved - Copy/
      models/
        efficientsam3/sam3_litetext/sam3_litetext-s0-16-fp16.pt
        yolox_s_buttons.onnx
      runtime/
        efficientsam3/
      profiles/user.yaml

## 2. 创建 Python 环境

    conda create -n fgo-gpu python=3.12 -y
    conda activate fgo-gpu
    python -m pip install --upgrade pip
    # 按 pytorch.org 选择器选择命令；下面仅为 CUDA 12.4 示例：
    python -m pip install torch torchvision --index-url https://download.pytorch.org/whl/cu124
    python -m pip install -r requirements.txt

不要再安装会覆盖 CUDA 构建的 opencv-python。安装 OpenCV 后，cv2.cuda.getCudaEnabledDeviceCount() 和 cv2.cuda.createTemplateMatching(cv2.CV_8U, cv2.TM_CCOEFF_NORMED) 两个接口必须存在。

## 3. 验证驱动、CUDA、OpenCV

    conda activate fgo-gpu
    nvidia-smi
    python -c "import sys,cv2,torch,numpy,yaml; print(sys.version); print('cv2',cv2.__version__); print('cuda devices',cv2.cuda.getCudaEnabledDeviceCount()); print('torch',torch.__version__,torch.version.cuda,torch.cuda.is_available()); print('opencv cuda', 'NVIDIA CUDA' in cv2.getBuildInformation()); cv2.cuda.createTemplateMatching(cv2.CV_8U, cv2.TM_CCOEFF_NORMED); print('CUDA_API_OK')"
    python scripts/probe_cv2_cuda_streams.py

必须同时满足：nvidia-smi 能看到显卡、OpenCV CUDA 设备数大于 0、CUDA 模板匹配接口可调用；只有使用 SAM3 时才额外要求 torch.cuda.is_available() 为 True。任一项失败都先使用 CPU。

## 4. 模板匹配配置

在源码目录复制 profiles/fgo_cn_1600x900.yaml 为 profiles/user.yaml，写入：

    behavior:
      matching_mode: gpu
      matching_cv2_cuda: true
      matching_gpu_cache_entries: 6
      matching_batch_cuda: false
      matching_cuda_batch_size: 256
      matching_batch_gpu_fraction: 0.4

cpu 是排障基线；gpu 使用 OpenCV CUDA；hybrid 按工作量把任务分给 CPU 线程池和 GPU 队列。先用 cpu 验证同一截图，再切到 gpu，最后才尝试 hybrid。

## 5. SAM3 语义按钮（可选）

需要非模板按钮时，安装上游 runtime 和 checkpoint，并保证路径与 profile 完全对应。源码仓库提供安装接口：

    conda activate fgo-gpu
    powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\setup_sam3.ps1 -CondaEnv fgo-gpu

安装脚本会安装依赖、下载并校验 checkpoint、准备 runtime，并检查 torch.cuda.is_available() 和 OpenCV CUDA。模型下载可能需要 Hugging Face 登录和额外许可；请阅读模型卡片和上游许可证。完成后应存在：

    models/efficientsam3/sam3_litetext/sam3_litetext-s0-16-fp16.pt
    runtime/efficientsam3/

在 profiles/user.yaml 对齐接口：

    model_advisor:
      visual_detector:
        enabled: true
        backend: sam3
        runtime: efficientsam3
        runtime_path: runtime/efficientsam3
        model_path: ../models/efficientsam3/sam3_litetext/sam3_litetext-s0-16-fp16.pt
        provider: gpu
        fallback_to_cpu: true
        precision: fp16

使用已有截图验收：

    python scripts/test_sam3_screenshot.py runs/<已有截图文件>.png --output runs/sam3-diagnostic.png

CPU 运行时把 provider 改为 cpu、precision 改为 fp32。YOLOX 兼容接口：把 backend 改为 yolox，填写 yolox_model_path，并自行保证 ONNX 模型输入输出符合项目检测器接口。模型文件不放入公开仓库。

## 6. 启动接口与回退

源码仓库的 GPU 启动脚本会严格检查指定 Conda 环境的 CUDA OpenCV，不通过就明确报错：

    powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1 -GpuCondaEnv fgo-gpu -CheckOnly
    powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\bootstrap.ps1 -GpuCondaEnv fgo-gpu

也可以双击源码目录的 启动控制面板-GPU.bat。公开 ZIP 中的 启动FGO_AI.bat 只启动 CPU 编译包，不读取外部 Conda 环境。GPU 出错时恢复：

    behavior:
      matching_mode: cpu
      matching_cv2_cuda: false
    model_advisor:
      visual_detector:
        enabled: false

## 7. 常见故障与验收

- 设备数为 0：检查驱动、CUDA DLL、OpenCV 是否实际带 CUDA，以及 PATH 是否混入另一份 cv2。
- 导入冲突：卸载当前环境中的 opencv-python，确保只加载一份 OpenCV。
- GPU 更慢：小模板会被上传/下载开销主导，比较同一批截图的 CPU/GPU 日志后再决定。
- 结果不一致：同一截图分别运行 CPU/GPU，命中位置和规则必须一致；否则回退 CPU。
- 显存不足：关闭 matching_batch_cuda，降低 matching_batch_gpu_fraction，仍失败就回退 CPU。

可发布前的最低验收是：环境检测通过、CPU/GPU 同图结果一致、连续运行稳定、GPU 失败可回退 CPU。不要提交 models/、runtime/、profiles/user.yaml、API key、截图或日志；这些文件可能包含受许可限制的模型或个人信息。
