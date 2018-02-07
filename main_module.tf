# Deploys common resources like availability sets, resource group, network etc.
module "common_resources" {
    source = "./common_resources"
}

# Deploys frontend resources i.e. External LB with two external nginx VMs.
module "frontend_deploy" {
    source                             = "./ext-lb-with-ext-nginx"
    external_nginx_availability_set    = "${module.common_resources.ext_nginx_av_set}"
    resource_group                     = "${module.common_resources.res_grp}"
    location                           = "${module.common_resources.loc}"
    ext_nginx_subnet_id                = "${module.common_resources.az_ext_nginx_id}"
    external_nginx_availability_set_id = "${module.common_resources.ext_nginx_av_set_id}"
}

# Deploys two app VMs.
module "app_deploy" {
    source                             = "./app"
    app_availability_set               = "${module.common_resources.app_av_set}"
    resource_group                     = "${module.common_resources.res_grp}"
    location                           = "${module.common_resources.loc}"
    app_subnet_id                      = "${module.common_resources.az_app_subnet_id}"
    app_availability_set_id            = "${module.common_resources.app_av_set_id}"
}

# Deploys two db VMs.
module "db_deploy" {
    source                             = "./db"
    db_availability_set               = "${module.common_resources.db_av_set}"
    resource_group                     = "${module.common_resources.res_grp}"
    location                           = "${module.common_resources.loc}"
    db_subnet_id                      = "${module.common_resources.az_db_subnet_id}"
    db_availability_set_id            = "${module.common_resources.db_av_set_id}"
}
