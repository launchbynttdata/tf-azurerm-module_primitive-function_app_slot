instance_env            = 0
instance_resource       = 0
logical_product_family  = "launch"
logical_product_service = "funcapp"
class_env               = "gotest"
location                = "eastus"
os_type                 = "Windows"
slot_site_config = {
  always_on             = true
  api_definition_url    = "https://api.example.com/windows_swagger.json"
  api_management_api_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg1/providers/Microsoft.ApiManagement/service/apimService1/apis/00000000-0000-0000-0000-000000000000"
  app_command_line      = "dotnet MyApplication.dll"
  app_service_logs = {
    disk_quota_mb         = 73
    retention_period_days = 7
  }
  application_insights_connection_string = "InstrumentationKey=00000000-0000-0000-0000-000000000000"
  application_insights_key               = "00000000-0000-0000-0000-000000000000"
  application_stack = {
    dotnet_version              = "v8.0"
    use_dotnet_isolated_runtime = true
  }
  auto_swap_slot_name                           = "staging"
  container_registry_managed_identity_client_id = "00000000-0000-0000-0000-000000000000"
  container_registry_use_managed_identity       = true
  cors = {
    allowed_origins = [
      "https://www.example.com",
      "https://www.contoso.com",
      "http://localhost:8080"
    ]
    support_credentials = false
  }
  default_documents = ["default.html", "default.htm", "index.html", "index.htm"]
  # detailed_error_logging_enabled    = true
  ftps_state                        = "Disabled"
  health_check_eviction_time_in_min = 3
  health_check_path                 = "/healthz"
  http2_enabled                     = true
  ip_restriction = [{
    action     = "Allow"
    priority   = 100
    name       = "AllowTenTenTenTen"
    tag        = "Default"
    ip_address = "10.10.10.10/32"
    },
    {
      action     = "Allow"
      priority   = 101
      name       = "AllowTwentyTwentyTwentyTwenty"
      tag        = "Default"
      ip_address = "10.20.20.20/32"
  }]
  ip_restriction_default_action    = "Deny"
  load_balancing_mode              = "WeightedRoundRobin"
  managed_pipeline_mode            = "Integrated"
  minimum_tls_version              = "1.2"
  pre_warmed_instance_count        = 1
  remote_debugging_enabled         = true
  remote_debugging_version         = "VS2019"
  runtime_scale_monitoring_enabled = true
  scm_ip_restriction = {
    action     = "Allow"
    priority   = 100
    name       = "AllowTenTenTenTen"
    tag        = "Default"
    ip_address = "10.10.10.10/32"
  }
  scm_ip_restriction_default_action = "Deny"
  scm_minimum_tls_version           = "1.2"
  # scm_type                          = "LocalGit"
  scm_use_main_ip_restriction = false
  use_32_bit_worker_process   = false
  vnet_route_all_enabled      = false
  websockets_enabled          = true
  worker_count                = 1
}
slot_backup = {
  name = "slotbackup"
  schedule = {
    frequency_interval       = 1
    frequency_unit           = "Day"
    keep_at_least_one_backup = true
    retention_period_days    = 7
  }
  storage_account_url = "https://storageaccount.blob.core.windows.net/backupcontainer"
  enabled             = true
}
slot_storage_account = [{
  access_key   = "access_key1"
  account_name = "account_name1"
  mount_path   = "mount_path1"
  name         = "name1"
  share_name   = "share_name1"
  type         = "AzureFiles"
  },
  {
    access_key   = "access_key2"
    account_name = "account_name2"
    mount_path   = "mount_path2"
    name         = "name2"
    share_name   = "share_name2"
    type         = "AzureFiles"
}]
