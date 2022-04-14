# Terraform Storage Class Module

![Verify and release module](https://github.com/cloud-native-toolkit/terraform-gitops-ocp-storageclass/workflows/Verify%20and%20release%20module/badge.svg)


This module will create a k8s StorageClass within an OCP cluster via gitops.  
The variable `parameter_list` is optional, see example below on how to create the object if using parameters in the class.  If not using parameters in the class, then this should look like `parameter_list=[]`

## Supported platforms

- OCP 4.6+

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v12
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)


## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git


## Example usage

```hcl-terraform
module "storageclass" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-ocp-storageclass"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  
  name="ibmc-vpc-block-10iops-tier-test"
  provisioner_name="vpc.block.csi.ibm.io"
 
  parameter_list=[{key = "classVersion",value = "1"},{key = "csi.storage.k8s.io/fstype", value = "ext4"}, {key="encrypted",value="false"},{key="profile",value="10iops-tier"},{key="sizeRange",value="[10-2000]GiB]"}]

}
```

