// Common Variables

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access key"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret key"
  type        = string
}

variable "AWS_REGION" {
  description = "AWS preferred region"
  type        = string
}

variable "environment" {
  description = "Application lifecycle stage"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

variable "resource_tags" {
  description = "Tags used to identify the project and other details"
  default     = {
    purpose = "jamf-assignment"
  }
  type        = map(string)
}
