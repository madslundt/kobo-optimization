#!/bin/sh
> /mnt/onboard/tailscale.log
grep -q "8.8.8.8" /etc/resolv.conf || echo "nameserver 8.8.8.8" >> /etc/resolv.conf
cd /mnt/onboard/clara-bw
sh install-tailscale.sh >> /mnt/onboard/tailscale.log 2>&1
if [ $? -eq 0 ]; then
    echo "Tailscale installed successfully! Now run Tailscale Auth to connect." > /mnt/onboard/tailscale.log
fi
