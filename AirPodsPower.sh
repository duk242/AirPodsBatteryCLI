#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 2.1
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.

OUTPUT='🎧'; BLUETOOTH_DEFAULTS=$(defaults read /Library/Preferences/com.apple.Bluetooth); SYSTEM_PROFILER=$(system_profiler SPBluetoothDataType)
MAC_ADDR=$(grep -b2 "Minor Type: Headphones" <<< "${SYSTEM_PROFILER}"|awk '/Address/{print $3}')
CONNECTED=$(grep -ia6 "${MAC_ADDR}" <<< "${SYSTEM_PROFILER}" | awk '/Connected: Yes/{print 1}')
BLUETOOTH_DATA=$(grep -ia6 '"'${MAC_ADDR}'"' <<< "${BLUETOOTH_DEFAULTS}")
BATTERY_LEVELS=("BatteryPercentCombined" "HeadsetBattery" "BatteryPercentSingle" "BatteryPercentCase" "BatteryPercentLeft" "BatteryPercentRight")

if [[ "${CONNECTED}" ]]; then
  for I in "${BATTERY_LEVELS[@]}"; do
    declare -x "${I}"="$(grep "${I}" <<< "${BLUETOOTH_DATA}"|sed "s/.*${I} = //"|sed 's/;//')"
    [[ ! -z "${!I}" ]] && OUTPUT="${OUTPUT} $(awk '/BatteryPercent/{print substr($0,15,1)": "}' <<< "${I}")${!I}%"
  done
  printf "%s\\n" "${OUTPUT}"
else
  printf "%s Not Connected\\n" "${OUTPUT}"
fi