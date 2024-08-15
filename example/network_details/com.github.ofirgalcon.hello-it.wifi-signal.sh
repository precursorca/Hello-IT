#!/bin/bash

# Display wifi SNR as title

. "$HELLO_IT_SCRIPT_SH_LIBRARY/com.github.ygini.hello-it.scriptlib.sh"

function getWifiSNR {
	wifi=$(head -n50 /tmp/wifi-scan.txt)
	noiseLine=$(echo "$wifi" | grep "Noise" | cut -d ':' -f 2)
	noise=${noiseLine%dBm}
	signalLine=$(echo "$wifi" | grep "RSSI" | cut -d ':' -f 2)
	signal=${signalLine%dBm}
    SNR=$(($signal-$noise))
    echo "$SNR"
}

function updateTitleWithArgs {
    title=$(getWifiSNR)
    updateTitle "WiFi SNR: $title"
    updateTooltip "Get WiFi Signal to Noise Ratio."
}

function onClickAction {
    updateTitleWithArgs "$@"
    getWifiSNR | pbcopy
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
