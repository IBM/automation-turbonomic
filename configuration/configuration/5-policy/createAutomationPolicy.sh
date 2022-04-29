#!/bin/bash
###################################################################
#Script Name    : createAutomationPolicy.sh
#Description    : This script creates automation policy.
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Turbonomic user having privilige to add target
#                 3) Password for the Turbonomic user
#                 4) Turbonomic automation policy DTO i.e. automation policy definition file in json format
###################################################################
turbo_url=$1
turbo_user=$2
turbo_pwd=$3
turbo_policy=$4

# Build login_url and target_urls
login_url=$turbo_url/api/v3/login?hateoas=true
policy_url=$turbo_url/api/v3/settingspolicies


# Get the authentication token
if curl -s -c /tmp/cookies -k  -H "accept: application/json" "$login_url" -d "username=$turbo_user&password=$turbo_pwd" | grep -q "authToken"
then
 echo -e "\nAuthentication is successful"
else
 echo -e "\nAuthentication failed"
 exit 1
fi

# Create the policy
if curl -k -d @$turbo_policy -X POST "$policy_url" -H "content-type: application/json" -b /tmp/cookies | grep -q "uuid"
then
 echo -e "\nPolicy creation is successful"
else
 echo -e "\nPolicy creation failed"
fi
