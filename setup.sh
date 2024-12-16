#!/usr/bin/env bash

# Start the dbus-daemon and set the `DBUS_SESSION_BUS_ADDRESS`` environment variable
export DBUS_SESSION_BUS_ADDRESS=$(dbus-daemon --fork --config-file=/usr/share/dbus-1/session.conf --print-address)

# Start audio server
pulseaudio --start --exit-idle-time=-1

exec bash
