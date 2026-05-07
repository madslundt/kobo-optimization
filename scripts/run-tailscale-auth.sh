#!/bin/sh
> /mnt/onboard/tailscale.log
tailscale up >> /mnt/onboard/tailscale.log 2>&1
