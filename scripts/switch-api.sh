#!/bin/sh
CONF="/mnt/onboard/.kobo/Kobo/Kobo eReader.conf"

set_active() {
    if grep -q "^active_api_endpoint=" "$CONF"; then
        sed -i "s|^active_api_endpoint=.*|active_api_endpoint=$1|" "$CONF"
    else
        sed -i "s|^\(api_endpoint=.*\)|\1\nactive_api_endpoint=$1|" "$CONF"
    fi
}

if [ "$1" = "--sync" ]; then
    CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
    set_active "$CURRENT"
    exit 0
fi

ENDPOINT="$1"
[ -z "$ENDPOINT" ] && exit 0

CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
ACTIVE=$(grep "^active_api_endpoint=" "$CONF" | cut -d'=' -f2-)

if [ -z "$ACTIVE" ]; then
    ACTIVE="$CURRENT"
    set_active "$ACTIVE"
fi

if [ "$ENDPOINT" = "$ACTIVE" ]; then
    [ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
    exit 0
fi

[ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
printf "API endpoint updated to:\n%s\n\nPlease reboot your Kobo." "$ENDPOINT"
