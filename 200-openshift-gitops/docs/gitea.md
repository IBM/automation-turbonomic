# Gitea terraform module

![Latest release](https://img.shields.io/github/v/release/ibm-garage-cloud/terraform-tools-gitea?sort=semver) ![Verify and release module](https://github.com/ibm-garage-cloud/terraform-tools-gitea/workflows/Verify%20and%20release%20module/badge.svg)

Installs Gitea in an Openshift 4.x cluster via the [Red Hat GPTE operator](https://github.com/redhat-gpte-devopsautomation/gitea-operator). This will **NOT** install Gitea in a vanilla Kubernetes cluster.

## Software dependencies

The module depends on the following software components:

- terraform v12
- kubectl

## Module dependencies

- Cluster
- OLM

## Example usage

```hcl-terraform
module "dev_tools_gitea" {
  source = "github.com/ibm-garage-cloud/terraform-tools-gitea.git?ref=v1.0.0"

  cluster_config_file = module.dev_cluster.config_file_path
  cluster_type        = module.dev_cluster.type
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  instance_namespace  = module.dev_cluster_namespaces.tools_namespace_name
  name                = "gitea"
}
```
