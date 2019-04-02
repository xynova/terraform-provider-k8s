resource "k8s_apiextensions_k8s_io_v1beta1_custom_resource_definition" "httpapispecs_config_istio_io" {
  metadata {
    annotations = {
      "helm.sh/resource-policy" = "keep"
    }
    labels = {
      "release"  = "istio"
      "app"      = "istio-mixer"
      "chart"    = "istio"
      "heritage" = "Tiller"
    }
    name = "httpapispecs.config.istio.io"
  }
  spec {
    group = "config.istio.io"
    names {
      categories = [
        "istio-io",
        "apim-istio-io",
      ]
      kind     = "HTTPAPISpec"
      plural   = "httpapispecs"
      singular = "httpapispec"
    }
    scope   = "Namespaced"
    version = "v1alpha2"
  }
}