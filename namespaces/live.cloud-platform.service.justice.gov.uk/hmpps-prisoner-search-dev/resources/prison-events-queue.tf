resource "aws_sns_topic_subscription" "hmpps_prisoner_search_offender_subscription" {
  provider  = aws.london
  topic_arn = data.aws_ssm_parameter.offender-events-topic-arn.value
  protocol  = "sqs"
  endpoint  = module.hmpps_prisoner_search_offender_queue.sqs_arn
  filter_policy = jsonencode({
    eventType = [
      "ALERT-INSERTED",
      "ALERT-UPDATED",
      "ASSESSMENT-CHANGED",
      "ASSESSMENT-UPDATED",
      "BED_ASSIGNMENT_HISTORY-INSERTED",
      "BOOKING_NUMBER-CHANGED",
      "CONFIRMED_RELEASE_DATE-CHANGED",
      "COURT_SENTENCE-CHANGED",
      "EXTERNAL_MOVEMENT-CHANGED",
      "EXTERNAL_MOVEMENT_RECORD-INSERTED",
      "IMPRISONMENT_STATUS-CHANGED",
      "KEY_DATE_ADJUSTMENT_DELETED",
      "KEY_DATE_ADJUSTMENT_UPSERTED",
      "OFFENDER-DELETED",
      "OFFENDER-INSERTED",
      "OFFENDER-UPDATED",
      "OFFENDER_ALIAS-CHANGED",
      "OFFENDER_BOOKING-CHANGED",
      "OFFENDER_BOOKING-REASSIGNED",
      "OFFENDER_CHARGES-UPDATED",
      "OFFENDER_DETAILS-CHANGED",
      "OFFENDER_IDENTIFIER-UPDATED",
      "OFFENDER_PHYSICAL_DETAILS-CHANGED",
      "OFFENDER_PROFILE_DETAILS-INSERTED",
      "OFFENDER_PROFILE_DETAILS-UPDATED",
      "SENTENCE_ADJUSTMENT_DELETED",
      "SENTENCE_ADJUSTMENT_UPSERTED",
      "SENTENCE_DATES-CHANGED",
      "SENTENCING-CHANGED"
    ]
  })
}

module "hmpps_prisoner_search_offender_queue" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=5.0.0"

  # Queue configuration
  sqs_name                  = "hmpps_prisoner_search_offender_queue"
  encrypt_sqs_kms           = "true"
  message_retention_seconds = 1209600

  redrive_policy = jsonencode({
    deadLetterTargetArn = module.hmpps_prisoner_search_offender_dlq.sqs_arn
    maxReceiveCount     = 3
  })

  # Tags
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  team_name              = var.team_name # also used for naming the queue
  namespace              = var.namespace
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support

  providers = {
    aws = aws.london
  }
}

resource "aws_sqs_queue_policy" "hmpps_prisoner_search_offender_queue_policy" {
  queue_url = module.hmpps_prisoner_search_offender_queue.sqs_id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Id": "${module.hmpps_prisoner_search_offender_queue.sqs_arn}/SQSDefaultPolicy",
    "Statement":
      [
        {
          "Effect": "Allow",
          "Principal": {"AWS": "*"},
          "Resource": "${module.hmpps_prisoner_search_offender_queue.sqs_arn}",
          "Action": "SQS:SendMessage",
          "Condition":
                      {
                        "ArnEquals":
                          {
                            "aws:SourceArn": "${data.aws_ssm_parameter.offender-events-topic-arn.value}"
                          }
                        }
        }
      ]
  }

EOF

}

module "hmpps_prisoner_search_offender_dlq" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-sqs?ref=5.0.0"

  # Queue configuration
  sqs_name        = "hmpps_prisoner_search_offender_dlq"
  encrypt_sqs_kms = "true"

  # Tags
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  team_name              = var.team_name # also used for naming the queue
  namespace              = var.namespace
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "hmpps_prisoner_search_offender_queue" {
  metadata {
    name      = "sqs-offender-event-secret"
    namespace = var.namespace
  }

  data = {
    sqs_queue_url  = module.hmpps_prisoner_search_offender_queue.sqs_id
    sqs_queue_arn  = module.hmpps_prisoner_search_offender_queue.sqs_arn
    sqs_queue_name = module.hmpps_prisoner_search_offender_queue.sqs_name
  }
}

resource "kubernetes_secret" "hmpps_prisoner_search_offender_dlq" {
  metadata {
    name      = "sqs-offender-event-dlq-secret"
    namespace = var.namespace
  }

  data = {
    sqs_queue_url  = module.hmpps_prisoner_search_offender_dlq.sqs_id
    sqs_queue_arn  = module.hmpps_prisoner_search_offender_dlq.sqs_arn
    sqs_queue_name = module.hmpps_prisoner_search_offender_dlq.sqs_name
  }
}

data "aws_ssm_parameter" "offender-events-topic-arn" {
  name = "/offender-events-dev/topic-arn"
}
