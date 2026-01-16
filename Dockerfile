FROM ghcr.io/open-webui/open-webui:main-slim

COPY --from=ghcr.io/komari-monitor/komari-agent:latest /app/komari-agent /app/komari-agent
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

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

# --- 3. 关闭 Ollama API ---
ENV ENABLE_OLLAMA_API=false

# --- 4. 切换用户 ---
USER 10014

EXPOSE 8080

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["bash", "start.sh"]
