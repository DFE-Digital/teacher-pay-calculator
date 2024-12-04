CONFIG=development
ENVIRONMENT=development
CONFIG_SHORT=dv
AZ_SUBSCRIPTION=s189-teacher-services-cloud-test
AZURE_RESOURCE_PREFIX=s189t01
KV_PURGE_PROTECTION=false
RESOURCE_GROUP_NAME=${AZURE_RESOURCE_PREFIX}-${SERVICE_SHORT}-${CONFIG_SHORT}-rg
KEYVAULT_NAMES='("${AZURE_RESOURCE_PREFIX}-${SERVICE_SHORT}-${CONFIG_SHORT}-app-kv", "${AZURE_RESOURCE_PREFIX}-${SERVICE_SHORT}-${CONFIG_SHORT}-inf-kv")'
STORAGE_ACCOUNT_NAME=${AZURE_RESOURCE_PREFIX}${SERVICE_SHORT}tfstate${CONFIG_SHORT}sa
TERRAFORM_MODULES_TAG=testing
