resource "k8s_config_istio_io_v1alpha2_rule" "tcpkubeattrgenrulerule" {
  metadata {
    labels = {
      "heritage" = "Tiller"
      "release"  = "istio"
      "app"      = "mixer"
      "chart"    = "mixer"
    }
    name      = "tcpkubeattrgenrulerule"
    namespace = "${var.namespace}"
  }
  spec = <<-JSON
    {
      "actions": [
        {
          "handler": "kubernetesenv",
          "instances": [
            "attributes.kubernetes"
          ]
        }
      ],
      "match": "context.protocol == \"tcp\""
    }
    JSON
}