resource "helm_release" "cbrothers-app" {
  name       = "cbrothers-app"
  chart      = "${path.module}/charts/app"
  version    = var.chart_version

  set {
    name  = "environment"
    value = "production"
    type  = "string"
  }

  set {
    name  = "image.tag"
    value = var.app_version
    type  = "string"
  }
}
