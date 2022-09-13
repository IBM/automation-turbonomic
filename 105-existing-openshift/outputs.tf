output "cluster_server_url" {
  value = module.cluster.server_url
}

output "cluster_username" {
  value = module.cluster.username
}

output "cluster_password" {
  value = module.cluster.password
  sensitive = true
}

output "cluster_token" {
  value = module.cluster.token
  sensitive = true
}

output "cluster_ingress" {
  value = module.cluster.platform.ingress
  sensitive = true
}

output "kubeconfig" {
  value = module.cluster.platform.kubeconfig
  sensitive = true
}
