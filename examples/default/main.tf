module "kafka" {
  source = "./modules/kafka"

  cf_space_id = var.cf_space_id
}
