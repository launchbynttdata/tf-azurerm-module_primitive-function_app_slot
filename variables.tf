variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Function App Slot. Changing this forces a new resource to be created."
  validation {
    condition     = can(regex("^[a-z0-9-]{2,60}$", var.name))
    error_message = "name must be a string between 2 and 60 characters in length and contain only numbers, lowercase letters, and hyphens."
  }
}

variable "function_app_id" {
  type        = string
  description = "(Required) Specifies the ID of the Function App in which to create the slot. Changing this forces a new resource to be created."
  validation {
    condition     = can(regex("^[a-zA-Z0-9-/.]{2,255}$", var.function_app_id))
    error_message = "function_app_id must be a valid azure resource identifier."
  }
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the name of the Resource Group in which to create the Function App Slot."
  validation {
    condition     = can(regex("^[a-z0-9-]{2,60}$", var.resource_group_name))
    error_message = "resource_group_name must be a string between 2 and 60 characters in length and contain only numbers, letters, and hyphens."
  }
}

variable "site_config" {
  type = object({
    always_on             = optional(bool, false)
    api_definition_url    = optional(string)
    api_management_api_id = optional(string)
    app_command_line      = optional(string)
    app_scale_limit       = optional(number)
    app_service_logs = optional(object({
      disk_quota_mb         = optional(number, 35)
      retention_period_days = optional(number, 5)
    }))
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)
    application_stack = optional(object({
      docker = optional(object({
        registry_url      = string
        image_name        = string
        image_tag         = string
        registry_username = optional(string)
        registry_password = optional(string)
      }))
      dotnet_version              = optional(string)
      java_version                = optional(string)
      node_version                = optional(string)
      powershell_core_version     = optional(string)
      python_version              = optional(string)
      use_custom_runtime          = optional(bool)
      use_dotnet_isolated_runtime = optional(bool)
    }))
    auto_swap_slot_name                           = optional(string)
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    cors = optional(object({
      allowed_origins     = optional(list(string))
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    detailed_error_logging_enabled    = optional(bool)
    ftps_state                        = optional(string)
    health_check_eviction_time_in_min = optional(number)
    health_check_path                 = optional(string)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      action     = optional(string)
      ip_address = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string), null)
        x_fd_health_probe = optional(list(string), null)
        x_forwarded_for   = optional(list(string), null)
        x_forwarded_host  = optional(list(string), null)
      }))
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    })))
    ip_restriction_default_action    = optional(string)
    linux_fx_version                 = optional(string)
    load_balancing_mode              = optional(string)
    managed_pipeline_mode            = optional(string)
    minimum_tls_version              = optional(string)
    pre_warmed_instance_count        = optional(number)
    remote_debugging_enabled         = optional(bool)
    remote_debugging_version         = optional(string)
    runtime_scale_monitoring_enabled = optional(bool)
    scm_ip_restriction = optional(object({
      action = optional(string)
      headers = optional(object({
        x_azure_fdid      = optional(list(string), null)
        x_fd_health_probe = optional(list(string), null)
        x_forwarded_for   = optional(list(string), null)
        x_forwarded_host  = optional(list(string), null)
      }))
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
    }))
    scm_ip_restriction_default_action = optional(string)
    scm_minimum_tls_version           = optional(string)
    scm_type                          = optional(string)
    scm_use_main_ip_restriction       = optional(bool)
    use_32_bit_worker                 = optional(bool)
    vnet_route_all_enabled            = optional(bool)
    websockets_enabled                = optional(bool)
    worker_count                      = optional(number)
  })
  description = "(Required) A site_config block."
  default     = null
}

variable "app_settings" {
  type        = map(string)
  description = "(Optional) A key-value pair of App Settings."
  default     = null
}

variable "auth_settings" {
  description = "(Optional) A auth_settings block."
  type = object({
    enabled = bool
    active_directory = optional(object({
      client_id                  = string
      allowed_audiences          = list(string)
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
    }))
    additional_login_parameters    = optional(list(map(any)))
    allowed_external_redirect_urls = optional(list(string))
    default_provider               = optional(string)
    facebook = optional(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(list(string))
    }))
    github = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    google = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    issuer = optional(string)
    microsoft = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    runtime_version               = optional(string)
    token_refresh_extension_hours = optional(number)
    token_store_enabled           = optional(bool)
    twitter = optional(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    }))
    unauthenticated_client_action = optional(string)
  })
  default = null
}

variable "auth_settings_v2" {
  description = "(Optional) A auth_settings_v2 block."
  type = object({
    auth_enabled                            = optional(bool)
    runtime_version                         = optional(string)
    config_file_path                        = optional(string)
    require_authentication                  = optional(bool)
    unauthenticated_action                  = optional(string)
    default_provider                        = optional(string)
    excluded_paths                          = optional(list(string))
    require_https                           = optional(bool)
    http_route_api_prefix                   = optional(string)
    forward_proxy_convention                = optional(string)
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = optional(string)
      login_scopes               = optional(list(string))
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = optional(string)
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(any))
      allowed_audiences                    = optional(list(string))
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = string
      client_secret_setting_name    = optional(string)
      authorisation_endpoint        = string
      token_endpoint                = string
      issuer_endpoint               = string
      certification_uri             = string
    }))
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
    login = optional(object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(bool)
      token_refresh_extension_time      = optional(number)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(bool)
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      validate_nonce                    = optional(bool)
      nonce_expiration_time             = optional(string)
    }))
  })
  default = null
}

variable "backup" {
  description = "(Optional) A backup block."
  type = object({
    name = string
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      keep_at_least_one_backup = optional(bool)
      retention_period_days    = optional(number)
      start_time               = optional(string)
      last_execution_time      = optional(string)
    })
    storage_account_url = string
    enabled             = optional(bool, true)
  })
  default = null
}

