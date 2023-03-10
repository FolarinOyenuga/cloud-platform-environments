variable "application" {
  default = "court-case-service"
}

variable "namespace" {
  default = "court-probation-dev"
}

variable "business_unit" {
  default = "HMPPS"
}

variable "team_name" {
  default = "probation-in-court-team"
}

variable "environment-name" {
  default = "development"
}

variable "infrastructure_support" {
  default = "Probation in Court Team: probation-in-court-team@digital.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}

variable "rds-family" {
  default = "postgres11"
}

variable "db_engine_version" {
  default = "11"
}

variable "number_cache_clusters" {
  default = "2"
}

variable "ap-stack-court-case" {
  default = "hmpps-court-case-dev"
}
