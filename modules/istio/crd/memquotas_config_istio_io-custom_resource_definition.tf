resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "memquotas_config_istio_io" {
  metadata {
    annotations = {
      "helm.sh/resource-policy" = "keep"
    }
    labels = {
      "release"  = "istio"
      "app"      = "mixer"
      "chart"    = "istio"
      "heritage" = "Tiller"
      "istio"    = "mixer-adapter"
      "package"  = "memquota"
    }
    name = "memquotas.config.istio.io"
  }
  spec {
    group = "config.istio.io"
    names {
      categories = [
        "istio-io",
        "policy-istio-io",
      ]
      kind     = "memquota"
      plural   = "memquotas"
      singular = "memquota"
    }
    scope   = "Namespaced"
    version = "v1alpha2"
  }
}