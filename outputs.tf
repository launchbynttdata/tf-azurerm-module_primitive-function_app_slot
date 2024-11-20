output "windows_function_app_slot_name" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].name : null
}

output "windows_function_app_slot_id" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].id : null
}

output "windows_function_app_slot_default_hostname" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].default_hostname : null
}

output "windows_function_app_slot_possible_outbound_ip_address_list" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].possible_outbound_ip_address_list : null
}

output "windows_function_app_slot_kind" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].kind : null
}

output "windows_function_app_slot_custom_domain_verification_id" {
  value = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].custom_domain_verification_id : null
}

output "linux_function_app_slot_name" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].name : null
}

output "linux_function_app_slot_id" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].id : null
}

output "linux_function_app_slot_default_hostname" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].default_hostname : null
}

output "linux_function_app_slot_possible_outbound_ip_address_list" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].possible_outbound_ip_address_list : null
}

output "linux_function_app_slot_kind" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].kind : null
}

output "linux_function_app_slot_custom_domain_verification_id" {
  value = lower(var.os_type) == "linux" ? azurerm_linux_function_app_slot.main[0].custom_domain_verification_id : null
}

output "function_app_slot_name" {
  description = "The name of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].name : azurerm_linux_function_app_slot.main[0].name
}

output "function_app_slot_id" {
  description = "The ID of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].id : azurerm_linux_function_app_slot.main[0].id
}

output "function_app_slot_default_hostname" {
  description = "The default hostname of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].default_hostname : azurerm_linux_function_app_slot.main[0].default_hostname
}

output "function_app_slot_possible_outbound_ip_address_list" {
  description = "The possible outbound IP addresses of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].possible_outbound_ip_address_list : azurerm_linux_function_app_slot.main[0].possible_outbound_ip_address_list
}

output "function_app_slot_kind" {
  description = "The kind of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].kind : azurerm_linux_function_app_slot.main[0].kind
}

output "function_app_slot_custom_domain_verification_id" {
  description = "The custom domain verification ID of the Function App Slot."
  value       = lower(var.os_type) == "windows" ? azurerm_windows_function_app_slot.main[0].custom_domain_verification_id : azurerm_linux_function_app_slot.main[0].custom_domain_verification_id
}
