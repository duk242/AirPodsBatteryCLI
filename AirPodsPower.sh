#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.

# Put the MAC Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'
OUTPUT='🎧'; BLUETOOTH_DEFAULTS=$(defaults read /Library/Preferences/com.apple.Bluetooth); SYSTEM_PROFILER=$(system_profiler SPBluetoothDataType)
VARIABLES=("BatteryPercentCombined" "HeadsetBattery" "BatteryPercentSingle" "BatteryPercentCase" "BatteryPercentLeft" "BatteryPercentRight")
BTDATA=$(awk '/\"${MACADDR}\".=\s*\{[^\}]*\}/i {for(i=1; i<=6; i++) {getline; print}}' <<< "${BLUETOOTH_DEFAULTS}" )
CONNECTED=$(awk "/${MACADDR}/i {for(i=1; i<=6; i++) {getline; print}}" <<< "${SYSTEM_PROFILER}" |awk '/Connected: Yes/{print 1}')

if [[ "${CONNECTED}" ]]; then
  for I in "${VARIABLES[@]}"; do
    declare -x "${I}"="$(grep "${I}"<<<"${BTDATA}"|sed "s/.*${I} = //"|sed 's/;//')"
    [[ ! -z "${!I}" ]] && OUTPUT="${OUTPUT} $(awk '/BatteryPercent/{print substr($0,15,1)": "}'<<<"${I}")${!I}%"
  done
  printf "%s\\n" "${OUTPUT}"
else
  printf "%s Not Connected\\n" "${OUTPUT}"
fi