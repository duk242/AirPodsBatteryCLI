#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.

# Put the Mac Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'

# Don't edit anything below this line ;)
OUTPUT='\xf0\x9f\x8e\xa7'
VARIABLES=("BatteryPercentCombined" "HeadsetBattery" "BatteryPercentSingle" "BatteryPercentCase" "BatteryPercentLeft" "BatteryPercentRight")
BTDATA=$(defaults read /Library/Preferences/com.apple.Bluetooth|awk '/\"${MACADDR}\".=\s*\{[^\}]*\}/i {for(i=1; i<=6; i++) {getline; print}}')
CONNECTED=$(system_profiler SPBluetoothDataType | awk "/$MACADDR/i {for(i=1; i<=6; i++) {getline; print}}" | grep "Connected: Yes" | sed 's/.*Connected: Yes/1/')

if [[ "${CONNECTED}" ]]; then
  for i in "${VARIABLES[@]}"; do
    declare -x "${i}"="$(grep "${i}" <<< "${BTDATA}")|sed 's/.*${i} = //'|sed 's/;//')"
    [[ ! -z "${$i}" ]] && OUTPUT="${OUTPUT} ${$i}%"
  done
  printf "%s\\n" "${OUTPUT}"
else
  printf "%s Not Connected\\n" "${OUTPUT}"
fi