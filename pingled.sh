#!/bin/bash

# Common path for all GPIO access
BASE_GPIO_PATH=/sys/class/gpio

# Assign names to GPIO pin numbers for each light
out1="2"
out2="3"
out3="4"
out4="17"
out5="27"
out6="22"
out7="10"
out8="9"
out9="11"
out10="5"
out11="6"
out12="13"
out13="19"
out14="26"

# Assign names to states
ON="1"
OFF="0"

# Utility function to export a pin if not already exported
exportPin()
{
  if [ ! -e $BASE_GPIO_PATH/gpio$1 ]; then
    echo "$1" > $BASE_GPIO_PATH/export
  fi
}

# Utility function to set a pin as an output
setOutput()
{
  echo "out" > $BASE_GPIO_PATH/gpio$1/direction
}

# Utility function to change state of a light
setLightState()
{
  echo $2 > $BASE_GPIO_PATH/gpio$1/value
}

# Utility function to turn all lights off
allLightsOff()
{
  setLightState $out1 $OFF
  setLightState $out2 $OFF
  setLightState $out3 $OFF
  setLightState $out4 $OFF
  setLightState $out5 $OFF
  setLightState $out6 $OFF
  setLightState $out7 $OFF
  setLightState $out8 $OFF
  setLightState $out9 $OFF
  setLightState $out10 $OFF
  setLightState $out11 $OFF
  setLightState $out12 $OFF
  setLightState $out13 $OFF
  setLightState $out14 $OFF
}

# Ctrl-C handler for clean shutdown
shutdown()
{
  allLightsOff
  exit 0
}

trap shutdown SIGINT

# Export pins so that we can use them
exportPin $out1
exportPin $out2
exportPin $out3
exportPin $out4
exportPin $out5
exportPin $out6
exportPin $out7
exportPin $out8
exportPin $out9
exportPin $out10
exportPin $out11
exportPin $out12
exportPin $out13
exportPin $out14

# Set pins as outputs
setOutput $out1
setOutput $out2
setOutput $out3
setOutput $out4
setOutput $out5
setOutput $out6
setOutput $out7
setOutput $out8
setOutput $out9
setOutput $out10
setOutput $out11
setOutput $out12
setOutput $out13
setOutput $out14

# Turn lights off to begin
allLightsOff

# Loop forever until user presses Ctrl-C
while [ 1 ]
do

	ping -c 1 192.168.1.1 &> /dev/null && setLightState $out1 $ON || setLightState $out1 $OFF #Router 1
	ping -c 1 192.168.1.2 &> /dev/null && setLightState $out2 $ON || setLightState $out2 $OFF #Router 2
	ping -c 1 192.168.1.3 &> /dev/null && setLightState $out3 $ON || setLightState $out3 $OFF #Router 3
	ping -c 1 192.168.1.10 &> /dev/null && setLightState $out4 $ON || setLightState $out4 $OFF #PiHOLE cable
	ping -c 1 192.168.1.11 &> /dev/null && setLightState $out5 $ON || setLightState $out5 $OFF #PiHOLE WiFi
	ping -c 1 192.168.1.20 &> /dev/null && setLightState $out6 $ON || setLightState $out6 $OFF #CamServer
	ping -c 1 192.168.1.30 &> /dev/null && setLightState $out7 $ON || setLightState $out7 $OFF #Cam1
	ping -c 1 192.168.1.31 &> /dev/null && setLightState $out8 $ON || setLightState $out8 $OFF #Cam2
	ping -c 1 192.168.1.32 &> /dev/null && setLightState $out9 $ON || setLightState $out9 $OFF #Cam3
	ping -c 1 192.168.1.33 &> /dev/null && setLightState $out10 $ON || setLightState $out10 $OFF #Cam4
	ping -c 1 192.168.1.22 &> /dev/null && setLightState $out11 $ON || setLightState $out11 $OFF #HomeVideo
	ping -c 1 192.168.1.50 &> /dev/null && setLightState $out12 $ON || setLightState $out12 $OFF #X201
	ping -c 1 8.8.8.8 &> /dev/null && setLightState $out13 $ON || setLightState $out13 $OFF #Google (IP)
	ping -c 1 google.com &> /dev/null && setLightState $out14 $ON || setLightState $out14 $OFF #Google (DNS)
	
        sleep 15
done





