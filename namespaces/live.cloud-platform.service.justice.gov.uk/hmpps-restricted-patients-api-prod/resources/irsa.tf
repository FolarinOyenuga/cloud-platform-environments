module "hmpps-restricted-patients-irsa" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.1.0"

  eks_cluster_name = var.eks_cluster_name
  namespace        = var.namespace
  service_account  = "${var.application}-${var.environment-name}"
  role_policy_arns = [
    data.aws_ssm_parameter.domain-events-sns-topic.value,
    data.aws_ssm_parameter.domain-events-rp-queue.value,
    data.aws_ssm_parameter.domain-events-rp-dql-queue.value,
    data.aws_ssm_parameter.offender-events-rp-queue.value,
    data.aws_ssm_parameter.offender-events-rp-dlq-queue.value
  ]
}

data "aws_ssm_parameter" "domain-events-sns-topic" {
  name = "/hmpps-domain-events-prod/sns/cloud-platform-Digital-Prison-Services-97e6567cf80881a8a52290ff2c269b08/irsa-policy-arn"
}

data "aws_ssm_parameter" "domain-events-rp-queue" {
  name = "/hmpps-domain-events-prod/sqs/Digital-Prison-Services-prod-rp_queue_for_domain_events/irsa-policy-arn"
}

data "aws_ssm_parameter" "domain-events-rp-dql-queue" {
  name = "/hmpps-domain-events-prod/sqs/Digital-Prison-Services-prod-rp_queue_for_domain_events_dl/irsa-policy-arn"
}

data "aws_ssm_parameter" "offender-events-rp-queue" {
  name = "/offender-events-prod/sqs/Digital-Prison-Services-prod-restricted_patients_queue/irsa-policy-arn"
}

data "aws_ssm_parameter" "offender-events-rp-dlq-queue" {
  name = "/offender-events-prod/sqs/Digital-Prison-Services-prod-restricted_patients_queue_dl/irsa-policy-arn"
}
