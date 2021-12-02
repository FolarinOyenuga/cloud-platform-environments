resource "kubernetes_secret" "hmpps-tier" {
  metadata {
    name      = "hmpps-domain-events-topic-hmpps-tier"
    namespace = var.namespace
    # Remove when namespace has been migrated
    # name      = "hmpps-domain-events-topic"
    # namespace = "hmpps-tier-preprod"
  }

  data = {
    access_key_id     = module.hmpps-domain-events.access_key_id
    secret_access_key = module.hmpps-domain-events.secret_access_key
    topic_arn         = module.hmpps-domain-events.topic_arn
  }
}
