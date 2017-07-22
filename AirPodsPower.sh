#!/bin/bash
# Duckie's heaps mad W1-enabled Headphone Power Script.  Version 1
# Contributors: ankushg
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.


# Put the Mac Address of your W1-enabled headphones (Apple AirPods, Beats Solo3, Powerbeats3, BeatsX) in here.
MACADDR='7c-04-d0-af-88-62'


# See if we're connected to them
CONNECTED=`system_profiler SPBluetoothDataType | /usr/local/bin/pcregrep -Mi "$MACADDR(\n.*){6}" | grep "Connected: Yes" | sed 's/.*Connected: Yes/1/'`
if [ $CONNECTED ]; then
	BTDATA=`defaults read /Library/Preferences/com.apple.Bluetooth | /usr/local/bin/pcregrep -Mi "\"$MACADDR\".=\s*\{[^\}]*\}"`
	
	COMBINEDBATT=`echo "$BTDATA" | grep BatteryPercentCombined | sed 's/.*BatteryPercentCombined = //' | sed 's/;//'` 
	HEADSETBATT=`echo "$BTDATA" | grep HeadsetBattery | sed 's/.*HeadsetBattery = //' | sed 's/;//'` 
	SINGLEBATT=`echo "$BTDATA" | grep BatteryPercentSingle | sed 's/.*BatteryPercentSingle = //' | sed 's/;//'` 
	CASEBATT=`echo "$BTDATA" | grep BatteryPercentCase | sed 's/.*BatteryPercentCase = //' | sed 's/;//'` 
	LEFTBATT=`echo "$BTDATA" | grep BatteryPercentLeft | sed 's/.*BatteryPercentLeft = //' | sed 's/;//'` 
	RIGHTBATT=`echo "$BTDATA" | grep BatteryPercentRight | sed 's/.*BatteryPercentRight = //' | sed 's/;//'` 

	output="🎧"
	[[ !  -z  $COMBINEDBATT  ]] && output="$output $COMBINEDBATT%"
	[[ !  -z  $HEADSETBATT  ]] && output="$output $HEADSETBATT%"
	[[ !  -z  $SINGLEBATT  ]] && output="$output $SINGLEBATT%"
	[[ !  -z  $LEFTBATT  ]] && output="$output L: $LEFTBATT%"
	[[ !  -z  $RIGHTBATT  ]] && output="$output R: $RIGHTBATT%"
	[[ !  -z  $CASEBATT  ]] && output="$output C: $CASEBATT%"
	
	echo $output
else
	echo "🎧 Not Connected"
fi

