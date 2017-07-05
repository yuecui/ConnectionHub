#!/bin/bash
mosquitto -d -c /etc/mosquitto/mosquitto.conf.example && sudo /etc/init.d/ssh start
