FROM ubuntu:latest
WORKDIR /app
COPY . /app
RUN apt-get update -y && \
    apt-get install -y wget curl && \
    wget -q -nc https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared && \
    chmod +x cloudflared && \
    curl -fsSL https://code-server.dev/install.sh | sh
ENV PORT=10000
CMD code-server --port $PORT --disable-telemetry --auth none & \
    until curl -s http://127.0.0.1:$PORT > /dev/null; do \
        echo "Waiting for code-server to start..."; \
        sleep 1; \
    done; \
    echo "code-server is up, starting cloudflared"; \
    ./cloudflared tunnel --url http://127.0.0.1:$PORT --metrics localhost:45678
