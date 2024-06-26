variable "env" {
  description = "Environment of the app, e.g., staging, production."
  type        = string
}

variable "droplet_prefix" {
  description = "The prefix name of the `digitalocean_droplet`."
  type        = string
}

variable "droplet_image" {
  description = "Image of the `digitalocean_droplet`."
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "droplet_region" {
  description = "Region of the `digitalocean_droplet`."
  type        = string
  default     = "fra1"
}

variable "droplet_size" {
  description = "Size of the `digitalocean_droplet`."
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "do_ssh_key_id" {
  description = "ID of the `digitalocean_ssh_key`."
  type        = string
}

variable "domain_name" {
  description = "Domain pointing to DigitalOcean name servers."
  type        = string
}

variable "a_record_name" {
  description = "Host name of the A record."
  type        = string
}

variable "create_cname" {
  description = "Whether a www CNAME record should be created."
  type        = bool
}

variable "droplet_user_data" {
  description = "User data for the `digitalocean_droplet`."
  type        = string
}

variable "do_project_id" {
  description = "ID of the `digitalocean_project`."
  type        = string
}

variable "gh_repo_name" {
  description = "Name of the `github_repository`."
  type        = string
}
