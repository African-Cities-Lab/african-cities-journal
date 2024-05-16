terraform {
  cloud {
    organization = "exaf-epfl"
    workspaces {
      name = "african-cities-journal-prod"
    }
  }
}
