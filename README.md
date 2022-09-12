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

| Cloud Platform                                                                                                            | Automation and Documentation                                                                                                                                                                                      |   
|---------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [TechZone for IBMers and Partners](https://techzone.ibm.com/collection/turbonomic-automation-multicloud) | You can provision ARO, ROSA and ROKS through IBM TechZone. This is only supported for IBMers and IBM Partners                                                                                                     
| [IBM Cloud](https://cloud.ibm.com)                                                                                        | [IBM Cloud Quick Start](https://github.com/IBM/automation-ibmcloud-infra-openshift) </br> [IBM Cloud Standard](https://github.com/IBM/automation-ibmcloud-infra-openshift)                                        |  
| [AWS](https://aws.amazon.com/)                                                                                            | [AWS Quick Start](https://github.com/IBM/automation-aws-infra-openshift) </br> [AWS Standard](https://github.com/IBM/automation-aws-infra-openshift)                                                              |
| [Azure](https://portal.azure.com/#home)                                                                                   | [Azure Quick Start](https://github.com/IBM/automation-azure-infra-openshift) <br /> [Azure Standard](https://github.com/IBM/automation-azure-infra-openshift)                                                     |                                                                                             | 
| Bring You Own Infrastructure                                                                                              | You will need to setup GitOps and Storage details on the following steps                                                                                                                                        | 

### Getting Started

Within this repository you will find a set of Terraform template bundles that embody best practices for provisioning Turbonomic in multiple cloud environments. This `README.md` describes the SRE steps required to provision the Turbonomic software.

This suite of automation can be used for a Proof of Technology environment, or used as a foundation for production workloads with a fully working end-to-end cloud-native environment. The software installs using **GitOps** best practices with [**Red Hat Open Shift GitOps**](https://docs.openshift.com/container-platform/4.8/cicd/gitops/understanding-openshift-gitops.html)

## Turbonomic Architecture

The following reference architecture represents the logical view of how Turbonomic works after it is installed. After obtaining a license key you will need to register your data sources. They can range from other Kubernetes environment to VMWare and Virtual Machines.

![Reference Architecture](./turbonomic-arch.png)

## Deploying Turbonomic

The following instructions will help you install Turbonomic into AWS, Azure, and IBM Cloud OpenShift Kubernetes environment.

### Obtain a License Key

To use Turbonomic you are required to install a license key. For Proof of Concepts, IBM Partners and IBMers can obtain a license key using the steps provided below.

#### Partners

For Partners follow these steps:

1. For PoCs/PoTs, Partners can download a license key from [Partner World Software Catalog](https://www.ibm.com/partnerworld/program/benefits/software-access-catalog)
2. You can search the software catalog for **M07FSEN Turbonomic Application Resource Management On-Prem 8.6** for installation on Kubernetes. Once found, download the installation package. Once downloaded, unzip the archive. **Note:** This file is 12gb in size, 
3. Extract this download package to get the turbonomic license key This package contains license file for turbonomic, with a name similar to “TURBONOMIC-ARM.lic"
4. This file is covered by **Turbonomic ARM P/N are currently available under IBM PPA terms and conditions**

#### IBMers

For IBMers you can download a license key using these steps:

1. Go to [XL Leverage](https://w3-03.ibm.com/software/xl/download/ticket.wss)
2. Search with keyword: turbonomic
3. Select the package **M07FSEN Turbonomic Application Resource Management On-Prem 8.6** for installation on Kubernetes. Once found, download the installation package. Once downloaded, unzip the archive. **Note:** This file is 12gb in size,
4. Extract this download package to get the turbonomic license key This package contains license file for turbonomic, with a name similar to “TURBONOMIC-ARM.lic"
5. This file is covered by **Turbonomic ARM P/N are currently available under IBM PPA terms and conditions**

### Turbonomic for Multi Cloud

The Turbonomic automation is broken into several layers of automation. Each layer enables SRE activities to be optimized. This automation stack can be used stand-alone on an existing OpenShift cluster running on any cloud or on-premises infrastructure or in combination with provided infrastructure bundles.

| BOM ID | Name                                                        | Description                                                                                                                                                                                                                                          | Run Time |
|--------|-------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| 105    | [105 - Existing OpenShift](./105-existing-openshift)        | Logs into an existing openshift cluster and retrieves cluster configuration information.                                                                                                                                                             | 2 Min    |
| 200    | [200 - OpenShift Gitops](./200-openshift-gitops)            | Set up OpenShift GitOps infrastructure within the provided cluster and the GitOps repository that will hold the cluster configuration. By default, the automation will provision a GitOps repository on a Gitea instance running within the cluster. | 10 Min   |
| 250    | [250 - Turbonomic Multi Cloud](./250-turbonomic-multicloud) | Provision Turbonomic into Multi Cloud environment AWS, Azure and IBM Cloud supported                                                                                                                                                                 | 10 Min   |


> At this time the most reliable way of running this automation is with Terraform in your local machine either through a bootstrapped container image or with native tools installed. We provide a Container image that has all the common SRE tools installed. [CLI Tools Image,](https://quay.io/repository/ibmgaragecloud/cli-tools?tab=tags) [Source Code for CLI Tools](https://github.com/cloud-native-toolkit/image-cli-tools)

## Installation Steps

Before you start the installation please install the pre-req tools on your machine.

## Prerequisites

1. Have access to an IBM Cloud Account, Enterprise account is best for workload isolation but if you only have a Pay Go account this set of terraform can be run in that level of account.

2. At this time the most reliable way of running this automation is with Terraform in your local machine either through a bootstrapped docker image or Virtual Machine. We provide both a [container image](https://github.com/cloud-native-toolkit/image-cli-tools) and a virtual machine [cloud-init](https://github.com/cloud-native-toolkit/sre-utilities/blob/main/cloud-init/cli-tools.yaml) script that have all the common SRE tools installed.

We recommend using Docker Desktop if choosing the container image method, and Multipass if choosing the virtual machine method.   Detailed instructions for downloading and configuring both Docker Desktop and Multipass can be found in [RUNTIMES.md](./RUNTIMES.md)

### Installing Turbonomic

The installation process will use a standard GitOps repository that has been built using the Modules to support Turbonomic installation. The automation is consistent across three cloud environments AWS, Azure, and IBM Cloud.

### Setup

1. The first step is to clone the automation code to your local machine. Run this git command in your favorite command-line shell.

    ```
    git clone https://github.com/IBM/automation-turbonomic
    ```

2. Navigate into the automation-turbonomic folder using your command line.
   a.	The README.md has a comprehensive instructions on how to install this into other cloud environments than TechZone. This document focuses on getting it running in a TechZone requested environment.
3. Next you will need to set-up your credentials.properties file. This will enable secure access to your cluster. Copy **credentials.template** to **credentials.properties**.
    ```shell
    cp credentials.template credentials.properties
    ```
4. Provide values for the variables in **credentials.properties** (**Note:** `*.properties` has been added to **.gitignore** to ensure that the file containing the apikey cannot be checked into Git.)
    - **TF_VAR_server_url** - The server url of the existing OpenShift cluster where Turbonomic will be installed.
    - **TF_VAR_cluster_login_token** - The token used to log into the existing OpenShift cluster.
    - **TF_VAR_gitops_repo_host** - (Optional) The host for the git repository (e.g. github.com, bitbucket.org). Supported Git servers are GitHub, Github Enterprise, Gitlab, Bitbucket, Azure DevOps, and Gitea. If this value is left commented out, the automation will default to using Gitea.
    - **TF_VAR_gitops_repo_username** - (Optional) The username on git server host that will be used to provision and access the gitops repository. If the `gitops_repo_host` is blank this value will be ignored and the Gitea credentials will be used.
    - **TF_VAR_gitops_repo_token** - (Optional) The personal access token that will be used to authenticate to the git server to provision and access the gitops repository. (The user should have necessary access in the org to create the repository and the token should have `delete_repo` permission.) If the host is blank this value will be ignored and the Gitea credentials will be used.
    - **TF_VAR_gitops_repo_org** - (Optional) The organization/owner/group on the git server where the gitops repository will be provisioned/found. If not provided the org will default to the username.
    - **TF_VAR_gitops_repo_project** - (Optional) The project on the Azure DevOps server where the gitops repository will be provisioned/found. This value is only required for repositories on Azure DevOps.

5. We are now ready to start installing Turbonomic. Launch the automation runtime.
    - If using *Docker Desktop*, run `./launch.sh`. This will start a container image with the prompt opened in the `/terraform` directory.
    - If using *Multipass*, run `mutlipass shell cli-tools` to start the interactive shell, and cd into the `/automation/{template}` directory, where  `{template}` is the folder you've cloned this repo. Be sure to run `source credentials.properties` once in the shell.  
6. Run the `setup-workspace.sh` command to configure a workspace environment that will provision an instance of Turbonomic. Two arguments should be provided: `-p` for the platform (which can be `azure` | `aws` or `ibm`) and `-n` to supply a prefix name

    ```shell
    ./setup-workspace.sh -p ibm -n turbo01
    ```

7. Two different configuration files have been created: **turbonomic.tfvars** and **gitops.tfvars**. **turbonomic.tfvars** contains the variables specific to the Turbonomic install. **gitops.tfvars** contains the variables that define the gitops configuration. Inspect both of these files to see if there are any variables that should be changed. (The **setup-workspace.sh** script has generated these two files with default values and can be used without updates, if desired.)

### Apply

#### Run the entire automation stack automatically

From the **/workspace/current** directory, run the following:

```shell
./apply-all.sh
```

The script will run through each of the terraform layers in sequence to provision the entire infrastructure.

#### Run each of the Terraform layers manually

From the **/workspace/current** directory, change the directory into each of the layer subdirectories, in order, and run the following:

```shell
./apply.sh
```

### Validate

1. Log into the OpenShift console for the cluster.
2. You will see the first change as a purple banner describing what was installed.
3. The next step is to validate if everything has installed correctly. The link to the configured GitOps repository will be available from the application menu in the OpenShift console.
4. Check if the payload folder has been created with the correct definitions for GitOps. Navigate to the `payload/2-services/namespace/turbonomic` folder and look at the content of the installation YAML files. You should see the Operator CR definitions
5. The final Step is to Open up Argo CD (OpenShift GitOps) check it is correctly configured, click on the Application menu 3x3 Icon on the header and select **Cluster Argo CD** menu item.

6. Complete the authorization with OpenShift, and, then narrow the filters by selecting the **turbonomic namespace**.

7. This will show you the GitOps dashboard of the software you have installed using GitOps techniques
8. Click on **turbonomic-turboinst** tile
9. You will see all the microservices that Turbonomic uses to install with their enablement state

### Post-install Setup

Configure Turbonomic after installation into your cluster with your downloaded license key.

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

## References

### Getting OpenShift server url and token from OpenShift Console

The following steps can be used to retrieve the `server_url` and `cluster_login_token` values from the console of an existing OpenShift cluster for use in the automation:

1. Log into the OpenShift console.
2. Click on the top-right menu and select "Copy login command". On the subsequent page, click on "Display Token".
3. The api token is listed at the top of the page.
4. The server url is listed in the login command.

### Getting OpenShift server url and token from terminal

The following steps can be used to retrieve the `server_url` and `cluster_login_token` values of an existing OpenShift cluster from a command-line terminal for use in the automation:

1. Open a terminal that is logged into the cluster.
2. Print the server url by running:
    ```shell
    oc whoami --show-server
    ```
3. Print the login token:
    ```shell
    oc whoami --show-token
    ```

