resource "azurerm_windows_function_app_slot" "main" {
  count = lower(var.os_type) == "windows" ? 1 : 0
  // required arguments
  name            = var.name
  function_app_id = var.function_app_id
  dynamic "site_config" {
    iterator = site_config
    for_each = try(var.site_config[*], [])
    content {
      always_on             = lookup(site_config.value, "always_on", null)
      api_definition_url    = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id = lookup(site_config.value, "api_management_api_id", null)
      app_command_line      = lookup(site_config.value, "app_command_line", null)
      app_scale_limit       = lookup(site_config.value, "app_scale_limit", null)
      dynamic "app_service_logs" {
        iterator = app_service_logs
        for_each = try(site_config.value["app_service_logs"][*], [])
        content {
          disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb", null)
          retention_period_days = lookup(app_service_logs.value, "retention_period_days", null)
        }
      }
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", null)
      dynamic "application_stack" {
        iterator = application_stack
        for_each = try(site_config.value["application_stack"][*], [])
        content {
          dotnet_version = lookup(application_stack.value, "dotnet_version", null)
          node_version   = lookup(application_stack.value, "node_version", null)
          # python_version          = lookup(application_stack.value, "python_version", null)
          java_version            = lookup(application_stack.value, "java_version", null)
          powershell_core_version = lookup(application_stack.value, "powershell_core_version", null)
          use_custom_runtime      = lookup(application_stack.value, "use_custom_runtime", false)

          # dynamic "docker" {
          #   iterator = docker
          #   for_each = application_stack.value["docker"][*]
          #   content {
          #     registry_url      = docker.value.registry_url
          #     image_name        = docker.value.image_name
          #     image_tag         = docker.value.image_tag
          #     registry_username = lookup(docker.value, "registry_username", null)
          #     registry_password = lookup(docker.value, "registry_password", null)
          #   }
          # }
        }
      }
      auto_swap_slot_name = lookup(site_config.value, "auto_swap_slot_name", null)
      # container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id", null)
      # container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity", null)
      dynamic "cors" {
        iterator = cors
        for_each = try(site_config.value["cors"][*], [])
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
      default_documents                 = lookup(site_config.value, "default_documents", null)
      detailed_error_logging_enabled    = lookup(site_config.value, "detailed_error_logging_enabled", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      dynamic "ip_restriction" {
        iterator = ip_restriction
        for_each = try(site_config.value["ip_restriction"][*], [])
        content {
          action                    = lookup(ip_restriction.value, "action", null)
          ip_address                = lookup(ip_restriction.value, "ip_address", null)
          name                      = lookup(ip_restriction.value, "name", null)
          priority                  = lookup(ip_restriction.value, "priority", null)
          service_tag               = lookup(ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
          dynamic "headers" {
            iterator = headers
            for_each = try(ip_restriction.value["headers"][*], [])
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }
      ip_restriction_default_action = lookup(site_config.value, "ip_restriction_default_action", null)
      # linux_fx_version                 = lookup(site_config.value, "linux_fx_version", null)
      load_balancing_mode              = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode            = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version              = lookup(site_config.value, "minimum_tls_version", null)
      pre_warmed_instance_count        = lookup(site_config.value, "pre_warmed_instance_count", null)
      remote_debugging_enabled         = lookup(site_config.value, "remote_debugging_enabled", null)
      remote_debugging_version         = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      dynamic "scm_ip_restriction" {
        iterator = scm_ip_restriction
        for_each = try(site_config.value["scm_ip_restriction"][*], [])
        content {
          action                    = lookup(scm_ip_restriction.value, "action", null)
          ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
          dynamic "headers" {
            iterator = headers
            for_each = try(scm_ip_restriction.value["headers"][*], [])
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }
      scm_ip_restriction_default_action = lookup(site_config.value, "scm_ip_restriction_default_action", null)
      scm_minimum_tls_version           = lookup(site_config.value, "scm_minimum_tls_version", null)
      scm_type                          = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction       = lookup(site_config.value, "scm_use_main_ip_restriction", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      vnet_route_all_enabled            = lookup(site_config.value, "vnet_route_all_enabled", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", null)
      worker_count                      = lookup(site_config.value, "worker_count", null)
    }
  }

  // optional parameters
  app_settings = var.app_settings
  dynamic "auth_settings" {
    iterator = auth_settings
    for_each = try(var.auth_settings[*], [])
    content {
      enabled = lookup(auth_settings.value, "enabled", null)
      dynamic "active_directory" {
        iterator = active_directory
        for_each = try(auth_settings.value["active_directory"][*], [])
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences", null)
          client_secret              = lookup(active_directory.value, "client_secret", null)
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name", null)
        }
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      dynamic "facebook" {
        iterator = facebook
        for_each = try(auth_settings.value["facebook"][*], [])
        content {
          app_id                  = facebook.value.app_id
          app_secret              = lookup(facebook.value, "app_secret", null)
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name", null)
          oauth_scopes            = lookup(facebook.value, "oauth_scopes", null)
        }
      }
      dynamic "github" {
        iterator = github
        for_each = try(auth_settings.value["github"][*], [])
        content {
          client_id                  = github.value.client_id
          client_secret              = lookup(github.value, "client_secret", null)
          client_secret_setting_name = lookup(github.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(github.value, "oauth_scopes", null)
        }
      }
      dynamic "google" {
        iterator = google
        for_each = try(auth_settings.value["google"][*], [])
        content {
          client_id                  = google.value.client_id
          client_secret              = lookup(google.value, "client_secret", null)
          client_secret_setting_name = lookup(google.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(google.value, "oauth_scopes", null)
        }
      }
      issuer = lookup(auth_settings.value, "issuer", null)
      dynamic "microsoft" {
        iterator = microsoft
        for_each = try(auth_settings.value["microsoft"][*], [])
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = lookup(microsoft.value, "client_secret", null)
          client_secret_setting_name = lookup(microsoft.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes", null)
        }
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", null)
      dynamic "twitter" {
        iterator = twitter
        for_each = try(auth_settings.value["twitter"][*], [])
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = lookup(twitter.value, "consumer_secret", null)
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name", null)
        }
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "auth_settings_v2" {
    iterator = auth_settings_v2
    for_each = try(var.auth_settings_v2[*], [])
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", null)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "exclude_paths", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        iterator = apple_v2
        for_each = try(auth_settings_v2.value["apple_v2"][*], [])
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(apple_v2.value, "login_scopes", null)
        }
      }
      dynamic "active_directory_v2" {
        iterator = active_directory_v2
        for_each = try(auth_settings_v2.value["active_directory_v2"][*], [])
        content {
          client_id                       = active_directory_v2.client_id
          tenant_auth_endpoint            = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          client_secret_setting_name      = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          jwt_allowed_groups              = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          jwt_allowed_client_applications = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          www_authentication_disabled     = lookup(active_directory_v2.value, "www_authentication_disabled", null)
          allowed_groups                  = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities              = lookup(active_directory_v2.value, "allowed_identities", null)
          allowed_applications            = lookup(active_directory_v2.value, "allowed_applications", null)
          login_parameters                = lookup(active_directory_v2.value, "login_parameters", null)
          allowed_audiences               = lookup(active_directory_v2.value, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        iterator = azure_static_web_app_v2
        for_each = try(auth_settings_v2.value["azure_static_web_app_v2"][*], [])
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }
      dynamic "custom_oidc_v2" {
        iterator = custom_oidc_v2
        for_each = try(auth_settings_v2.value["custom_oidc_v2"][*], [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", null)
          client_credential_method      = custom_oidc_v2.value.client_credential_method
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          authorisation_endpoint        = custom_oidc_v2.value.authorisation_endpoint
          token_endpoint                = custom_oidc_v2.value.token_endpoint
          issuer_endpoint               = custom_oidc_v2.value.issuer_endpoint
          certification_uri             = custom_oidc_v2.value.certification_uri
        }
      }
      dynamic "facebook_v2" {
        iterator = facebook_v2
        for_each = try(auth_settings_v2.value["facebook_v2"][*], [])
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)
        }
      }
      dynamic "github_v2" {
        iterator = github_v2
        for_each = try(auth_settings_v2.value["github_v2"][*], [])
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = lookup(github_v2.value, "login_scopes", null)
        }
      }
      dynamic "google_v2" {
        iterator = google_v2
        for_each = try(auth_settings_v2.value["google_v2"][*], [])
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)
        }
      }
      dynamic "microsoft_v2" {
        iterator = microsoft_v2
        for_each = try(auth_settings_v2.value["microsoft_v2"][*], [])
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)
        }
      }
      dynamic "twitter_v2" {
        iterator = twitter_v2
        for_each = try(auth_settings_v2.value["twitter_v2"][*], [])
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
      login {
        logout_endpoint                   = lookup(auth_settings_v2.value.login, "logout_endpoint", null)
        token_store_enabled               = lookup(auth_settings_v2.value.login, "token_store_enabled", null)
        token_store_path                  = lookup(auth_settings_v2.value.login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(auth_settings_v2.value.login, "token_store_sas_setting_name", null)
        preserve_url_fragments_for_logins = lookup(auth_settings_v2.value.login, "preserve_url_fragments_for_logins", null)
        allowed_external_redirect_urls    = lookup(auth_settings_v2.value.login, "allowed_external_redirect_urls", null)
        cookie_expiration_convention      = lookup(auth_settings_v2.value.login, "cookie_expiration_convention", null)
        cookie_expiration_time            = lookup(auth_settings_v2.value.login, "cookie_expiration_time", null)
        validate_nonce                    = lookup(auth_settings_v2.value.login, "validate_nonce", null)
        nonce_expiration_time             = lookup(auth_settings_v2.value.login, "nonce_expiration_time", null)
      }
    }
  }

  dynamic "backup" {
    iterator = backup
    for_each = try(var.backup[*], [])
    content {
      name = backup.value.name
      schedule {
        frequency_interval       = backup.value["schedule"]["frequency_interval"]
        frequency_unit           = backup.value["schedule"]["frequency_unit"]
        keep_at_least_one_backup = lookup(backup.value["schedule"], "keep_at_least_one_backup", null)
        retention_period_days    = lookup(backup.value["schedule"], "retention_period_days", null)
        start_time               = lookup(backup.value["schedule"], "start_time", null)
        last_execution_time      = lookup(backup.value["schedule"], "last_execution_time", null)
      }
      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled
    }
  }

  builtin_logging_enabled            = var.builtin_logging_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths
  dynamic "connection_string" {
    iterator = connection_string
    for_each = try(var.connection_string[*], [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  content_share_force_disabled             = var.content_share_force_disabled
  daily_memory_time_quota                  = var.daily_memory_time_quota
  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  functions_extension_version              = var.functions_extension_version
  https_only                               = var.https_only
  public_network_access_enabled            = var.public_network_access_enabled
  dynamic "identity" {
    iterator = identity
    for_each = try(var.identity[*], [])
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  service_plan_id                 = var.service_plan_id
  storage_account_access_key      = var.storage_account_access_key == null ? null : var.storage_account_access_key
  storage_account_name            = var.storage_account_name

  dynamic "storage_account" {
    iterator = storage_account
    for_each = try(var.storage_account[*], [])
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  storage_uses_managed_identity = var.storage_account_access_key == null ? var.storage_uses_managed_identity : null
  storage_key_vault_secret_id   = var.storage_key_vault_secret_id
  tags                          = merge(local.default_tags, var.tags)

  ## a lifecycle block is not able to be made dynamic due to the way terraform processes the lifecycle block.auth_settings
  ## see https://github.com/hashicorp/terraform/issues/24188 for discussion of the issue and any potential updates to
  ## terraform that may allow for dynamic lifecycle blocks

  # dynamic "lifecycle" {
  #   for_each = try(var.tf_lifecycle_ignore_changes[*], [])
  #   content {
  #     ignore_changes = var.tf_lifecycle_ignore_changes.ignore_changes
  #   }
  # }

  ## We need to ignore app_settings as these are frequently changed and updated by the application deployment processes. We prefer
  ##  to ask the application developers to manage the app settings directly rather than have to manage them in the terraform code.
  ##  Similarly, the ip_restruction and scm_ip_restriction should be managed outside the terraform code by other processes and
  ##  terraform should ignore the updates made by those processes.
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["ip_restriction"],
      site_config["scm_ip_restriction"]
    ]
  }

}

resource "azurerm_linux_function_app_slot" "main" {
  count = lower(var.os_type) == "linux" ? 1 : 0
  // required arguments
  name            = var.name
  function_app_id = var.function_app_id
  dynamic "site_config" {
    iterator = site_config
    for_each = try(var.site_config[*], [])
    content {
      always_on             = lookup(site_config.value, "always_on", null)
      api_definition_url    = lookup(site_config.value, "api_definition_url", null)
      api_management_api_id = lookup(site_config.value, "api_management_api_id", null)
      app_command_line      = lookup(site_config.value, "app_command_line", null)
      app_scale_limit       = lookup(site_config.value, "app_scale_limit", null)
      dynamic "app_service_logs" {
        iterator = app_service_logs
        for_each = try(site_config.value["app_service_logs"][*], [])
        content {
          disk_quota_mb         = lookup(app_service_logs.value, "disk_quota_mb", null)
          retention_period_days = lookup(app_service_logs.value, "retention_period_days", null)
        }
      }
      application_insights_connection_string = lookup(site_config.value, "application_insights_connection_string", null)
      application_insights_key               = lookup(site_config.value, "application_insights_key", null)
      dynamic "application_stack" {
        iterator = application_stack
        for_each = try(site_config.value["application_stack"][*], [])
        content {
          dotnet_version          = lookup(application_stack.value, "dotnet_version", null)
          node_version            = lookup(application_stack.value, "node_version", null)
          python_version          = lookup(application_stack.value, "python_version", null)
          java_version            = lookup(application_stack.value, "java_version", null)
          powershell_core_version = lookup(application_stack.value, "powershell_core_version", null)
          use_custom_runtime      = lookup(application_stack.value, "use_custom_runtime", false)

          dynamic "docker" {
            iterator = docker
            for_each = application_stack.value["docker"][*]
            content {
              registry_url      = docker.value.registry_url
              image_name        = docker.value.image_name
              image_tag         = docker.value.image_tag
              registry_username = lookup(docker.value, "registry_username", null)
              registry_password = lookup(docker.value, "registry_password", null)
            }
          }
        }
      }
      auto_swap_slot_name                           = lookup(site_config.value, "auto_swap_slot_name", null)
      container_registry_managed_identity_client_id = lookup(site_config.value, "container_registry_managed_identity_client_id", null)
      container_registry_use_managed_identity       = lookup(site_config.value, "container_registry_use_managed_identity", null)
      dynamic "cors" {
        iterator = cors
        for_each = try(site_config.value["cors"][*], [])
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }
      default_documents                 = lookup(site_config.value, "default_documents", null)
      detailed_error_logging_enabled    = lookup(site_config.value, "detailed_error_logging_enabled", null)
      ftps_state                        = lookup(site_config.value, "ftps_state", null)
      health_check_eviction_time_in_min = lookup(site_config.value, "health_check_eviction_time_in_min", null)
      health_check_path                 = lookup(site_config.value, "health_check_path", null)
      http2_enabled                     = lookup(site_config.value, "http2_enabled", null)
      dynamic "ip_restriction" {
        iterator = ip_restriction
        for_each = try(site_config.value["ip_restriction"][*], [])
        content {
          action                    = lookup(ip_restriction.value, "action", null)
          ip_address                = lookup(ip_restriction.value, "ip_address", null)
          name                      = lookup(ip_restriction.value, "name", null)
          priority                  = lookup(ip_restriction.value, "priority", null)
          service_tag               = lookup(ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
          dynamic "headers" {
            iterator = headers
            for_each = try(ip_restriction.value["headers"][*], [])
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }
      ip_restriction_default_action    = lookup(site_config.value, "ip_restriction_default_action", null)
      linux_fx_version                 = lookup(site_config.value, "linux_fx_version", null)
      load_balancing_mode              = lookup(site_config.value, "load_balancing_mode", null)
      managed_pipeline_mode            = lookup(site_config.value, "managed_pipeline_mode", null)
      minimum_tls_version              = lookup(site_config.value, "minimum_tls_version", null)
      pre_warmed_instance_count        = lookup(site_config.value, "pre_warmed_instance_count", null)
      remote_debugging_enabled         = lookup(site_config.value, "remote_debugging_enabled", null)
      remote_debugging_version         = lookup(site_config.value, "remote_debugging_version", null)
      runtime_scale_monitoring_enabled = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      dynamic "scm_ip_restriction" {
        iterator = scm_ip_restriction
        for_each = try(site_config.value["scm_ip_restriction"][*], [])
        content {
          action                    = lookup(scm_ip_restriction.value, "action", null)
          ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
          name                      = lookup(scm_ip_restriction.value, "name", null)
          priority                  = lookup(scm_ip_restriction.value, "priority", null)
          service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
          dynamic "headers" {
            iterator = headers
            for_each = try(scm_ip_restriction.value["headers"][*], [])
            content {
              x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
            }
          }
        }
      }
      scm_ip_restriction_default_action = lookup(site_config.value, "scm_ip_restriction_default_action", null)
      scm_minimum_tls_version           = lookup(site_config.value, "scm_minimum_tls_version", null)
      scm_type                          = lookup(site_config.value, "scm_type", null)
      scm_use_main_ip_restriction       = lookup(site_config.value, "scm_use_main_ip_restriction", null)
      use_32_bit_worker                 = lookup(site_config.value, "use_32_bit_worker", null)
      vnet_route_all_enabled            = lookup(site_config.value, "vnet_route_all_enabled", null)
      websockets_enabled                = lookup(site_config.value, "websockets_enabled", null)
      worker_count                      = lookup(site_config.value, "worker_count", null)
    }
  }

  // optional parameters
  app_settings = var.app_settings
  dynamic "auth_settings" {
    iterator = auth_settings
    for_each = try(var.auth_settings[*], [])
    content {
      enabled = lookup(auth_settings.value, "enabled", null)
      dynamic "active_directory" {
        iterator = active_directory
        for_each = try(auth_settings.value["active_directory"][*], [])
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences", null)
          client_secret              = lookup(active_directory.value, "client_secret", null)
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name", null)
        }
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      dynamic "facebook" {
        iterator = facebook
        for_each = try(auth_settings.value["facebook"][*], [])
        content {
          app_id                  = facebook.value.app_id
          app_secret              = lookup(facebook.value, "app_secret", null)
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name", null)
          oauth_scopes            = lookup(facebook.value, "oauth_scopes", null)
        }
      }
      dynamic "github" {
        iterator = github
        for_each = try(auth_settings.value["github"][*], [])
        content {
          client_id                  = github.value.client_id
          client_secret              = lookup(github.value, "client_secret", null)
          client_secret_setting_name = lookup(github.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(github.value, "oauth_scopes", null)
        }
      }
      dynamic "google" {
        iterator = google
        for_each = try(auth_settings.value["google"][*], [])
        content {
          client_id                  = google.value.client_id
          client_secret              = lookup(google.value, "client_secret", null)
          client_secret_setting_name = lookup(google.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(google.value, "oauth_scopes", null)
        }
      }
      issuer = lookup(auth_settings.value, "issuer", null)
      dynamic "microsoft" {
        iterator = microsoft
        for_each = try(auth_settings.value["microsoft"][*], [])
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = lookup(microsoft.value, "client_secret", null)
          client_secret_setting_name = lookup(microsoft.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes", null)
        }
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", null)
      dynamic "twitter" {
        iterator = twitter
        for_each = try(auth_settings.value["twitter"][*], [])
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = lookup(twitter.value, "consumer_secret", null)
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name", null)
        }
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "auth_settings_v2" {
    iterator = auth_settings_v2
    for_each = try(var.auth_settings_v2[*], [])
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", null)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "exclude_paths", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        iterator = apple_v2
        for_each = try(auth_settings_v2.value["apple_v2"][*], [])
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(apple_v2.value, "login_scopes", null)
        }
      }
      dynamic "active_directory_v2" {
        iterator = active_directory_v2
        for_each = try(auth_settings_v2.value["active_directory_v2"][*], [])
        content {
          client_id                       = active_directory_v2.client_id
          tenant_auth_endpoint            = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          client_secret_setting_name      = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          jwt_allowed_groups              = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          jwt_allowed_client_applications = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          www_authentication_disabled     = lookup(active_directory_v2.value, "www_authentication_disabled", null)
          allowed_groups                  = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities              = lookup(active_directory_v2.value, "allowed_identities", null)
          allowed_applications            = lookup(active_directory_v2.value, "allowed_applications", null)
          login_parameters                = lookup(active_directory_v2.value, "login_parameters", null)
          allowed_audiences               = lookup(active_directory_v2.value, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        iterator = azure_static_web_app_v2
        for_each = try(auth_settings_v2.value["azure_static_web_app_v2"][*], [])
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }
      dynamic "custom_oidc_v2" {
        iterator = custom_oidc_v2
        for_each = try(auth_settings_v2.value["custom_oidc_v2"][*], [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", null)
          client_credential_method      = custom_oidc_v2.value.client_credential_method
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          authorisation_endpoint        = custom_oidc_v2.value.authorisation_endpoint
          token_endpoint                = custom_oidc_v2.value.token_endpoint
          issuer_endpoint               = custom_oidc_v2.value.issuer_endpoint
          certification_uri             = custom_oidc_v2.value.certification_uri
        }
      }
      dynamic "facebook_v2" {
        iterator = facebook_v2
        for_each = try(auth_settings_v2.value["facebook_v2"][*], [])
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)
        }
      }
      dynamic "github_v2" {
        iterator = github_v2
        for_each = try(auth_settings_v2.value["github_v2"][*], [])
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = lookup(github_v2.value, "login_scopes", null)
        }
      }
      dynamic "google_v2" {
        iterator = google_v2
        for_each = try(auth_settings_v2.value["google_v2"][*], [])
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)
        }
      }
      dynamic "microsoft_v2" {
        iterator = microsoft_v2
        for_each = try(auth_settings_v2.value["microsoft_v2"][*], [])
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)
        }
      }
      dynamic "twitter_v2" {
        iterator = twitter_v2
        for_each = try(auth_settings_v2.value["twitter_v2"][*], [])
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
      login {
        logout_endpoint                   = lookup(auth_settings_v2.value.login, "logout_endpoint", null)
        token_store_enabled               = lookup(auth_settings_v2.value.login, "token_store_enabled", null)
        token_store_path                  = lookup(auth_settings_v2.value.login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(auth_settings_v2.value.login, "token_store_sas_setting_name", null)
        preserve_url_fragments_for_logins = lookup(auth_settings_v2.value.login, "preserve_url_fragments_for_logins", null)
        allowed_external_redirect_urls    = lookup(auth_settings_v2.value.login, "allowed_external_redirect_urls", null)
        cookie_expiration_convention      = lookup(auth_settings_v2.value.login, "cookie_expiration_convention", null)
        cookie_expiration_time            = lookup(auth_settings_v2.value.login, "cookie_expiration_time", null)
        validate_nonce                    = lookup(auth_settings_v2.value.login, "validate_nonce", null)
        nonce_expiration_time             = lookup(auth_settings_v2.value.login, "nonce_expiration_time", null)
      }
    }
  }

  dynamic "backup" {
    iterator = backup
    for_each = try(var.backup[*], [])
    content {
      name = backup.value.name
      schedule {
        frequency_interval       = backup.value["schedule"]["frequency_interval"]
        frequency_unit           = backup.value["schedule"]["frequency_unit"]
        keep_at_least_one_backup = lookup(backup.value["schedule"], "keep_at_least_one_backup", null)
        retention_period_days    = lookup(backup.value["schedule"], "retention_period_days", null)
        start_time               = lookup(backup.value["schedule"], "start_time", null)
        last_execution_time      = lookup(backup.value["schedule"], "last_execution_time", null)
      }
      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled
    }
  }

  builtin_logging_enabled            = var.builtin_logging_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths
  dynamic "connection_string" {
    iterator = connection_string
    for_each = try(var.connection_string[*], [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  content_share_force_disabled             = var.content_share_force_disabled
  daily_memory_time_quota                  = var.daily_memory_time_quota
  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  functions_extension_version              = var.functions_extension_version
  https_only                               = var.https_only
  public_network_access_enabled            = var.public_network_access_enabled
  dynamic "identity" {
    iterator = identity
    for_each = try(var.identity[*], [])
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  service_plan_id                 = var.service_plan_id
  storage_account_access_key      = var.storage_account_access_key == null ? null : var.storage_account_access_key
  storage_account_name            = var.storage_account_name

  dynamic "storage_account" {
    iterator = storage_account
    for_each = try(var.storage_account[*], [])
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  storage_uses_managed_identity = var.storage_account_access_key == null ? true : null
  storage_key_vault_secret_id   = var.storage_key_vault_secret_id
  tags                          = merge(local.default_tags, var.tags)

  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  ## a lifecycle block is not able to be made dynamic due to the way terraform processes the lifecycle block.auth_settings
  ## see https://github.com/hashicorp/terraform/issues/24188 for discussion of the issue and any potential updates to
  ## terraform that may allow for dynamic lifecycle blocks

  # dynamic "lifecycle" {
  #   for_each = try(var.tf_lifecycle_ignore_changes[*], [])
  #   content {
  #     ignore_changes = var.tf_lifecycle_ignore_changes.ignore_changes
  #   }
  # }

  ## We need to ignore app_settings as these are frequently changed and updated by the application deployment processes. We prefer
  ##  to ask the application developers to manage the app settings directly rather than have to manage them in the terraform code.
  ##  Similarly, the ip_restruction and scm_ip_restriction should be managed outside the terraform code by other processes and
  ##  terraform should ignore the updates made by those processes.
  lifecycle {
    ignore_changes = [
      app_settings,
      site_config["ip_restriction"],
      site_config["scm_ip_restriction"]
    ]
  }

}
