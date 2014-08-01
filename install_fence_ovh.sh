#!/bin/bash

COMMIT="without-ipmi"

cd /usr/sbin

wget "https://raw.githubusercontent.com/adriangibanelbtactic/fence-agents/${COMMIT}/fence/agents/ovh/fence_ovh.py" -O fence_new_ovh

sed -i 's~@FENCEAGENTSLIBDIR@~/usr/local/share/fence-ovh~g' fence_new_ovh

# Fastmage only - Begin
#sed -i 's~STATUS_RESCUE_PRO_SLEEP = 360~STATUS_RESCUE_PRO_SLEEP = 720~g' fence_new_ovh
# Fastmage only - End


chmod +x fence_ovh

mkdir --parents /usr/local/share/fence-ovh
cd /usr/local/share/fence-ovh

wget "https://raw.githubusercontent.com/adriangibanelbtactic/fence-agents/${COMMIT}/fence/agents/lib/fencing.py.py" -O fencing.py
wget "https://raw.githubusercontent.com/adriangibanelbtactic/fence-agents/${COMMIT}/fence/agents/lib/OvhApi.py.py" -O OvhApi.py

ccs_update_schema -f
