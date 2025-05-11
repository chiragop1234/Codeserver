#!/bin/bash
# Start code-server in the background
code-server --port $PORT --disable-telemetry --auth none &
CODE_SERVER_PID=$!
# Wait for code-server to start (up to 30 seconds)
for i in {1..30}; do
  if nc -z 127.0.0.1 $PORT; then
    echo "code-server is listening on port $PORT"
    break
  else
    echo "Waiting for code-server to start..."
    sleep 1
  fi
done
# Check if code-server is running
if ! nc -z 127.0.0.1 $PORT; then
  echo "code-server failed to start"
  exit 1
fi
# Start cloudflared to tunnel the code server
./cloudflared tunnel --url http://127.0.0.1:$PORT --metrics localhost:45678