variable "builtin_logging_enabled" {
  description = "(Optional) Specifies whether built-in logging is enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "(Optional) Specifies whether client certificate authentication is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = " (Optional) The mode of the Function App Slot's client certificates requirement for incoming requests. Possible values are Required, Optional, and OptionalInteractiveUser. Defaults to Optional."
  type        = string
  default     = "Optional"
  validation {
    condition     = var.client_certificate_mode == null || contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "client_certificate_mode must be one of Required, Optional, or OptionalInteractiveUser."
  }
}

variable "client_certificate_exclusion_paths" {
  description = "(Optional) A list of paths to exclude from client certificate authentication. Paths separated by ;."
  type        = string
  default     = null
}

variable "connection_string" {
  description = "(Optional) A connection_string block."
  type = object({
    name  = string
    type  = string
    value = string
  })
  default = null
  validation {
    condition     = var.connection_string == null || can(contains(["APIHub", "Custom", "DocDb", "EventHub", "MySQL", "NotificationHub", "PostgreSQL", "RedisCache", "ServiceBus", "SQLAzure", "SQLServer"], var.connection_string.type))
    error_message = "connection_string.type must be one of APIHub, Custom, DocDb, EventHub, MySQL, NotificationHub, PostgreSQL, RedisCache, ServiceBus, SQLAzure, or SQLServer."
  }
}

variable "content_share_force_disabled" {
  type        = bool
  description = "(Optional) Specifies whether the content share feature is disabled. Defaults to false."
  default     = false
}

variable "daily_memory_time_quota" {
  description = "(Optional) The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps in Consumption Plans. Defaults to 0."
  type        = number
  default     = 0
  validation {
    condition     = var.daily_memory_time_quota >= 0
    error_message = "daily_memory_time_quota must be greater than or equal to 0."
  }
}

variable "enabled" {
  description = "(Optional) Specifies whether the Function App Slot is enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "(Optional) Specifies whether FTP deployment is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "functions_extension_version" {
  description = "(Optional) The version of the Azure Functions runtime to use. Defaults to ~4."
  type        = string
  default     = "~4"
  validation {
    condition     = can(regex("^[~][0-9]+$", var.functions_extension_version))
    error_message = "functions_extension_version must be in the format ~X where X is a number."
  }
}

variable "https_only" {
  description = "(Optional) Specifies whether the Function App Slot requires HTTPS only. Defaults to false."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "(Optional) Specifies whether the Function App Slot is accessible from the public network. Defaults to true."
  type        = bool
  default     = true
}

variable "identity" {
  description = "(Optional) A identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
  validation {
    condition     = var.identity == null || can(contains(["None", "SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type))
    error_message = "identity.type must be one of None, SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  }
}

variable "key_vault_reference_identity_id" {
  description = "(Optional) The identity ID of the Key Vault reference. Required when identity.type is set to UserAssigned or SystemAssigned, UserAssigned."
  type        = string
  default     = null
  validation {
    condition     = var.key_vault_reference_identity_id == null || can(regex("^[a-zA-Z0-9-/.]{2,255}$", var.key_vault_reference_identity_id))
    error_message = "key_vault_reference_identity_id must be a valid azure resource identifier."
  }
}

variable "service_plan_id" {
  description = "(Optional) Specifies the ID of the App Service Plan in which to create the Function App Slot. If not specified, the Function App Slot will be created in the same App Service Plan as the Function App. Changing this forces a new resource to be created."
  type        = string
  default     = null
  validation {
    condition     = var.service_plan_id == null || can(regex("^[a-zA-Z0-9-/.]{2,255}$", var.service_plan_id))
    error_message = "service_plan_id must be a valid azure resource identifier."
  }
}

variable "storage_account_access_key" {
  description = "(Optional) The access key of the Storage Account to use for the Function App Slot."
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "(Optional) The name of the Storage Account to use for the Function App Slot."
  type        = string
  default     = null
}

variable "storage_account" {
  description = "(Optional) One or more storage_account blocks."
  type = list(object({
    access_key   = string
    account_name = string
    name         = string
    share_name   = string
    type         = string
    mount_path   = optional(string)
  }))
  default = null
  validation {
    condition     = var.storage_account == null || can(contains(["AzureFiles", "AzureBlob"], var.storage_account[*].type))
    error_message = "storage_account.type must be one of AzureFiles or AzureBlob."
  }
}

variable "storage_uses_managed_identity" {
  description = "(Optional) Specifies whether the Function App Slot uses a managed identity to access the Storage Account. Defaults to false."
  type        = bool
  default     = false
}

variable "storage_key_vault_secret_id" {
  description = "(Optional) The ID of the Key Vault secret containing the Storage Account access key."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "(Optional) The ID of the subnet in which to create the Function App Slot."
  type        = string
  default     = null
  validation {
    condition     = var.virtual_network_subnet_id == null || can(regex("^[a-zA-Z0-9-/.]{2,255}$", var.virtual_network_subnet_id))
    error_message = "virtual_network_subnet_id must be a valid azure resource identifier."
  }
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "(Optional) Specifies whether Web Deploy publishing is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "os_type" {
  description = "(Required) Specifies the operating system type of the Function App Slot. Value must be one of Windows or Linux."
  type        = string
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be one of Windows or Linux."
  }
}

# variable "tf_lifecycle_ignore_changes" {
#   description = "(Optional) A list of attributes that should be ignored by the Terraform lifecycle. This is useful when you want to ignore changes to the resource that don't require re-creation, such as changes to tags or timeouts."
#   type        = list(string)
#   default     = null
# }
