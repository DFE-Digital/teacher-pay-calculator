variable "cluster" {}
variable "namespace" {}
variable "environment" {}
variable "azure_credentials_json" { default = null }
variable "azure_resource_prefix" {}
variable "config_short" {}
variable "service_name" {}
variable "service_short" {}
variable "docker_image_tag" {}
variable "replicas" { default = 1 }
variable "external_url" { default = null }
variable "statuscake_contact_groups" { default = [] }
variable "enable_monitoring" { default = false }

variable "run_as_non_root" {
  type        = bool
  default     = true
  description = "Whether to enforce that containers must run as non-root user"
}

variable "enable_logit" {
  type        = bool
  default     = true
  description = "A boolean to indicate whether to enable sending container logs to logit.io"
  nullable    = false
}

locals {
  docker_repository = "ghcr.io/dfe-digital/teacher-pay-calculator"

  azure_credentials = try(jsondecode(var.azure_credentials_json), null)
}
