#!/bin/bash

config_name=${1:?"[Argument Exception]: Missing CONFIG_NAME"}


# get bearer token
oauth_token=$(curl  -k \
                    -X POST https://p-spring-cloud-services.uaa.run.pivotal.io/oauth/token \
                    -d "grant_type=client_credentials&client_id=p-config-server-5aeff18a-68e5-4478-a61d-df8e3fba9e02&client_secret=a5lu4Pu1m1nG" \
                    --silent)

bearer_token=$(echo ${oauth_token} | jq -r .access_token)


# get decrypted config file
echo "GET https://config-884fedfd-9e63-441b-ada8-ed1d2fd34a55.cfapps.io/${config_name}" >&2
response=$(curl -k \
                -H "Authorization: Bearer ${bearer_token}" \
                -X GET https://config-884fedfd-9e63-441b-ada8-ed1d2fd34a55.cfapps.io/${config_name} \
                --silent)

echo ${response}
