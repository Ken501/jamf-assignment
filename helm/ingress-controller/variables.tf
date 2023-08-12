// Common Variables

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access key"
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret key"
  type = string
}

variable "AWS_REGION" {
  description = "AWS preferred region"
  type = string
}

variable "app_name" {
  description = "Application name"
  type = string
}

variable "environment" {
  description = "Application lifecycle stage"
  type = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

// Ingress Controller variables

variable "ingress_controller_version" {
  description = "AWS Ingress controller version"
  type = string
  default = "1.4.1"
}
