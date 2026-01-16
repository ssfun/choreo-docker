FROM ghcr.io/open-webui/open-webui:main-slim

WORKDIR /app/backend

COPY --from=ghcr.io/komari-monitor/komari-agent:latest /app/komari-agent /app/backend/komari-agent
COPY COPY entrypoint.sh /app/backend/entrypoint.sh

RUN chmod +x /app/backend/entrypoint.sh

# --- 1. 核心路径配置 (指向 /tmp) ---
ENV DATA_DIR=/tmp/data
ENV HOME=/tmp
ENV STATIC_DIR=/tmp/static
# 覆盖模型缓存路径
ENV HF_HOME=/tmp/data/cache/embedding/models
ENV SENTENCE_TRANSFORMERS_HOME=/tmp/data/cache/embedding/models
ENV TIKTOKEN_CACHE_DIR=/tmp/data/cache/tiktoken
ENV WHISPER_MODEL_DIR=/tmp/data/cache/whisper/models

# --- 2. Choreo Web App 不支持 WebSocket ---
ENV ENABLE_WEBSOCKET_SUPPORT=false

# --- 3. 切换用户 ---
USER 10014

EXPOSE 8080

# --- 4. 启动命令 (包含自动创建目录和搬运静态文件) ---
CMD ["bash", "-c", "mkdir -p /tmp/data /tmp/static && cp -r /app/backend/open_webui/static/* /tmp/static/ && exec bash start.sh"]
