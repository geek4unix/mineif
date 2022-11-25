#!/bin/bash


# Config vars - can edit

START_HOUR=0
END_HOUR=23
SOC_LIMIT=90
MINER=XMRIG

# Fetch info to make logical decision.
# e.g. check battery


#Get battery_voltage as float
function get_battery_voltage() {
BAT_VOLT_F=$(python3.10 /usr/local/bin/get_info_id.py -i 3092)
BAT_VOLT=${BAT_VOLT_F%.*}
}

#Get battery_soc
function get_battery_soc() {
BAT_SOC_F=$(python3.10 /usr/local/bin/get_info_id.py -i 7032)
BAT_SOC=${BAT_SOC_F%.*}
} 

#Get current hour
function get_hour() {
HOUR=$(date +%H)
}

#Get current daylight sensor value
function get_ds_value() {
#temp fixed value
DS_VALUE=45
}

function display_stats() {
echo "Battery SOC: $BAT_SOC"
echo "SOC Limit: $SOC_LIMIT"
echo "Battery Volts: $BAT_VOLT"
echo "Current Hour: $HOUR"
echo "Start Hour: $START_HOUR"
echo "End Hour: $END_HOUR"
echo "DayTime Sensor: $DS_VALUE"
echo "Mining Allowed: $MINING_ALLOW"
}

# Define how to start and stop miner

function get_mining_status() {
MINING_STATUS=$(export PATH=/bin:/usr/bin:$PATH; pgrep -i $MINER | wc -l | tr -d ' ')
}

function start_miner() {
2>&1 ~/xmr.sh >/dev/null &
echo "started ..." 
}

function stop_miner() {
killprocs=$(pgrep -i $MINER | xargs kill)
echo "stopped ..."
}

# logical to arrive decision to mine or not to mine

function decide() {

# Simple logic to make a decision - feel free to add / remove / modify the clauses

if ([[ $HOUR -ge $START_HOUR ]] && [[ $HOUR -lt $END_HOUR ]] && [[ $BAT_SOC -ge $SOC_LIMIT ]])
then
 MINING_ALLOW=true
else 
 MINING_ALLOW=false
fi

if ([[ $MINING_ALLOW == "false" ]] && [[ $MINING_STATUS -gt 0 ]]); then
stop_miner
fi

if ([[ $MINING_ALLOW == "true" ]] && [[ $MINING_STATUS -eq 0 ]]) ; then
start_miner
fi
}

get_battery_voltage
get_battery_soc
get_hour
get_ds_value
get_mining_status
decide
display_stats
