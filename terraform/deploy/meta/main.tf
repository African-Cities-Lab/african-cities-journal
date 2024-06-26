# organization
data "tfe_organization" "org" {
  name = var.tfc_org_name
}

# workspaces
resource "tfe_workspace" "prod" {
  name         = "${var.project_slug}-prod"
  organization = data.tfe_organization.org.name
  tag_names    = [var.project_slug]
  # execution_mode = "local"
}

resource "tfe_workspace" "base" {
  name         = "${var.project_slug}-base"
  organization = data.tfe_organization.org.name
  tag_names    = [var.project_slug]
  # execution_mode            = "local"
  remote_state_consumer_ids = [tfe_workspace.prod.id]
}

# tokens
# resource "tfe_organization_token" "token" {
#   organization = data.tfe_organization.org.name
# }

# variables
## base variable set
resource "tfe_variable_set" "base" {
  name         = "${var.project_slug} base variable set"
  description  = "variable set applied to the base workspace only"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "ssh_key_name" {
  key             = "ssh_key_name"
  value           = var.ssh_key_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "droplet_user" {
  key             = "droplet_user"
  value           = var.droplet_user
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "docker_compose_version" {
  key             = "docker_compose_version"
  value           = var.docker_compose_version
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "domain_name" {
  key             = "domain_name"
  value           = var.domain_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "do_project_name" {
  key             = "do_project_name"
  value           = var.do_project_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "do_project_description" {
  key             = "do_project_description"
  value           = var.do_project_description
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "gh_repo_name" {
  key             = "gh_repo_name"
  value           = var.gh_repo_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "tf_api_token" {
  key             = "tf_api_token"
  value           = var.tf_api_token
  sensitive       = true
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_workspace_variable_set" "base" {
  variable_set_id = tfe_variable_set.base.id
  workspace_id    = tfe_workspace.base.id
}

## app variable set
resource "tfe_variable_set" "app" {
  name         = "${var.project_slug} app variable set"
  description  = "variable set applied to the app workspaces (stage, prod)"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "tfc_org_name" {
  key             = "tfc_org_name"
  value           = var.tfc_org_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_variable" "tfc_base_workspace_name" {
  key             = "tfc_base_workspace_name"
  value           = tfe_workspace.base.name
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_variable" "droplet_prefix" {
  key             = "droplet_prefix"
  value           = var.droplet_prefix
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_variable" "droplet_image" {
  key             = "droplet_image"
  value           = var.droplet_image
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_variable" "droplet_region" {
  key             = "droplet_region"
  value           = var.droplet_region
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_workspace_variable_set" "app_prod" {
  variable_set_id = tfe_variable_set.app.id
  workspace_id    = tfe_workspace.prod.id
}

resource "tfe_variable" "droplet_size_prod" {
  key          = "droplet_size"
  value        = var.droplet_size_prod
  category     = "terraform"
  workspace_id = tfe_workspace.prod.id
}

## shared variable set
resource "tfe_variable_set" "shared" {
  name         = "${var.project_slug} shared variable set"
  description  = "variable set applied to all deploy workspaces"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "do_token" {
  key             = "do_token"
  value           = var.do_token
  sensitive       = true
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "gh_token" {
  key             = "gh_token"
  value           = var.gh_token
  sensitive       = true
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "gh_owner" {
  key             = "gh_owner"
  value           = var.gh_owner
  sensitive       = true
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_workspace_variable_set" "shared_base" {
  variable_set_id = tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.base.id
}

resource "tfe_workspace_variable_set" "shared_prod" {
  variable_set_id = tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.prod.id
}
