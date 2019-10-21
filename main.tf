variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "project" {
  default = "todo-app"
}

variable "service_account_json" {
  default = "secrets/service_account.json"
}

provider "google" {
  project    = "${var.project}-${terraform.workspace}"
  region     = "${var.region}"
  zone       = "${var.zone}"
  credentials = "${file("${var.service_account_json}")}"
}

resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "terraform"
}

resource "google_container_cluster" "primary" {
  project            = "${var.project}-${terraform.workspace} "
  name               = "${var.project}"
  location           = "${var.zone}"
  initial_node_count = 1
}

