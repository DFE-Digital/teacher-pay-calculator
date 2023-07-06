variable "cluster" {}
variable "namespace" {}
variable "environment" {}
variable "azure_credentials_json" { default = null }
variable "azure_resource_prefix" {}
variable "config_short" {}
variable "service_name" {}
variable "service_short" {}
variable "docker_image_tag" {}
variable "external_url" { default = null }
variable "statuscake_contact_groups" { default = [] }
variable "enable_monitoring" { default = false }

locals {
  docker_repository = "ghcr.io/dfe-digital/teacher-pay-calculator"

  azure_credentials = try(jsondecode(var.azure_credentials_json), null)
}
