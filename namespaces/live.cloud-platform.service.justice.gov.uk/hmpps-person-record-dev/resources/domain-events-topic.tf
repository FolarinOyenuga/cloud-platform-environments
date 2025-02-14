resource "kubernetes_secret" "hmpps_domain_events_topic" {
  metadata {
    name      = "hmpps-domain-events-topic"
    namespace = var.namespace
  }

  data = {
    topic_arn = data.aws_ssm_parameter.hmpps-domain-events-topic-arn.value
  }
}

