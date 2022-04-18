#!/bin/bash
###################################################################
#Script Name    : addUser.sh
#Description    : This script adds a User to Turbonomic instance.
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Turbonomic user having privilige to create new users
#                 3) Password for the Turbonomic user
#                 4) Turbonomic user DTO i.e. user definition file in json format
###################################################################
turbo_url=$1
turbo_user=$2
turbo_pwd=$3
turbo_userdef=$4

# Build login_url and target_urls
login_url=$turbo_url/api/v3/login?hateoas=true
user_url=$turbo_url/api/v3/users


# Get the authentication token
if curl -s -c /tmp/cookies -k  -H "accept: application/json" "$login_url" -d "username=$turbo_user&password=$turbo_pwd" | grep -q "authToken"
then
 echo -e "\nAuthentication is successful"
else
 echo -e "\nAuthentication failed"
 exit 1
fi

# Add the target
if curl -k -d @$turbo_userdef -X POST "$user_url" -H "content-type: application/json" -b /tmp/cookies | grep -q "uuid"
then
 echo -e "\nUser account creation successful"
else
 echo -e "\nUser account creation failed"
fi
