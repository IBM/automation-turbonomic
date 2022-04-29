#!/bin/bash
###################################################################
#Script Name    : setAdminPassword.sh
#Description    : This script sets initial password for the administrator user
#                 It accepts below parameters:
#                 1) Turbonomic instance url
#                 2) Initial password to set for administrator
###################################################################
turbo_url=$1
turbo_admin_initial_pwd=$2

# Build initial password set url
initial_url=$turbo_url/api/v3/initAdmin?disable_hateoas=true

# set the password for administrator user
if curl -s -k  -H "accept: application/json" "$initial__url" -d "username=administrator&password=$turbo_admin_initial_pwd" | grep -q "username"
then
 echo -e "\nPassword set for administrator successfully"
else
 echo -e "\nPassword set action for administrator failed"
 exit 1
fi
