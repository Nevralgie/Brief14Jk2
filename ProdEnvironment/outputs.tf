output "Webserver_Public_ip" {
  value = module.azure-webserver.The_webserver_Public_ip
}

output "Websrever_Private_ip" {
  value = module.azure-webserver.The_websrever_Private_ip
}

output "Size_of_the_VM" {
  value = module.azure-webserver.VM_Size
}

output "Environment" {
  value = module.azure-webserver.environment
}
