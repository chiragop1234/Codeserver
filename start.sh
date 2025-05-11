#!/bin/bash
# Start code-server in the background
code-server --port $PORT --disable-telemetry --auth none &
CODE_SERVER_PID=$!
# Wait for code-server to start
sleep 5
# Check if code-server is running
if ! kill -0 $CODE_SERVER_PID; then
  echo "code-server failed to start"
  exit 1
fi
# Start cloudflared to tunnel the code server
./cloudflared tunnel --url http://127.0.0.1:$PORT --metrics localhost:45678
