#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.

# Put the MAC Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'
OUTPUT='🎧'
VARIABLES=("BatteryPercentCombined" "HeadsetBattery" "BatteryPercentSingle" "BatteryPercentCase" "BatteryPercentLeft" "BatteryPercentRight")
BTDATA=$(awk '/\"${MACADDR}\".=\s*\{[^\}]*\}/i {for(i=1; i<=6; i++) {getline; print}}'<<<defaults read /Library/Preferences/com.apple.Bluetooth)
CONNECTED=$(awk "/$MACADDR/i {for(i=1; i<=6; i++) {getline; print}}"<<<system_profiler SPBluetoothDataType|grep "Connected: Yes"|sed 's/.*Connected: Yes/1/')

if [[ "${CONNECTED}" ]]; then
  for i in "${VARIABLES[@]}"; do
    declare -x "${i}"="$(grep "${i}"<<<"${BTDATA}"|sed "s/.*${i} = //"|sed 's/;//')"
    [[ ! -z "${!i}" ]] && OUTPUT="${OUTPUT} $(awk '/BatteryPercent/{print substr($0,15,1)": "}'<<<${i})${!i}%"
  done
  printf "%s\\n" "${OUTPUT}"
else
  printf "%s Not Connected\\n" "${OUTPUT}"
fi