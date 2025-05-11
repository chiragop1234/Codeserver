#!/bin/bash
# Start code-server in the background
code-server --port $PORT --disable-telemetry --auth none &
# Wait briefly for code-server to start
sleep 5
# Start cloudflared to tunnel the code-server service
./cloudflared tunnel --url http://127.0.0.1:$PORT --metrics localhost:45678
