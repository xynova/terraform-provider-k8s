resource "k8s_core_v1_service_account" "nginx-ingress-serviceaccount" {
  metadata {
    labels    = "${local.labels}"
    name      = "${var.name}"
    namespace = "${var.namespace}"
  }
}
