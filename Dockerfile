FROM ghcr.io/open-webui/open-webui:main

# Choreo 用户 ID
ARG CHOREO_UID=10014
ARG CHOREO_GID=10014

# --- 1. 核心路径重定向 (全部指向 /tmp) ---
ENV DATA_DIR=/tmp/data
ENV HOME=/tmp

# 解决 "Read-only file system" 报错的关键：
# 将静态资源目录也指向 /tmp
ENV STATIC_DIR=/tmp/static

# 覆盖模型缓存路径
ENV HF_HOME=/tmp/data/cache/embedding/models
ENV SENTENCE_TRANSFORMERS_HOME=/tmp/data/cache/embedding/models
ENV TIKTOKEN_CACHE_DIR=/tmp/data/cache/tiktoken
ENV WHISPER_MODEL_DIR=/tmp/data/cache/whisper/models

# --- 2. 切换用户 ---
USER 10014

# --- 3. 关键逻辑：搬运文件并启动 ---
# 解释：
# 1. mkdir: 创建数据目录和静态文件目录
# 2. cp: 把原镜像里只读的静态文件(图标/CSS) 复制到 /tmp/static，这样 App 就能修改它们了
# 3. start.sh: 正常启动应用
CMD ["bash", "-c", "mkdir -p /tmp/data /tmp/static && cp -r /app/backend/open_webui/static/* /tmp/static/ && exec bash start.sh"]
