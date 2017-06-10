#!/bin/bash
mosquitto -d -c /etc/mosquitto/mosquitto.conf.example
/etc/init.d/ssh start
