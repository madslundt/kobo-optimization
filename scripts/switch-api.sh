#!/bin/sh
CONF="/mnt/onboard/.kobo/Kobo eReader.conf"

case "$1" in
    --sync)
        # Sync active_api_endpoint to current api_endpoint before a manual reboot
        CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
        sed -i "s|^active_api_endpoint=.*|active_api_endpoint=$CURRENT|" "$CONF"
        exit 0
        ;;
    --commit)
        # Update both api_endpoint and active_api_endpoint before a scripted reboot
        ENDPOINT="$2"
        [ -z "$ENDPOINT" ] && exit 0
        sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
        sed -i "s|^active_api_endpoint=.*|active_api_endpoint=$ENDPOINT|" "$CONF"
        exit 0
        ;;
esac

ENDPOINT="$1"
[ -z "$ENDPOINT" ] && exit 0

CURRENT=$(grep "^api_endpoint=" "$CONF" | cut -d'=' -f2-)
ACTIVE=$(grep "^active_api_endpoint=" "$CONF" | cut -d'=' -f2-)
[ -z "$ACTIVE" ] && ACTIVE="$CURRENT"

if [ "$ENDPOINT" = "$ACTIVE" ]; then
    # Switching back to what Nickel has loaded — restore file silently if needed
    [ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
    exit 0
fi

# Different from active — update file and prompt reboot
[ "$ENDPOINT" != "$CURRENT" ] && sed -i "s|^api_endpoint=.*|api_endpoint=$ENDPOINT|" "$CONF"
printf "API endpoint updated to:\n%s\n\nPlease reboot your Kobo." "$ENDPOINT"
