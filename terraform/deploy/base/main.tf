module "base" {
  source = "github.com/African-Cities-Lab/african-cities-journal//terraform/modules/base?ref=develop"

  ssh_key_name           = var.ssh_key_name
  droplet_user           = var.droplet_user
  docker_compose_version = var.docker_compose_version
  do_project_name        = var.do_project_name
  do_project_description = var.do_project_description
  gh_repo_name           = var.gh_repo_name
  tf_api_token           = var.tf_api_token
}
