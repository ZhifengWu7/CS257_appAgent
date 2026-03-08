#!/bin/bash
# Cleanup: restore system to original state

sudo pfctl -a appagent_test -F all
sudo pfctl -f /etc/pf.conf
sudo dnctl pipe 1 delete
sudo pfctl -d

echo "Network restored."