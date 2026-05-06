#!/bin/sh
CONF="/mnt/onboard/.kobo/Kobo eReader.conf"
ENDPOINT="$1"

[ -z "$ENDPOINT" ] && exit 0

CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)

[ "$ENDPOINT" = "$CURRENT" ] && exit 0

sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
printf "API endpoint updated to:\n%s\n\nPlease reboot your Kobo." "$ENDPOINT"
