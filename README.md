# TechZone Automation - Turbonomic Automation for AWS, Azure, and IBM Cloud

### Change Log

- **08/2022** - Updated IBM Cloud Storage Class support
- **05/2022** - Usability updates and Bug Fixes
- **05/2022** - Bug Fix Release
- **04/2022** - Initial Release

> This collection of Turbonomic terraform automation layers has been crafted from a set of  [Terraform modules](https://modules.cloudnativetoolkit.dev/) created by the IBM GSI Ecosystem Lab team part of the [IBM Partner Ecosystem organization](https://www.ibm.com/partnerworld/public?mhsrc=ibmsearch_a&mhq=partnerworld). Please contact **Matthew Perrins** _mjperrin@us.ibm.com_, **Vijay Sukthankar** _vksuktha@in.ibm.com_, **Sean Sundberg** _seansund@us.ibm.com_, **Tom Skill** _tskill@us.ibm.com_,  or **Andrew Trice** _amtrice@us.ibm.com_ for more details or raise an issue on the repository.

The automation will support the installation of Turbonomic on three cloud platforms **AWS**, **Azure**, and **IBM Cloud**.

### Target Infrastructure

The Turbonomic automation assumes you have an OpenShift cluster already configured on your cloud of choice. The supported managed options are [ROSA for AWS](https://aws.amazon.com/rosa/), [ARO for Azure](https://azure.microsoft.com/en-us/services/openshift/) or [ROKS for IBM Cloud ](https://www.ibm.com/cloud/openshift).

Before you start to install and configure Turbonomic, you will need to identify what your target infrastructure is going to be. You can start from scratch and use one of the pre-defined reference architectures from IBM or bring your own. It is recommended to install this on a `4cpu x 16gb x 2 worker nodes` **OpenShift Cluster**

### Reference Architectures

The reference architectures are provided in three different forms, with increasing security and associated sophistication to support production configuration. These three forms are as follows:

- **Quick Start** - a simple architecture to quickly get an OpenShift cluster provisioned
- **Standard** - a standard production deployment environment with typical security protections, private endpoints, VPN server, key management encryption, etc
- **Advanced** - a more advanced deployment that employs network isolation to securely route traffic between the different layers.

For each of these reference architecture, we have provided a detailed set of automation to create the environment for the software. If you do not have an OpenShift environment provisioned, please use one of these. They are optimized for the installation of this solution.

| Cloud Platform                                                                                                            | Automation and Documentation                                                                                                                                                                                  |   
|---------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [TechZone for IBMers and Partners](https://techzone.ibm.com/collection/turbonomic-automation-multicloud) | You can provision ARO, ROSA and ROKS through IBM TechZone. This is only supported for IBMers and IBM Partners
| [IBM Cloud](https://cloud.ibm.com)                                                                                        | [IBM Cloud Quick Start](https://github.com/IBM/automation-ibmcloud-infra-openshift/tree/initial-version) </br> [IBM Cloud Standard](https://github.com/IBM/automation-ibmcloud-infra-openshift/tree/standard) |  
| [AWS](https://aws.amazon.com/)                                                                                            | [AWS Quick Start](https://github.com/IBM/automation-aws-infra-openshift/tree/1-quick-start) </br> [AWS Standard - Coming soon]()                                                                              |
| [Azure](https://portal.azure.com/#home)                                                                                   | [Azure Quick Start - Coming soon]()                                                                                 |                                                                                             | 
| Bring You Own Infrastructure                                                                                              | You will need to setup GitOps and Storage details on the following steps                                                                                                                                        /

### Getting Started

Within this repository you will find a set of Terraform template bundles that embody best practices for provisioning Turbonomic in multiple cloud environments. This `README.md` describes the SRE steps required to provision the Turbonomic software.

This suite of automation can be used for a Proof of Technology environment, or used as a foundation for production workloads with a fully working end-to-end cloud-native environment. The software installs using **GitOps** best practices with [**Red Hat Open Shift GitOps**](https://docs.openshift.com/container-platform/4.8/cicd/gitops/understanding-openshift-gitops.html)

## Turbonomic Architecture

The following reference architecture represents the logical view of how Turbonomic works after it is installed. After obtaining a license key you will need to register your data sources. They can range from other Kubernetes environment to VMWare and Virtual Machines.

![Reference Architecture](./turbonomic-arch.png)

## Deploying Turbonomic

The following instructions will help you install Turbonomic into AWS, Azure, and IBM Cloud OpenShift Kubernetes environment.

### Obtaining License Key

To use Turbonimic you are required to install a license key. For Proof of Concepts IBM Partners and IBMers can obtain it using the steps highlighted below.

#### Partners

For Partners follow these steps:

1. For PoCs/PoTs, Partners can download a license key from [Partner World Software Catalog](https://www.ibm.com/partnerworld/program/benefits/software-access-catalog)
2. You can search the software catalog for **M07FSEN Turbonomic Application Resource Management On-Prem 8.6** for install on Kubernetes English and download, this file is 12gb in size, once downloaded unzip to find the license key
3. Extract this download package to get the turbonomic license key This package contains license file for turbonomic, with a name similar to “TURBONOMIC-ARM.lic"
4. This file is covered by **Turbonomic ARM P/N are currently available under IBM PPA terms and conditions**

#### IBMers

For IBMers you can download a license key using these steps:

1. Go to [XL Leverage](https://w3-03.ibm.com/software/xl/download/ticket.wss)
2. Search with keyword: turbonomic
3. Select the package **M07FSEN Turbonomic Application Resource Management On-Prem 8.6** for install on Kubernetes English and download, this file is 12gb in size, once downloaded unzip to find the license key
4. Extract this download package to get the turbonomic license key This package contains license file for turbonomic, with a name similar to “TURBONOMIC-ARM.lic"

### Turbonomic for Multi Cloud

The turbonomic automation is broken into what we call layers of automation or bundles. The bundles enable SRE activities to be optimized. The automation is generic between clouds other than setting Storage for IBM Cloud. That was broken into a separate automation layer.

| BOM ID | Name                                                           | Description                                                                                                                                                                                                                                   | Run Time |
|--------|----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| 200    | [200 - OpenShift Gitops](./200-openshift-gitops)               | Set up OpenShift GitOps in ROSA, ARO or ROKS, this is required to install the software using gitops only use this if you are bringing your own OpenShift Cluster which has not been provisioned from the reference architectures listed above | 10 Mins  |
| 250 | [250 - Turbonomic Multi Cloud](./250-turbonomic-multicloud) | Provision Turbonomic into Multi Cloud environment AWS, Azure and IBM Cloud supported                                                                                                                                                          | 10 Mins  |


> At this time the most reliable way of running this automation is with Terraform in your local machine either through a bootstrapped container image or with native tools installed. We provide a Container image that has all the common SRE tools installed. [CLI Tools Image,](https://quay.io/repository/ibmgaragecloud/cli-tools?tab=tags) [Source Code for CLI Tools](https://github.com/cloud-native-toolkit/image-cli-tools)

## Installation Steps

Before you start the installation please install the pre-req tools on your machine.

### Pre-Req Setup

Please install the following Pre-Req tools to help you get started with the SRE tasks for installing Turbonomic into an existing OpenShift Cluster on AWS, Azure, or IBM Cloud.

Pre-requisites:
- Check you have a valid GitHub ID that can be used to create a repository in your own organization [GitHub]( https://github.com/) or GitHub Enterprise account.
- Install a code editor, we recommend [Visual Studio Code](https://code.visualstudio.com/)
- Install [Brew](https://brew.sh/)
- Install a **Colima** a replacement for Docker Desktop , [Colima](https://github.com/abiosoft/colima)
   ```
   brew install colima
   ```

### Installing Turbonomic

The installation process will use a standard GitOps repository that has been built using the Modules to support Turbonomic installation. The automation is consistent across three cloud environments AWS, Azure, and IBM Cloud.

Steps:

1. First step is to clone the automation code to your local machine. Run this git command in your favorite command line shell.

     ```
     git clone https://github.com/IBM/automation-turbonomic
     ```
2. Navigate into the automation-turbonomic folder using your command line.
   a.	The README.md has a comprehensive instructions on how to install this into other cloud environments than TechZone. This document focuses on getting it running in a TechZone requested environment.
3. Next you will need to set-up your credentials.properties file. This will enable a secure access to your cluster.

    ```
    cp credentials.template credentials.properties
    code credential.properties
    ```

    ```
    ## Add the values for the Credentials to access the OpenShift Environment
    ## Instructions to access this information can be found in the README.MD
    ## This is a template file and the ./launch.sh script looks for a file based on this template named credentials.properties
    
    ## gitops_repo_host: The host for the git repository
    export TF_VAR_gitops_repo_host=github.com
    ## gitops_repo_username: The username of the user with access to the repository
    export TF_VAR_gitops_repo_username=
    ## gitops_repo_token: The personal access token used to access the repository
    export TF_VAR_gitops_repo_token=
    
    ## TF_VAR_server_url: The url for the OpenShift api server
    export TF_VAR_server_url=
    ## TF_VAR_cluster_login_token: Token used for authentication to the api server
    export TF_VAR_cluster_login_token=
    ```

4. You will need to populate these values. Add your Git Hub username and your Personal Access Token to `repo_username` and `repo_token`
5. From you OpenShift console click on top right menu and select Copy login command and click on Display Token
6. Copy the API Token value into the `login_token` value
7. Copy the Server URL into the `server_url` value, only the part starting with https

8. We are now ready to start installing Turbonomic. Launch the automation runtime.
    - If using *Docker Desktop*, run `./launch.sh`. This will start a container image with the prompt opened in the `/terraform` directory.
    - If using *Multipass*, run `mutlipass shell cli-tools` to start the interactive shell, and cd into the `/automation/{template}` directory, where  `{template}` is the folder you've cloned this repo. Be sure to run `source credentials.properties` once in the shell.  
9. Next step is to create a workspace to run the Terraform automation. 
10. Run the command setup-workspace.sh you will need to provide the `-p` platform value which can be `azure` | `aws` or `ibm` then supply a prefix name

```
./setup-workspace.sh -p ibm -n turbo01
``` 

11. The default `terraform.tfvars` file is symbolically linked to the new `workspaces/current` folder so this enables you to edit the file in your native operating system using your editor of choice.
12. Edit the default `terraform.tfvars` file this will enable you to setup the GitOps parameters.

      ```
    ########################################################
    # Name: Turbonomic Terraform Variable File
    # Desc: Initial input variables to support installation of Turbonomic into the cloud provider of your choice
    ########################################################
    
    ## gitops-ocp-turbonomic_storage_class_name: Name of the block storage class to use - if multizone deployment then waitforfirstconsumer must be set on storageclass binding mode
    ## <your block storage on aws: gp2, on azure: managed-premium, on ibm: ibmc-vpc-block-10iops-tier>
    gitops-ocp-turbonomic_storage_class_name="ibmc-vpc-block-mzr"
    
    ## gitops-repo_host: The host for the git repository.
    gitops_repo_host="github.com"
    
    ## gitops-repo_type: The type of the hosted git repository (github or gitlab).
    gitops_repo_type="github"
    
    ## gitops-repo_org: The org/group where the git repository exists/will be provisioned.
    ## your gitorg - if left blank the value will default to your username
    gitops_repo_org="mjperrins"
    
    ## gitops-repo_repo: The short name of the repository (i.e. the part after the org/group name)
    gitops_repo_repo="turbo-gitops-01"
    
    ## gitops-cluster-config_banner_text: The text that will appear in the top banner in the cluster
    gitops-cluster-config_banner_text="Software Everywhere Turbonomic"
      ```

13. You will see that the `repo_type` and `repo_host` are set to GitHub you can change these to other Git Providers, like GitHub Enterprise or GitLab.
14. For the `repo_org` value set it to your default org name, or specific a custom org value. This is the organization where the GitOps Repository will be created in. Click on top right menu and select Your Profile to take you to your default organization.
15. Set the `repo_repo` value to a unique name that you will recognize as the place where the GitOps configuration is going to be placed before Turbonomic is installed into the cluster.
16. You can change the Banner text to something useful for your client project or demo.
17. Save the `terraform.tfvars` file
18. Navigate into the `/workspaces/current` folder
19. Navigate into the `200` folder and run the following commands

      ```
      cd 200-openshift-gitops
      terraform init
      terraform apply --auto-approve
      ………
      Apply complete! Resources: 78 added, 0 changed, 0 destroyed.

      ```

20. This will kick off the automation for setting up the GitOps Operator into your cluster.

21. You can check the progress by looking at two places, first look in your github repository. You will see the git repository has been created based on the name you have provided. The Turbonomic install will populate this with information to let OpenShift GitOps install the software. The second place is to look at the OpenShift console, Click Workloads->Pods and you will see the GitOps operator being installed.

22. Now that the GitOps is installed in the cluster, and we have bound the git repository to OpenShift GitOps operator. We are now ready to populate this with some Software configuration that cause OpenShift GitOps to install the software into the cluster. Navigate into the `250` folder and run the following commands, this will install Turbonomic into the cluster.

     ```
     cd 250-turbonomic-multicloud
     terraform init
     terraform apply --auto-approve
     ………
     Apply complete! Resources: 38 added, 0 changed, 0 destroyed.
     ```

23. Once the installation has finished you will see a message from Terraform defining the state of the environment.

24. You will see the first change as a purple banner describing what was installed 

25. The next step is to validate if everything has installed correctly. Open your git repository where your git ops configuration was defined.

26. Check if the payload folder has been created with the correct definitions for GitOps. Navigate to the `payload/2-services/namespace/turbonomic` folder and look at the content of the installation YAML files. You should see the Operator CR definitions
27. Final Step is to Open up Argo CD (OpenShift GitOps) check it is correctly configured, click on the Application menu 3x3 Icon on the header and select **Cluster Argo CD** menu item.

28. Complete the authorization with OpenShift, and, then narrow the filters by selecting the **turbonomic namespace**.

29. This will show you the GitOps dashboard of the software you have installed using GitOps techniques
30. Click on **turbonomic-turboinst** tile
31. You will see all the microservices that Turbonomic uses to install with their enablement state

### Setup Turbonomic after installation

Configuring Turbonomic after installation into your cluster. Now that the installation process is complete,  it is time to configure Turbonomic and load your downloaded license key.

Steps:

1. In the OpenShift console navigate to the **Networking->Routes** and change the project from to **turbonomic** you will see the route to launch dashboard for Turbonomic. Click on the Location URL to open Turbonomic
2. The first time you will launch the dashboard it will ask you to define an Administration password. Enter your new password and confirm it.
   > Don’t forget to store it in your password manager
3. Once the account has been created you will be greeted with the default screen.
4. Make sure you have downloaded the license key following the instructions in the pre-requisites section at the front of this document.
5. Click on Settings on left menu, then click on **License** icon, click **Import license**
6. Drag you license key into the drop area and you will get a screen stating it has been added
7. Now we need to point Turbonomic at an environment for it to monitor ,
8. Click on the **Add Targets** button.
9. Click on `Kubernetes-Turbonomic` then **Validate** button to complete the validation
10. Then click on the **On** icon at the top of the left menu to see a monitor view of Turbonomic

## Uninstalling & Troubleshooting

Please refer to the [Troubleshooting Guide](./TROUBLESHOOTING.md) for uninstallation instructions and instructions to correct common issues.

## Summary

This concludes the instructions for installing **Turbonomic** on AWS, Azure, and IBM Cloud

## How to Generate this repository from the source Bill of Materials.

This set of automation packages was generated using the open-source [`isacable`](https://github.com/cloud-native-toolkit/iascable) tool. This tool enables a [Bill of Material yaml](https://github.com/cloud-native-toolkit/automation-solutions/tree/main/boms/software/turbonomic) file to describe your software requirements. If you want up stream releases or versions you can use `iascable` to generate a new terraform module.

> The `iascable` tool is targeted for use by advanced SRE developers. It requires deep knowledge of how the modules plug together into a customized architecture. This repository is a fully tested output from that tool. This makes it ready to consume for projects.
