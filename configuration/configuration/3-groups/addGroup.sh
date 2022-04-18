#!/bin/bash
###################################################################
#Script Name    : addGroup.sh
#Description    : This script creates a Group.
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Turbonomic user having privilige to create Group
#                 3) Password for the Turbonomic user
#                 4) Turbonomic group DTO i.e. group definition file in json format
###################################################################
turbo_url=$1
turbo_user=$2
turbo_pwd=$3
turbo_group=$4

# Build login_url and group_urls
login_url=$turbo_url/api/v3/login?hateoas=true
group_url=$turbo_url/api/v3/groups


# Get the authentication token
if curl -s -c /tmp/cookies -k  -H "accept: application/json" "$login_url" -d "username=$turbo_user&password=$turbo_pwd" | grep -q "authToken"
then
 echo -e "\nAuthentication is successful"
else
 echo -e "\nAuthentication failed"
 exit 1
fi

# Add the group
if curl -k -d @$turbo_group -X POST "$group_url" -H "content-type: application/json" -b /tmp/cookies | grep -q "uuid"
then
 echo -e "\ngroup creation is successful"
else
 echo -e "\nTarget creation failed"
fi
