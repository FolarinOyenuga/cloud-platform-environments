/*
 * When using this module through the cloud-platform-environments, the following
 * variable is automatically supplied by the pipeline.
 */


variable "vpc_name" {
}

variable "namespace" {
  default = "contact-moj-staging"
}

variable "domain" {
  default = "staging.contact-moj.service.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}

variable "environment" {
  default = "staging"
}

variable "infrastructure_support" {
  default = "correspondence@digital.justice.gov.uk"
}
variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials"
  type        = string
  default     = "ministryofjustice"
}

variable "github_token" {
  type        = string
  description = "Required by the GitHub Terraform provider"
  default     = ""
}


variable "team_name" {
  default = "correspondence"
}

variable "business_unit" {
  default = "Central Digital"
}

variable "application" {
  default = "contact-moj"
}

