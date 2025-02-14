variable "team_name" {
  default = "family-justice"
}

variable "business_unit" {
  default = "HQ"
}

variable "environment" {
  default = "staging"
}

variable "is_production" {
  default = "false"
}

variable "infrastructure_support" {
  default = "crossjusticedelivery@digital.justice.gov.uk"
}

variable "application" {
  default = "Get help with child arrangements"
}

variable "namespace" {
  default = "fj-cait-staging"
}

variable "repo_name" {
  default = "pflr-cait"
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials"
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the Github Terraform provider"
  default     = ""
}

# The following variable is provided at runtime by the pipeline.

variable "vpc_name" {
}


variable "kubernetes_cluster" {
}
