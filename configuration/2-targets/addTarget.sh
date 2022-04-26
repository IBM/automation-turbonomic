#!/bin/bash
###################################################################
#Script Name    : addTarget.sh
#Description    : This script adds a target to Turbonomic instance.
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Turbonomic user having privilige to add target
#                 3) Password for the Turbonomic user
#                 4) Turbonomic target DTO i.e. target definition file in json format
###################################################################
turbo_url=$1
turbo_user=$2
turbo_pwd=$3
turbo_target=$4

# Build login_url and target_urls
login_url=$turbo_url/api/v3/login?hateoas=true
target_url=$turbo_url/api/v3/targets

#echo -e "\nlogin_url: $login_url"
#echo -e "\ntarget_url: $target_url"


# Get the authentication token
if curl -s -c /tmp/cookies -k  -H "accept: application/json" "$login_url" -d "username=$turbo_user&password=$turbo_pwd" | grep -q "authToken"
then
 echo -e "\nAuthentication is successful"
else
 echo -e "\nAuthentication failed"
 exit 1
fi

# Add the target
if curl -k -d @$turbo_target -X POST "$target_url" -H "content-type: application/json" -b /tmp/cookies | grep -q "uuid"
then
 echo -e "\nTarget addition is successful"
else
 echo -e "\nTarget addition failed"
 exit 1
fi
