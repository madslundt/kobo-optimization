#!/bin/sh
CONF="/mnt/onboard/.kobo/Kobo/Kobo eReader.conf"

if [ "$1" = "--sync" ]; then
    CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
    sed -i "s|^active_api_endpoint=.*|active_api_endpoint=$CURRENT|" "$CONF"
    exit 0
fi

ENDPOINT="$1"
[ -z "$ENDPOINT" ] && exit 0

CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
ACTIVE=$(grep "^active_api_endpoint=" "$CONF" | cut -d'=' -f2-)
[ -z "$ACTIVE" ] && ACTIVE="$CURRENT"

if [ "$ENDPOINT" = "$ACTIVE" ]; then
    [ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
    exit 0
fi

[ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
printf "API endpoint updated to:\n%s\n\nPlease reboot your Kobo." "$ENDPOINT"
