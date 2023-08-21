

variable "vpc_name" {
}


variable "kubernetes_cluster" {
}

variable "application" {
  description = "Name of Application you are deploying"
  default     = "CJS Dashboard"
}

variable "namespace" {
  default = "cjs-dashboard-production"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "HQ"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "cjs-dashboard"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "production"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "jeremy.collins@digital.justice.gov.uk"
}

variable "is_production" {
  default = "true"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "cjs-dashboard"
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials"
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the Github Terraform provider"
  default     = ""
}

variable "github_actions_secret_kube_namespace" {
  description = "The name of the github actions secret containing the kubernetes namespace name"
  default     = "KUBE_NAMESPACE_PROD"
}

variable "github_actions_secret_kube_cert" {
  description = "The name of the github actions secret containing the serviceaccount ca.crt"
  default     = "KUBE_CERT_PROD"
}

variable "github_actions_secret_kube_token" {
  description = "The name of the github actions secret containing the serviceaccount token"
  default     = "KUBE_TOKEN_PROD"
}

variable "github_actions_secret_kube_cluster" {
  description = "The name of the github actions secret containing the serviceaccount cluster"
  default     = "KUBE_CLUSTER_PROD"
}

variable "github_actions_secret_ecr_name" {
  description = "The name of the github actions secret containing the ECR name"
  default     = "ECR_NAME_PROD"
}

variable "github_actions_secret_ecr_url" {
  description = "The name of the github actions secret containing the ECR URL"
  default     = "ECR_URL_PROD"
}

variable "github_actions_secret_ecr_access_key" {
  description = "The name of the github actions secret containing the ECR AWS access key"
  default     = "ECR_AWS_ACCESS_KEY_ID_PROD"
}

variable "github_actions_secret_ecr_secret_key" {
  description = "The name of the github actions secret containing the ECR AWS secret key"
  default     = "ECR_AWS_SECRET_ACCESS_KEY_PROD"
}

variable "eks_cluster_name" {
  description = "The name of the eks cluster to retrieve the OIDC information"
}
