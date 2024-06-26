# data "tfe_outputs" "base" {
#   organization = var.tfc_org_name
#   workspace    = var.tfc_base_workspace_name
# }

data "terraform_remote_state" "base" {
  backend = "remote"
  config = {
    organization = var.tfc_org_name
    workspaces = {
      name = var.tfc_base_workspace_name
    }
  }
}

module "app" {
  source = "github.com/African-Cities-Lab/african-cities-journal//terraform/modules/app?ref=develop"
  env    = "prod"

  droplet_prefix = var.droplet_prefix
  droplet_image  = var.droplet_image
  droplet_region = var.droplet_region
  droplet_size   = var.droplet_size
  a_record_name  = "@"
  create_cname   = true

  # do_ssh_key_id     = data.tfe_outputs.base.values.do_ssh_key_id
  # droplet_user_data = data.tfe_outputs.base.values.droplet_user_data
  # do_project_id     = data.tfe_outputs.base.values.do_project_id
  # gh_repo_name      = data.tfe_outputs.base.values.gh_repo_name
  do_ssh_key_id     = data.terraform_remote_state.base.outputs.do_ssh_key_id
  droplet_user_data = data.terraform_remote_state.base.outputs.droplet_user_data
  do_project_id     = data.terraform_remote_state.base.outputs.do_project_id
  domain_name       = data.terraform_remote_state.base.outputs.domain_name
  gh_repo_name      = data.terraform_remote_state.base.outputs.gh_repo_name
}
