#!/bin/bash
echo this is a start up script
echo got args $@
echo doing some startup prep
sleep 1
echo starting a sidecar process
/bin/cat &
echo passing args to app now
exec python3 -u app.py $@
