// Configure the Google Cloud provider
provider "google" {
 credentials = file(var.credentials)
 project     = var.project
 region      = var.region
}


// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "playground-s-11-cc4fd9-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
      image = "debian-cloud/debian-9"
      //image = "ubuntu-os-cloud/ubuntu-1604-lts"
   }
 }

 metadata = {
    ssh-keys = "iaras:${file("~/.ssh/google.pub")}"
 }

// Make sure flask is installed on all new instances for later steps
// metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     nat_ip = google_compute_address.static.address	
   }
 }

// We connect to our instance via Terraform and remotely executes our script using SSH
  provisioner "remote-exec" {
    script = var.script_path

    connection {
      type        = "ssh"
      port        = 22
      host        = google_compute_address.static.address
      user        = var.username
      agent       = false
      private_key = file(var.private_key_path)
    }
  }

}

# We create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
}


resource "google_compute_firewall" "default" {
 name    = "flask-app-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["5000"]
 }
}

output "ip" {
 value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}


