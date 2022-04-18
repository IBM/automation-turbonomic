#!/bin/bash
###################################################################
#Script Name    : addLicense.sh
#Description    : This script adds a license to Turbonomic instance.
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Turbonomic user having privilige to add license
#                 3) Password for the Turbonomic user
#                 4) License file
###################################################################
turbo_url=$1
turbo_user=$2
turbo_pwd=$3
turbo_license=$4

# Build login_url and license_urls
login_url=$turbo_url/api/v3/login?hateoas=true
license_url=$turbo_url/api/v3/licenses


# Get the authentication token
if curl -s -c /tmp/cookies -k  -H "accept: application/json" "$login_url" -d "username=$turbo_user&password=$turbo_pwd" | grep -q "authToken"
then
 echo -e "\nAuthentication is successful"
else
 echo -e "\nAuthentication failed"
 exit 1
fi

# Add the license
if curl -X POST "$license_url" -H "accept: application/json" -H "Content-Type: multipart/form-data" -b /tmp/cookies -F "file=@$turbo_license" | grep -q "licenseOwner"
then
 echo -e "\nLicense addition is successful"
else
 echo -e "\nLicense addition failed"
fi
