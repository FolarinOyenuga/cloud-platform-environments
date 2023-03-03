################################################################################
# S3 Bucket for file uploads
#################################################################################

module "alee-list-poc-s3" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.8.0"

  team_name              = var.team_name
  business-unit          = var.business_unit
  application            = var.application
  is-production          = var.is_production
  environment-name       = var.environment
  infrastructure-support = var.infrastructure_support
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "alee-list-poc-s3" {
  metadata {
    name      = "alee-list-poc-s3-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.alee-list-poc-s3.access_key_id
    secret_access_key = module.alee-list-poc-s3.secret_access_key
    bucket_arn        = module.alee-list-poc-s3.bucket_arn
    bucket_name       = module.alee-list-poc-s3.bucket_name
  }
}

