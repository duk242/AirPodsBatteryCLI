#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1
# Contributors: ankushg, spetykowski, danozdotnet
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.

# Put the Mac Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'

# See if we're connected to them
CONNECTED=$(system_profiler SPBluetoothDataType|awk "/${MACADDR}/i {for(i=1; i<=6; i++) {getline; print}}"|grep "Connected: Yes"|sed 's/.*Connected: Yes/1/')
if [[ "${CONNECTED}" ]]; then
  BTDATA=$(defaults read /Library/Preferences/com.apple.Bluetooth|awk "/\"${MACADDR}\".=\s*\{[^\}]*\}/i {for(i=1; i<=6; i++) {getline; print}}")

  COMBINEDBATT=$(grep "BatteryPercentCombined" <<< "${BTDATA}"|sed 's/.*BatteryPercentCombined = //'|sed 's/;//')
  HEADSETBATT=$(grep "HeadsetBattery" <<< "${BTDATA}"|sed 's/.*HeadsetBattery = //'|sed 's/;//')
  SINGLEBATT=$(grep "BatteryPercentSingle" <<< "${BTDATA}"|sed 's/.*BatteryPercentSingle = //'|sed 's/;//')
  CASEBATT=$(grep "BatteryPercentCase" <<< "${BTDATA}"|sed 's/.*BatteryPercentCase = //'|sed 's/;//')
  LEFTBATT=$(grep "BatteryPercentLeft" <<< "${BTDATA}"|sed 's/.*BatteryPercentLeft = //'|sed 's/;//') 
  RIGHTBATT=$(grep "BatteryPercentRight" <<< "${BTDATA}"|sed 's/.*BatteryPercentRight = //'|sed 's/;//')

  OUTPUT="🎧"
  [[ ! -z "${COMBINEDBATT}" ]] && output="${OUTPUT} ${COMBINEDBATT}%"
  [[ ! -z "${HEADSETBATT}" ]] && output="${OUTPUT} ${HEADSETBATT}%"
  [[ ! -z "${SINGLEBATT}" ]] && output="${OUTPUT} ${SINGLEBATT}%"
  [[ ! -z "${LEFTBATT}" ]] && output="${OUTPUT} L: ${LEFTBATT}%"
  [[ ! -z "${RIGHTBATT}" ]] && output="${OUTPUT} R: ${RIGHTBATT}%"
  [[ ! -z "${CASEBATT}" ]] && output="${OUTPUT} C: ${CASEBATT}%"

  echo "${OUTPUT}"
else
  echo "🎧 Not Connected"
fi
