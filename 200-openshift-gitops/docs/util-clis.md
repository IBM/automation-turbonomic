# CLI module

Module to download CLIs into local bin directory. This module is primarily intended to be used as a submodule within other modules. The CLIs currently supported are:

- jq (jq)
- yq v3 and v4 (yq)
- igc (igc)
- kubeseal (kubeseal)
- gh cli (gh)
- glab cli (glab)
- rosa cli (rosa)
- kustomize cli (kustomize)
- ibmcloud cli (ibmcloud)
- ibmcloud infrastructure plugin (ibmcloud-is)
- ibmcloud observe plugin (ibmcloud-ob)
- ibmcloud kubernetes service plugin (ibmcloud-ks)
- ibmcloud container registry plugin (ibmcloud-cr)
- universal git client (gitu)
- OpenShift Installer (openshift-install-4.x[.y])


The module outputs the bin directory for use by other modules.

**Note:** This module uses an external data source to setup the clis. External data sources have a limitation in terms of real-time feedback of progress. To increase the visibility of what the module is doing, the data source writes logs to `clis-debug.log` in the current working directory.

### Command-line tools

- curl

### Terraform providers

None

## Module dependencies

None

## Example usage

```hcl-terraform
module "clis" {
  source = "github.com/cloud-native-toolkit/terraform-util-clis.git"
}
```

