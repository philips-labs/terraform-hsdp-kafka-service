module "kafka-service" {
  source  = "philips-labs/kafka-service/hsdp"
  version = ">=0.0.1"
  cf_space_id = var.cf_space_id
}
  
