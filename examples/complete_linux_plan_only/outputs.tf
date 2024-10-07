// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "slot_default_hostname" {
  value = lower(var.os_type) == "windows" ? module.function_app_slot.windows_function_app_slot_default_hostname : module.function_app_slot.linux_function_app_slot_default_hostname
}

output "function_app_slot_name" {
  value = lower(var.os_type) == "windows" ? module.function_app_slot.windows_function_app_slot_name : module.function_app_slot.linux_function_app_slot_name
}

output "function_app_slot_id" {
  value = lower(var.os_type) == "windows" ? module.function_app_slot.windows_function_app_slot_id : module.function_app_slot.linux_function_app_slot_id
}

output "service_plan_name" {
  value = module.app_service_plan.name
}

output "service_plan_id" {
  value = module.app_service_plan.id
}

output "storage_account_id" {
  description = "The id of the storage account"
  value       = module.storage_account.id
}
