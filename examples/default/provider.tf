provider "hsdp" {
  region      = var.cf_region
  environment = var.cf_environment
  debug_log   = "kafka.log"
}

provider "cloudfoundry" {
  api_url  = var.cf_api
  user     = var.cf_username
  password = var.cf_password

}