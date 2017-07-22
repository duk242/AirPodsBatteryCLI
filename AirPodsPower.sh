#!/bin/bash
# Duckie's heaps mad AirPods Power Script.  Version 1
# Check http://blog.duklabs.com/airpods-power-in-touchbar/ for more info.


# Put the Mac Address of your AirPods in here.
MACADDR='7c-04-d0-af-88-62'


# See if we're connected to them
CONNECTED=`system_profiler SPBluetoothDataType | /usr/local/bin/pcregrep -Mi "$MACADDR(\n.*){6}" | grep "Connected: Yes" | sed 's/.*Connected: Yes/1/'`
if [ $CONNECTED ]; then
	BTDATA=`defaults read /Library/Preferences/com.apple.Bluetooth | /usr/local/bin/pcregrep -Mi "\"$MACADDR\".=\s*\{[^\}]*\}"`

	CASEBATT=`echo "$BTDATA" | grep BatteryPercentCase | sed 's/.*BatteryPercentCase = //' | sed 's/;//'` 
	LEFTBATT=`echo "$BTDATA" | grep BatteryPercentLeft | sed 's/.*BatteryPercentLeft = //' | sed 's/;//'` 
	RIGHTBATT=`echo "$BTDATA" | grep BatteryPercentRight | sed 's/.*BatteryPercentRight = //' | sed 's/;//'` 

	echo "🎧 L: $LEFTBATT% R: $RIGHTBATT% C: $CASEBATT%"
else
	echo "No AirPods"
fi

