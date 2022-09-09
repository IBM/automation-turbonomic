# ArgoCD Bootstrap module

Module that provisions the OpenShift CI/CD tools (ArgoCD, Tekton, and Kube Seal) in the target cluster and bootstraps the ArgoCD environment with a GitOps repository. This module assumes that a direct connection to the cluster is availble in order to deploy the services and configure the ArgoCD instance.

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - v15

### Terraform providers

None

## Module dependencies

This module makes use of the output from other modules:

- Cluster
    - github.com/cloud-native-toolkit/terraform-ibm-container-platform
    - github.com/cloud-native-toolkit/terraform-ibm-ocp-vpc
    - github.com/cloud-native-toolkit/terraform-k8s-ocp-cluster
    - github.com/cloud-native-toolkit/terraform-ocp-login
- OLM 
    - github.com/cloud-native-toolkit/terraform-k8s-olm
- GitOps 
    - github.com/cloud-native-toolkit/terraform-tools-gitops
- Sealed Secret Cert 
    - github.com/cloud-native-toolkit/terraform-util-sealed-secret-cert

## Example usage

[Refer the test cases for this module](test/stages/stage2-argocd-bootstrap.tf) 

```hcl-terraform
module "argocd-bootsrap" {
  source = "github.com/cloud-native-toolkit/terraform-tools-argocd-bootstrap.git"

  cluster_type        = module.dev_cluster.platform.type_code
  ingress_subdomain   = module.dev_cluster.platform.ingress
  cluster_config_file = module.dev_cluster.config_file_path
  olm_namespace       = module.dev_software_olm.olm_namespace
  operator_namespace  = module.dev_software_olm.target_namespace
  gitops_repo_url     = module.gitops.config_repo_url
  git_username        = module.gitops.config_username
  git_token           = module.gitops.config_token
  bootstrap_path      = module.gitops.bootstrap_path
  sealed_secret_cert  = module.cert.cert
  sealed_secret_private_key = module.cert.private_key
  create_webhook      = true
}
```

