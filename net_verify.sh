#!/bin/bash
# Verify current network impairment status

echo "=== L7 latency test ==="
time curl -sI https://api.openai.com -o /dev/null

echo ""
echo "=== Pipe stats (pkts/drp > 0 means active) ==="
sudo dnctl pipe 1 show 2>&1