module "domains_infrastructure" {
  source                 = "git::https://github.com/DFE-Digital/terraform-modules.git//domains/infrastructure?ref=main" # Todo: change to stable
  hosted_zone            = var.hosted_zone
  deploy_default_records = var.deploy_default_records
}
