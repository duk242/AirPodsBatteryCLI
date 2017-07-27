# AirPods Battery CLI 2.3
## Copyright 2017 Dustin Kerr & Daniel Jones, All Rights Reserved.
## Released under the MIT License.


### About
This is a CLI tool for Grabbing the AirPods Battery Status

Information is collected from defaults read /Library/Preferences/com.apple.Bluetooth to grab Battery Info from a pair of connected AirPods. It will currently only grab the info for the first paired set of W1 supported headphones.

### Usage

If you have multiple sets of Headphones, you can change the line that reads:

MAC_ADDR=$(grep -b2 "Minor Type: Headphones"<<<"${SYSTEM_PROFILER}"|awk '/Address/{print $3}')

To match the MAC address of heaphones you want info for:

MAC_ADDR="7c-04-d0-af-88-62"

### Guide

There is a bigger usage guide available online at:
http://blog.duklabs.com/airpods-power-in-touchbar/

### Requirements

This has been tested and works on OSX 10.12.6 and above.
