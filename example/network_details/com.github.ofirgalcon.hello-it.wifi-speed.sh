#!/bin/bash

# Display Wifi Tx rate as title

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function getWifiSpeed {
    wifi=$(head -n50 /tmp/wifi-scan.txt)
    speedLine=$(echo "$wifi" | grep "Tx" | cut -d ':' -f 2)
    echo "$speedLine"
}

function updateTitleWithArgs {
    title=$(getWifiSpeed)
    updateTitle "WiFi Speed: $title"
    updateTooltip "Get WiFi Speed."
}

function onClickAction {
    updateTitleWithArgs "$@"
    getWifiSpeed | pbcopy
}

function fromCronAction {
    updateTitleWithArgs "$@"
}

function setTitleAction {
    updateTitleWithArgs "$@"
}

function onNetworkAction {
	updateTitleWithArgs "$@"
}

main $@

exit 0
