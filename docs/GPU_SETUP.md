# GPU 配置（高级、自行维护）

`FGO_AI-v1.1.0-Windows-CPU.zip` 使用 CPU OpenCV。即使电脑装有 NVIDIA 显卡、驱动和 CUDA Toolkit，这个 CPU 编译包也不会自动获得 CUDA 模板匹配能力；在 GUI 选择 GPU 时会回退 CPU。

v1.1.0 同时提供 **`FGO_AI-v1.1.0-Windows-CUDA.zip`**，使用带 CUDA 的 OpenCV，随包提供模板匹配所需的 CUDA/cuDNN DLL。用户不需要安装 Python、Conda 或 CUDA Toolkit，仍需兼容的 NVIDIA GPU 和驱动。不能仅凭“有 NVIDIA 显卡”保证所有机器可用。

本页先解释编译包边界，再给出源码 GPU 环境的高级配置。CPU ZIP 不读取外部 Conda 环境，不会自动安装驱动。

## v1.1.0 CUDA 包使用方法

1. 下载 CUDA ZIP 和同名 `.sha256`，校验后解压到独立目录，勿覆盖 CPU 包或旧版目录。
2. 使用 NVIDIA 官方驱动，建议 Windows 驱动版本不低于 `570.65`，更新后再自检。此包 OpenCV 4.11 构建信息为 CUDA 12.8，携带的是已经实际匹配验证的 CUDA 12.6 系列数学运行库；不需要用户另装 Toolkit。低于建议版本的兼容模式不作为本发布包承诺。
3. 在解压目录打开命令提示符，运行 `启动FGO_AI.bat --self-test-cuda`。成功必须同时出现 `SELF_TEST_OK` 和 `CUDA_SELF_TEST_OK`，退出代码为 0。该测试实际执行 GPU 模板匹配，并将结果与 CPU 对比，然后验证 CPU OCR 与自由关卡模板。
4. 双击启动器打开控制面板，在匹配设置选择“GPU”或“混合”，确认“OpenCV CUDA”启用，保存后重启自动化。两个包的初始配置都为 CPU，避免首次启动直接改变匹配策略。
5. 查看日志中的“OpenCV CUDA 匹配已生效”；仅看到 GPU 选项不代表已成功启用。失败时选回 CPU；如 `cv2` 导入就失败，请改用独立 CPU 包。

当前 CUDA OpenCV 构建覆盖 SM 50/52/60/61/70/75/80/86/89/90，并带 compute_90 PTX。这不是逐型号兼容承诺；新旧显卡均应以自检为准。已在 RTX 4060 Laptop（SM 8.9）上验证；不代表所有 NVIDIA 显卡或驱动组合均经过实机测试。

此包只为 OpenCV 模板匹配提供依赖，不附带 Torch、SAM、CUDA OCR 或完整 cuDNN 推理组件；不要将其当成通用 OpenCV DNN/GPU 开发环境。所含 NVIDIA 组件遵循 NVIDIA 许可，见随包 `app/licenses/`。

## CUDA 编译包需要满足什么

1. **真实 CUDA OpenCV**：标准 `opencv-python` wheel 是 CPU 构建；Nuitka 编译 Python 代码不会替它增加 CUDA。需要实际可调用 `cv2.cuda.createTemplateMatching` 的构建。
2. **依赖完整**：按照二进制依赖收集所需的 OpenCV、CUDA、cuDNN 等可再分发 DLL，并遵守对应许可证；不得打包用户的显卡驱动。仅复制本机 `cv2.pyd` 不足以证明可以在其他电脑启动。
3. **驱动和显卡兼容**：驱动必须满足所用运行库要求，OpenCV 编译目标必须覆盖对方 GPU 的计算能力。旧显卡可能不受所选 CUDA 版本支持，新显卡也可能需要更新构建。
4. **独立验证**：在清理 PATH、移除本机 CUDA/Conda 搜索路径的独立环境中验证加载、GPU 实际匹配和 CPU/GPU 同图结果；还要验证无 NVIDIA GPU 的环境及失败回退。
5. **默认策略**：可以让 CUDA 包在兼容环境中使用 GPU/混合匹配，但保留单独 CPU 包作为兼容选择。CUDA DLL 缺失导致 `import cv2` 失败时，运行中的 CPU 回退逻辑还没机会执行，因此不能把回退当作打包依赖的替代品。

CUDA 模板匹配加速的是本地图像匹配，**不会让云端模型调用变快，也不会自动把 OCR 或模拟器渲染改为 GPU**。小模板或大量小任务可能受传输和调度开销影响，不保证比 CPU 更快。

参考资料：[OpenCV CUDA](https://docs.opencv.org/4.x/d2/dbc/cuda_intro.html)、[opencv-python 构建说明](https://pypi.org/project/opencv-python/)、[NVIDIA CUDA 兼容性](https://docs.nvidia.com/deploy/cuda-compatibility/)、[CUDA 许可协议](https://docs.nvidia.com/cuda/eula/index.html)。

## 1. 下载清单与目录

先准备以下项目，版本必须相互兼容：

1. NVIDIA 官方 Windows 驱动，并确认 nvidia-smi 能显示显卡。
2. Miniconda/Anaconda，用于创建独立 GPU 环境。
3. 与驱动匹配的 PyTorch CUDA wheel（从 PyTorch 安装选择器复制命令）。
4. 带 CUDA 编译的 OpenCV。PyPI 的 opencv-python 通常不带 CUDA，必须使用自己编译或可信的 CUDA 构建，不能与另一份 OpenCV 混装。
5. 可选 EfficientSAM3-LiteText runtime、checkpoint，或已有的 YOLOX ONNX 模型。模型按上游许可证下载，不要提交到 GitHub。

以下配置应在源码仓库目录中完成；v1.1.0 Windows CPU ZIP 只负责 CPU 编译包，不能用安装 Conda 的方式替换其内部 OpenCV。源码目录建议如下：

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
