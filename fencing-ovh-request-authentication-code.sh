#!/bin/bash

# Static variables
CURL_BINARY="curl"
OVH_API_AUTH_CREDENTIAL_URL="https://eu.api.ovh.com/1.0/auth/credential"

# Variables you should adapt to your own case:
OVH_APPLICATION_KEY="7kbG7Bk7S9Nt7ZSV"
DEDICATED_SERVER_OVH_NAMES="ns1100101.ip-101-01-01.eu ns2200202.ip-202-02-02.eu ns3300303.ip-003-03-03.eu" # Separated by spaces

function change_boot_device_acl() {
# $1 = Dedicated server ovh name
DEDICATED_SERVER="$1"

cat << EOF

        {
            "method": "PUT",
            "path": "/dedicated/server/${DEDICATED_SERVER}"
        }

EOF


}

function hard_reboot_acl() {
# $1 = Dedicated server ovh name
DEDICATED_SERVER="$1"

cat << EOF

        {
            "method": "POST",
            "path": "/dedicated/server/${DEDICATED_SERVER}/reboot"
        }

EOF


}

function task_acl() {
# $1 = Dedicated server ovh name
DEDICATED_SERVER="$1"

cat << EOF

        {
            "method": "GET",
            "path": "/dedicated/server/${DEDICATED_SERVER}/task/*"
        }

EOF


}

# Generate POST_MAIN_RULES
let servers_counter=0
for nserver in ${DEDICATED_SERVER_OVH_NAMES}; do
  let servers_counter=servers_counter+1
done
servers_total=${servers_counter}
POST_MAIN_RULES=""
let servers_counter=0
for nserver in ${DEDICATED_SERVER_OVH_NAMES}; do
  let servers_counter=servers_counter+1
  if [ $servers_counter = 1 ] ; then
    POST_MAIN_RULES="$(change_boot_device_acl ${nserver})"
  else
    POST_MAIN_RULES="${POST_MAIN_RULES}"",""$(change_boot_device_acl ${nserver})"
  fi
  POST_MAIN_RULES="${POST_MAIN_RULES}"",""$(hard_reboot_acl ${nserver})"
  POST_MAIN_RULES="${POST_MAIN_RULES}"",""$(task_acl ${nserver})"

done

"${CURL_BINARY}" \
  -X POST \
  -H "X-Ovh-Application: ${OVH_APPLICATION_KEY}" \
  -H "Content-type: application/json" \
"${OVH_API_AUTH_CREDENTIAL_URL}"  -d "{
    "accessRules": [
${POST_MAIN_RULES}
    ]
}"
