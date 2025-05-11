FROM ubuntu:latest
WORKDIR /app
COPY . /app
RUN apt-get update -y && \
    apt-get install -y wget curl && \
    wget -q -nc https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared && \
    chmod +x cloudflared && \
    curl -fsSL https://code-server.dev/install.sh | sh
ENV PORT=10000
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
