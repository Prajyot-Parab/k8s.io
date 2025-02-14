output "kubeconfig" {
  depends_on = [null_resource.kubetest2]
  value      = "${path.cwd}/k8s-power/kubeconfig"
}
