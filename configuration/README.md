# turbonomic-configurations
This repository contains the scripts to configure Turbonomic after it has been provisioned. Turbonomic has rich set of [APIs](https://docs.turbonomic.com/pdfdocs/Turbonomic_API_PRINT_8.5.0.pdf) and allows all the tasks to be carried out through APIs. These scripts can be used as part of automation modules to initilize administrator user, apply license, add targets, create groups, create user accounts and create automation policies.
Intention is to have sub-directories specific to each configuration that will contain shell script and sample json files containing the configuration details of the entities that need to be configured.

Below are the details on how to execute the scripts. The prefix number suggest the sequence of execution:

## 0-initial
The very first step after Turbonomic installation is to set the password for the default 'admininstrator' user. This subdirectory contains a script [setAdminPassword.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/0-initial/setAdminPassword.sh) that sets the initial password for the default 'administrator' user. 
### Example usage
`./setAdminPassword.sh <Turbonomic url> <turbo_admin_initial_pwd>`

For example:

`./setAdminPassword.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6cce7f379ae819553d37d5f2eb142bd6-0000.eu-gb.containers.appdomain.cloud P@ssword`

## 1-license
   The second step is to apply license. This subdirectory contains a script [addLicense.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/1-license/addLicense.sh) that adds the license to the Turbonomic instance.

### Example usage
`./addLicense.sh <Turbonomic url> <Turbonomic_user> <Turbonomic password> <license file>`

For examaple:

`./addLicense.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6cce7f379ae819553d37d5f2eb142bd6-0000.eu-gb.containers.appdomain.cloud administrator P@ssword turbonomic.lic`
             
  
## 2-targets
This subdirectory contains a script [addTarget.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/2-targets/addTarget.sh) and sample JSON files to add few different types of targets. You can create the sample JSON files (DTO) specific to your target entities by following the [documentation](https://docs.turbonomic.com/pdfdocs/Turbonomic_API_PRINT_8.5.0.pdf).

### Example usage
`./addTarget.sh <Turbonomic url> <Turbonomic_user> <Turbonomic password> <JSON file containing entity configuration>`

For example:

`./addTarget.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6cce7f379ae819553d37d5f2eb142bd6-0000.eu-gb.containers.appdomain.cloud administrator P@ssword instana-squad.json`

## 3-groups
  After targets are added; groups can be created so that automation policies and scoping can be applied to resources. This subdirectory contains a script [addGroup.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/3-groups/addGroup.sh) to create a new group. You can create the sample JSON files (DTO) to create groups by following the [documentation](https://docs.turbonomic.com/pdfdocs/Turbonomic_API_PRINT_8.5.0.pdf).

### Example usage
`./addGroup.sh <Turbonomic url> <Turbonomic_user> <Turbonomic password> <JSON file containing group definition>`

For example:

`./addGroup.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6cce7f379ae819553d37d5f2eb142bd6-0000.eu-gb.containers.appdomain.cloud administrator P@ssword cloud_group.json`
  
## 4-users
  After groups are created, new users can be created with required scopes. This subdirectory contains a script [addUser.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/4-user/addUser.sh) to create new users. You can create the sample JSON files (DTO) to create users by following the [documentation](https://docs.turbonomic.com/pdfdocs/Turbonomic_API_PRINT_8.5.0.pdf).  

### Example usage
`./addUser.sh <Turbonomic url> <Turbonomic_user> <Turbonomic password> <JSON file containing user definition>`

For examaple:

`./addUser.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6ccd7f378ae819553d37d5f2ee142bd6-0000.eu-gb.containers.appdomain.cloud administrator turbo4test observer.json`
  
## 5-policy
  After groups are created, automation policies can be created on required groups. This subdirectory contains the script [createAutomationPolicy.sh](https://github.ibm.com/anand-awasthi/turbonomic-configurations/blob/main/5-policy/createAutomationPolicy.sh) to create new automation policies. You can create the sample JSON files (DTO) to create automation policies by following the [documentation](https://docs.turbonomic.com/pdfdocs/Turbonomic_API_PRINT_8.5.0.pdf)

### Example usage
`./createAutomationPolicy.sh <Turbonomic url> <Turbonomic_user> <Turbonomic password> <JSON file containing automation policy definition>`

For example:

`./createAutomationPolicy.sh https://nginx-turbo.itzroks-060001q8qm-9lv1sp-6ccd7f378ae819553d37d5f2ee142bd6-0000.eu-gb.containers.appdomain.cloud administrator turbo4test digibank_autoPolicy.json`
