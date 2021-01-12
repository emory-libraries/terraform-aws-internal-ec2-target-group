locals {
    application_fqdn_list = split(".", var.application_fqdn)
    appended_fqdn_list = terraform.workspace == "prod" ? local.application_fqdn_list : formatlist("%s-${terraform.workspace}", local.application_fqdn_list)
    appended_fqdn = replace(var.application_fqdn, local.application_fqdn_list[var.application_fqdn_workspace_insertion_index], local.appended_fqdn_list[var.application_fqdn_workspace_insertion_index])
}