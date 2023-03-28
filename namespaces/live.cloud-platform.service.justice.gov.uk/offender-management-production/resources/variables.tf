/*
 * When using this module through the cloud-platform-environments, the following
 * variable is automatically supplied by the pipeline.
 *
 */
variable "vpc_name" {
}

variable "environment-name" {
  default = "production"
}

variable "team_name" {
  default = "offender-management"
}

variable "is_production" {
  default = "true"
}

variable "namespace" {
  default = "offender-management-production"
}

variable "infrastructure_support" {
  default = "omic@digital.justice.gov.uk"
}

variable "business_unit" {
  default = "HMPPS"
}
