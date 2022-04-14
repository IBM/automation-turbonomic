variable "turbo_namespace_name" {
  type = string
  description = "The value that should be used for the namespace"
  default = "turbonomic"
}
variable "turbo_namespace_ci" {
  type = bool
  description = "Flag indicating that this namespace will be used for development (e.g. configmaps and secrets)"
  default = false
}
variable "turbo_namespace_create_operator_group" {
  type = bool
  description = "Flag indicating that an operator group should be created in the namespace"
  default = true
}
variable "turbo_namespace_argocd_namespace" {
  type = string
  description = "The namespace where argocd has been deployed"
  default = "openshift-gitops"
}
variable "gitops_repo_host" {
  type = string
  description = "The host for the git repository."
}
variable "gitops_repo_type" {
  type = string
  description = "The type of the hosted git repository (github or gitlab)."
}
variable "gitops_repo_org" {
  type = string
  description = "The org/group where the git repository exists/will be provisioned."
}
variable "gitops_repo_repo" {
  type = string
  description = "The short name of the repository (i.e. the part after the org/group name)"
}
variable "gitops_repo_branch" {
  type = string
  description = "The name of the branch that will be used. If the repo already exists (provision=false) then it is assumed this branch already exists as well"
  default = "main"
}
variable "gitops_repo_username" {
  type = string
  description = "The username of the user with access to the repository"
}
variable "gitops_repo_token" {
  type = string
  description = "The personal access token used to access the repository"
}
variable "gitops_repo_public" {
  type = bool
  description = "Flag indicating that the repo should be public or private"
  default = false
}
variable "gitops_repo_gitops_namespace" {
  type = string
  description = "The namespace where ArgoCD is running in the cluster"
  default = "openshift-gitops"
}
variable "gitops_repo_server_name" {
  type = string
  description = "The name of the cluster that will be configured via gitops. This is used to separate the config by cluster"
  default = "default"
}
variable "gitops_repo_sealed_secrets_cert" {
  type = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default = ""
}
variable "gitops_repo_strict" {
  type = bool
  description = "Flag indicating that an error should be thrown if the repo already exists"
  default = false
}
variable "storage_name" {
  type = string
  description = "The name of the storage class to create"
  default = "ibmc-vpc-block-mzr"
}
variable "storage_provisioner_name" {
  type = string
  description = "The name of the storage provisioner"
  default = "vpc.block.csi.ibm.io"
}
variable "storage_vol_binding_mode" {
  type = string
  description = "Volume binding mode for the storage class"
  default = "WaitForFirstConsumer"
}
variable "storage_isdefault" {
  type = string
  description = "Set to default storage class"
  default = "false"
}
variable "storage_allow_expansion" {
  type = string
  description = "Allow expansion of the volume"
  default = "true"
}
variable "storage_reclaim_policy" {
  type = string
  description = "Reclaim policy for the storage class"
  default = "Delete"
}
variable "storage_parameter_list" {
  type = string
  description = "optional parameters when defining the class, see ReadMe for sample syntax"
  default = "[{\"key\":\"classVersion\",\"value\":\"1\"},{\"key\":\"csi.storage.k8s.io/fstype\",\"value\":\"ext4\"},{\"key\":\"encrypted\",\"value\":\"false\"},{\"key\":\"profile\",\"value\":\"10iops-tier\"},{\"key\":\"sizeRange\",\"value\":\"[10-2000]GiB]\"}]"
}
