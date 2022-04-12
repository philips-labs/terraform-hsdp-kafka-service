variable "cf_environment" {
  type = string
}

variable "cf_username" {
  type        = string
  description = "Cloud foundry username"
}

variable "cf_password" {
  type        = string
  description = "Cloud foundry password"
}

variable "cf_api" {
  type        = string
  description = "Cloud foundry API endpoint (region specific)"
}

variable "cf_org" {
  type        = string
  description = "Cloud foundry ORG name"
}

variable "cf_space_id" {
  type        = string
  description = "Cloud foundry space to provision Kafdrop in"
}

variable "cf_region" {
  type        = string
  default     = "eu-west"
  description = "Cloud foundry region"
}