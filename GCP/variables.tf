variable "project" {
  //description = "project"
  default = "playground-s-11-738662"
}

variable "region" {
  //description = "region"
  default = "us-west1"
}

variable "credentials" {
  //description = "credentials"
  default = "credentials.json"
}



variable "script_path" {
  //default = "/home/ismailaras/projects/terraform/GCP/scripts/bootstrap.sh"
  default = "/home/ismailaras/projects/terraform/GCP/scripts/flask.sh"
  //description = "/home/ismailaras/projects/terraform/GCP/scripts/bootstrap.sh"
}

variable "private_key_path" {
  //description = "~/.ssh/google"
  default = "~/.ssh/google"
}

variable "username" {
  //description = "iaras"
  default = "iaras"
}
