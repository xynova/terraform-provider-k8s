resource "k8s_rbac_authorization_k8s_io_v1beta1_cluster_role" "cert-manager-controller-clusterissuers" {
  metadata {
    labels = {
      "app"                          = "cert-manager"
      "app.kubernetes.io/instance"   = "cert-manager"
      "app.kubernetes.io/managed-by" = "Tiller"
      "app.kubernetes.io/name"       = "cert-manager"
      "helm.sh/chart"                = "cert-manager-v0.9.0"
    }
    name = "cert-manager-controller-clusterissuers"
  }

  rules {
    api_groups = [
      "certmanager.k8s.io",
    ]
    resources = [
      "clusterissuers",
      "clusterissuers/status",
    ]
    verbs = [
      "update",
    ]
  }
  rules {
    api_groups = [
      "certmanager.k8s.io",
    ]
    resources = [
      "clusterissuers",
    ]
    verbs = [
      "get",
      "list",
      "watch",
    ]
  }
  rules {
    api_groups = [
      "",
    ]
    resources = [
      "secrets",
    ]
    verbs = [
      "get",
      "list",
      "watch",
      "create",
      "update",
      "delete",
    ]
  }
  rules {
    api_groups = [
      "",
    ]
    resources = [
      "events",
    ]
    verbs = [
      "create",
      "patch",
    ]
  }
}