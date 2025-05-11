# Use Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy all files from the current directory to /app
COPY . /app

# Install dependencies and tools
RUN apt-get update -y && \
    apt-get install -y wget curl && \
    wget -q -nc https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared && \
    chmod +x cloudflared && \
    curl -fsSL https://code-server.dev/install.sh | sh

# Set the port environment variable
ENV PORT=10000

# Copy the startup script
COPY start.sh /app/start.sh

# Make the script executable
RUN chmod +x /app/start.sh

# Run the script when the container starts
CMD ["/app/start.sh"]
