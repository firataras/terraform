#----root/outputs.tf-----

#----storage outputs------
output "bucketname" {
  value = "${module.storage.bucketname}"
}
