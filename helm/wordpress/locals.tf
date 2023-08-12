// Local Variables

locals {

  common_tags = {
    application       = "${var.app_name}"
    environment       = "${var.environment}"
    region            = "${var.AWS_REGION}"
    deployment_method = "auto"
    owner             = "${var.owner}"
  }

  listen_ports = "'[{"HTTP": 80}, {"HTTPS": 443}]'"

}
