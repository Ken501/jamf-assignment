module "eks" {
    source = "../modules/eks"
    
    kubernetes_version = var.kubernetes_version
    AWS_REGION         = var.AWS_REGION
    app_name           = var.app_name
    environment        = var.environment
    key_name           = var.key_name
    owner              = var.owner
    vpc_id             = "${module.global-vars.vpc_id}"
    allowed_ips        = ["${module.global-vars.kmadmin_public_ips[0]}"]
    subnets            = ["${module.global-vars.subnet_id_map["public1"]}", "${module.global-vars.subnet_id_map["public2"]}"]
    resource_tags      = var.resource_tags

}
