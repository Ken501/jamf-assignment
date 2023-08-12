// Global variables module

module "global-vars" {
  source      = "../../modules/global-vars"
  environment = "${var.environment}"
  AWS_REGION  = "${var.AWS_REGION}"
}