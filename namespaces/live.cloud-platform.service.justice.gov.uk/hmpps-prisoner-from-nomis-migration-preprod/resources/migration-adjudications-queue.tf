module "migration_adjudications_queue" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"

  environment-name           = var.environment_name
  team_name                  = var.team_name
  infrastructure-support     = var.infrastructure_support
  application                = var.application
  sqs_name                   = "migration_adjudications_queue"
  encrypt_sqs_kms            = "true"
  message_retention_seconds  = 345600
  visibility_timeout_seconds = 120
  namespace                  = var.namespace


  redrive_policy = <<EOF
  {
    "deadLetterTargetArn": "${module.migration_adjudications_dead_letter_queue.sqs_arn}","maxReceiveCount": 3
  }

EOF
}

module "migration_adjudications_dead_letter_queue" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=4.11.0"

  environment-name       = var.environment_name
  team_name              = var.team_name
  infrastructure-support = var.infrastructure_support
  application            = var.application
  sqs_name               = "migration_adjudications_dlq"
  encrypt_sqs_kms        = "true"
  namespace              = var.namespace
}

resource "kubernetes_secret" "migration_adjudications_queue" {
  metadata {
    name      = "sqs-migration-adjudications-queue"
    namespace = var.namespace
  }

  data = {
    sqs_id   = module.migration_adjudications_queue.sqs_id
    sqs_arn  = module.migration_adjudications_queue.sqs_arn
    sqs_name = module.migration_adjudications_queue.sqs_name
  }
}

resource "kubernetes_secret" "migration_adjudications_dead_letter_queue" {
  metadata {
    name      = "sqs-migration-adjudications-dlq"
    namespace = var.namespace
  }

  data = {
    sqs_id   = module.migration_adjudications_dead_letter_queue.sqs_id
    sqs_arn  = module.migration_adjudications_dead_letter_queue.sqs_arn
    sqs_name = module.migration_adjudications_dead_letter_queue.sqs_name
  }
}
