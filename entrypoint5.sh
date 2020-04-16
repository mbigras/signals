#!/bin/bash
echo this is a start up script
echo got args $@
echo doing some startup prep
sleep 1
echo passing args to app now
exec python3 -u app.py $@
