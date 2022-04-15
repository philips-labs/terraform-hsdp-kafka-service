locals {
  postfix            = var.name_postfix != "" ? var.name_postfix : random_pet.name.id
}

resource "random_pet" "name" {
  #length = 2 is default
}

resource "cloudfoundry_service_instance" "kafka" {
  name  = "tf-kafka-${local.postfix}"
  space = var.cf_space_id
  //noinspection HILUnresolvedReference
  service_plan                   = data.cloudfoundry_service.kafka.service_plans[var.service_plan]
}

resource "cloudfoundry_service_key" "key" {
  name             = "tf-key-${local.postfix}"
  service_instance = cloudfoundry_service_instance.kafka.id
}

resource "cloudfoundry_app" "exporter" {
  name         = "tf-kafka-exporter-${local.postfix}"
  space        = var.cf_space_id
  docker_image = var.exporter_image
  disk_quota   = var.exporter_disk_quota
  memory       = var.exporter_memory
  docker_credentials = {
    username = var.docker_username
    password = var.docker_password
  }

  command = "kafka_exporter --sasl.enabled --kafka.server=${cloudfoundry_service_key.key.credentials.uri} --sasl.username=${cloudfoundry_service_key.key.credentials.username} --sasl.password=${cloudfoundry_service_key.key.credentials.password} --sasl.mechanism=plain --tls.enabled --tls.insecure-skip-tls-verify --log.enable-sarama"
  
  environment = merge({}, var.exporter_environment)

  //noinspection HCLUnknownBlockType
  routes {
    route = cloudfoundry_route.exporter.id
  }
  labels = {
    "variant.tva/exporter" = true,
  }
  annotations = {
    "prometheus.exporter.type" = "kafka_exporter"
    "prometheus.exporter.port" = "9308"
    "prometheus.exporter.path" = "/metrics"
  }
}

resource "cloudfoundry_route" "exporter" {
  domain   = data.cloudfoundry_domain.apps_internal_domain.id
  space    = var.cf_space_id
  hostname = "tf-kafka-exporter-${local.postfix}"
}