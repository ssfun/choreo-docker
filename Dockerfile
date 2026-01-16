FROM ghcr.io/open-webui/open-webui:main-slim

# Choreo 用户 ID
ARG CHOREO_UID=10014
ARG CHOREO_GID=10014

# --- 1. 核心路径配置 (指向 /tmp) ---
ENV DATA_DIR=/tmp/data
ENV HOME=/tmp
ENV STATIC_DIR=/tmp/static
# 覆盖模型缓存路径
ENV HF_HOME=/tmp/data/cache/embedding/models
ENV SENTENCE_TRANSFORMERS_HOME=/tmp/data/cache/embedding/models
ENV TIKTOKEN_CACHE_DIR=/tmp/data/cache/tiktoken
ENV WHISPER_MODEL_DIR=/tmp/data/cache/whisper/models

# --- 2. 关键修复：解决 WebSocket 400 报错 ---
# 允许 Uvicorn 信任 Choreo 的负载均衡器 IP，从而正确处理 WebSocket 连接
ENV FORWARDED_ALLOW_IPS="*"

# --- 3. 切换用户 ---
USER 10014

# --- 4. 启动命令 (包含自动创建目录和搬运静态文件) ---
CMD ["bash", "-c", "mkdir -p /tmp/data /tmp/static && cp -r /app/backend/open_webui/static/* /tmp/static/ && exec bash start.sh"]
