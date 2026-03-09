#!/bin/bash
# First: chmod +x net_setup.sh net_cleanup.sh net_verify.sh
# Second: Usage: sudo ./net_setup.sh <delay_ms> <packet_loss_rate>, i.g., sudo ./net_setup.sh 200 0.01
# i.g., sudo ./net_setup.sh 500 0.05
# Third: ./net_verify.sh
# Fourth:  sudo ./net_cleanup.sh

DELAY=${1:-200}
PLR=${2:-0.10}

echo "Setting up: delay=${DELAY}ms, packet_loss=${PLR}"

sudo dnctl pipe 1 config delay $DELAY plr $PLR

echo "dummynet out quick proto tcp from any to any port 443 pipe 1" | sudo pfctl -a appagent_test -f -

awk '
/dummynet-anchor "com.apple\/\*"/ {print $0; print "dummynet-anchor \"appagent_test\""; next}
/^anchor "com.apple\/\*"/ {print $0; print "anchor \"appagent_test\""; next}
1
' /etc/pf.conf | sudo pfctl -f -

sudo pfctl -E

echo "Done. Network impairment active."