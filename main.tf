module "maps" {
  source = "./examples/maps"
}

output "maps" {
  value = module.maps
}
