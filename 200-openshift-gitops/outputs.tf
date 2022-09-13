output "gitops_host" {
  value = module.gitops_repo.config_host
}
output "gitops_org" {
  value = module.gitops_repo.config_org
}
output "gitops_name" {
  value = module.gitops_repo.config_name
}
output "gitops_project" {
  value = module.gitops_repo.config_project
}
output "gitops_username" {
  value = module.gitops_repo.config_username
}
output "gitops_token" {
  value = module.gitops_repo.config_token
  sensitive = true
}
