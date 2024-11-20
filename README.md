# tf-azurerm-module_primitive-function_app_slot

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This terraform module provisions an Azure Function App with additional pre-requisite resources

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.30 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.116.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_function_app_slot.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_function_app_slot) | resource |
| [azurerm_windows_function_app_slot.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_function_app_slot) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Function App Slot. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_function_app_id"></a> [function\_app\_id](#input\_function\_app\_id) | (Required) Specifies the ID of the Function App in which to create the slot. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the Resource Group in which to create the Function App Slot. | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | (Required) A site\_config block. | <pre>object({<br>    always_on             = optional(bool, false)<br>    api_definition_url    = optional(string)<br>    api_management_api_id = optional(string)<br>    app_command_line      = optional(string)<br>    app_scale_limit       = optional(number)<br>    app_service_logs = optional(object({<br>      disk_quota_mb         = optional(number, 35)<br>      retention_period_days = optional(number, 5)<br>    }))<br>    application_insights_connection_string = optional(string)<br>    application_insights_key               = optional(string)<br>    application_stack = optional(object({<br>      docker = optional(object({<br>        registry_url      = string<br>        image_name        = string<br>        image_tag         = string<br>        registry_username = optional(string)<br>        registry_password = optional(string)<br>      }))<br>      dotnet_version              = optional(string)<br>      java_version                = optional(string)<br>      node_version                = optional(string)<br>      powershell_core_version     = optional(string)<br>      python_version              = optional(string)<br>      use_custom_runtime          = optional(bool)<br>      use_dotnet_isolated_runtime = optional(bool)<br>    }))<br>    auto_swap_slot_name                           = optional(string)<br>    container_registry_managed_identity_client_id = optional(string)<br>    container_registry_use_managed_identity       = optional(bool)<br>    cors = optional(object({<br>      allowed_origins     = optional(list(string))<br>      support_credentials = optional(bool)<br>    }))<br>    default_documents                 = optional(list(string))<br>    detailed_error_logging_enabled    = optional(bool)<br>    ftps_state                        = optional(string)<br>    health_check_eviction_time_in_min = optional(number)<br>    health_check_path                 = optional(string)<br>    http2_enabled                     = optional(bool)<br>    ip_restriction = optional(list(object({<br>      action     = optional(string)<br>      ip_address = optional(string)<br>      headers = optional(object({<br>        x_azure_fdid      = optional(list(string), null)<br>        x_fd_health_probe = optional(list(string), null)<br>        x_forwarded_for   = optional(list(string), null)<br>        x_forwarded_host  = optional(list(string), null)<br>      }))<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>    })))<br>    ip_restriction_default_action    = optional(string)<br>    linux_fx_version                 = optional(string)<br>    load_balancing_mode              = optional(string)<br>    managed_pipeline_mode            = optional(string)<br>    minimum_tls_version              = optional(string)<br>    pre_warmed_instance_count        = optional(number)<br>    remote_debugging_enabled         = optional(bool)<br>    remote_debugging_version         = optional(string)<br>    runtime_scale_monitoring_enabled = optional(bool)<br>    scm_ip_restriction = optional(object({<br>      action = optional(string)<br>      headers = optional(object({<br>        x_azure_fdid      = optional(list(string), null)<br>        x_fd_health_probe = optional(list(string), null)<br>        x_forwarded_for   = optional(list(string), null)<br>        x_forwarded_host  = optional(list(string), null)<br>      }))<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>    }))<br>    scm_ip_restriction_default_action = optional(string)<br>    scm_minimum_tls_version           = optional(string)<br>    scm_type                          = optional(string)<br>    scm_use_main_ip_restriction       = optional(bool)<br>    use_32_bit_worker                 = optional(bool)<br>    vnet_route_all_enabled            = optional(bool)<br>    websockets_enabled                = optional(bool)<br>    worker_count                      = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | (Optional) A key-value pair of App Settings. | `map(string)` | `null` | no |
| <a name="input_auth_settings"></a> [auth\_settings](#input\_auth\_settings) | (Optional) A auth\_settings block. | <pre>object({<br>    enabled = bool<br>    active_directory = optional(object({<br>      client_id                  = string<br>      allowed_audiences          = list(string)<br>      client_secret              = optional(string)<br>      client_secret_setting_name = optional(string)<br>    }))<br>    additional_login_parameters    = optional(list(map(any)))<br>    allowed_external_redirect_urls = optional(list(string))<br>    default_provider               = optional(string)<br>    facebook = optional(object({<br>      app_id                  = string<br>      app_secret              = optional(string)<br>      app_secret_setting_name = optional(string)<br>      oauth_scopes            = optional(list(string))<br>    }))<br>    github = optional(object({<br>      client_id                  = string<br>      client_secret              = optional(string)<br>      client_secret_setting_name = optional(string)<br>      oauth_scopes               = optional(list(string))<br>    }))<br>    google = optional(object({<br>      client_id                  = string<br>      client_secret              = optional(string)<br>      client_secret_setting_name = optional(string)<br>      oauth_scopes               = optional(list(string))<br>    }))<br>    issuer = optional(string)<br>    microsoft = optional(object({<br>      client_id                  = string<br>      client_secret              = optional(string)<br>      client_secret_setting_name = optional(string)<br>      oauth_scopes               = optional(list(string))<br>    }))<br>    runtime_version               = optional(string)<br>    token_refresh_extension_hours = optional(number)<br>    token_store_enabled           = optional(bool)<br>    twitter = optional(object({<br>      consumer_key                 = string<br>      consumer_secret              = optional(string)<br>      consumer_secret_setting_name = optional(string)<br>    }))<br>    unauthenticated_client_action = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_auth_settings_v2"></a> [auth\_settings\_v2](#input\_auth\_settings\_v2) | (Optional) A auth\_settings\_v2 block. | <pre>object({<br>    auth_enabled                            = optional(bool)<br>    runtime_version                         = optional(string)<br>    config_file_path                        = optional(string)<br>    require_authentication                  = optional(bool)<br>    unauthenticated_action                  = optional(string)<br>    default_provider                        = optional(string)<br>    excluded_paths                          = optional(list(string))<br>    require_https                           = optional(bool)<br>    http_route_api_prefix                   = optional(string)<br>    forward_proxy_convention                = optional(string)<br>    forward_proxy_custom_host_header_name   = optional(string)<br>    forward_proxy_custom_scheme_header_name = optional(string)<br>    apple_v2 = optional(object({<br>      client_id                  = string<br>      client_secret_setting_name = optional(string)<br>      login_scopes               = optional(list(string))<br>    }))<br>    active_directory_v2 = optional(object({<br>      client_id                            = string<br>      tenant_auth_endpoint                 = optional(string)<br>      client_secret_setting_name           = optional(string)<br>      client_secret_certificate_thumbprint = optional(string)<br>      jwt_allowed_groups                   = optional(list(string))<br>      jwt_allowed_client_applications      = optional(list(string))<br>      www_authentication_disabled          = optional(bool)<br>      allowed_groups                       = optional(list(string))<br>      allowed_identities                   = optional(list(string))<br>      allowed_applications                 = optional(list(string))<br>      login_parameters                     = optional(map(any))<br>      allowed_audiences                    = optional(list(string))<br>    }))<br>    azure_static_web_app_v2 = optional(object({<br>      client_id = string<br>    }))<br>    custom_oidc_v2 = optional(object({<br>      name                          = string<br>      client_id                     = string<br>      openid_configuration_endpoint = string<br>      name_claim_type               = optional(string)<br>      scopes                        = optional(list(string))<br>      client_credential_method      = string<br>      client_secret_setting_name    = optional(string)<br>      authorisation_endpoint        = string<br>      token_endpoint                = string<br>      issuer_endpoint               = string<br>      certification_uri             = string<br>    }))<br>    facebook_v2 = optional(object({<br>      app_id                  = string<br>      app_secret_setting_name = string<br>      graph_api_version       = optional(string)<br>      login_scopes            = optional(list(string))<br>    }))<br>    github_v2 = optional(object({<br>      client_id                  = string<br>      client_secret_setting_name = string<br>      login_scopes               = optional(list(string))<br>    }))<br>    google_v2 = optional(object({<br>      client_id                  = string<br>      client_secret_setting_name = string<br>      allowed_audiences          = optional(list(string))<br>      login_scopes               = optional(list(string))<br>    }))<br>    microsoft_v2 = optional(object({<br>      client_id                  = string<br>      client_secret_setting_name = string<br>      allowed_audiences          = optional(list(string))<br>      login_scopes               = optional(list(string))<br>    }))<br>    twitter_v2 = optional(object({<br>      consumer_key                 = string<br>      consumer_secret_setting_name = string<br>    }))<br>    login = optional(object({<br>      logout_endpoint                   = optional(string)<br>      token_store_enabled               = optional(bool)<br>      token_refresh_extension_time      = optional(number)<br>      token_store_path                  = optional(string)<br>      token_store_sas_setting_name      = optional(string)<br>      preserve_url_fragments_for_logins = optional(bool)<br>      allowed_external_redirect_urls    = optional(list(string))<br>      cookie_expiration_convention      = optional(string)<br>      cookie_expiration_time            = optional(string)<br>      validate_nonce                    = optional(bool)<br>      nonce_expiration_time             = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | (Optional) A backup block. | <pre>object({<br>    name = string<br>    schedule = object({<br>      frequency_interval       = number<br>      frequency_unit           = string<br>      keep_at_least_one_backup = optional(bool)<br>      retention_period_days    = optional(number)<br>      start_time               = optional(string)<br>      last_execution_time      = optional(string)<br>    })<br>    storage_account_url = string<br>    enabled             = optional(bool, true)<br>  })</pre> | `null` | no |
| <a name="input_builtin_logging_enabled"></a> [builtin\_logging\_enabled](#input\_builtin\_logging\_enabled) | (Optional) Specifies whether built-in logging is enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_client_certificate_enabled"></a> [client\_certificate\_enabled](#input\_client\_certificate\_enabled) | (Optional) Specifies whether client certificate authentication is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_client_certificate_mode"></a> [client\_certificate\_mode](#input\_client\_certificate\_mode) | (Optional) The mode of the Function App Slot's client certificates requirement for incoming requests. Possible values are Required, Optional, and OptionalInteractiveUser. Defaults to Optional. | `string` | `"Optional"` | no |
| <a name="input_client_certificate_exclusion_paths"></a> [client\_certificate\_exclusion\_paths](#input\_client\_certificate\_exclusion\_paths) | (Optional) A list of paths to exclude from client certificate authentication. Paths separated by ;. | `string` | `null` | no |
| <a name="input_connection_string"></a> [connection\_string](#input\_connection\_string) | (Optional) A connection\_string block. | <pre>object({<br>    name  = string<br>    type  = string<br>    value = string<br>  })</pre> | `null` | no |
| <a name="input_content_share_force_disabled"></a> [content\_share\_force\_disabled](#input\_content\_share\_force\_disabled) | (Optional) Specifies whether the content share feature is disabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_daily_memory_time_quota"></a> [daily\_memory\_time\_quota](#input\_daily\_memory\_time\_quota) | (Optional) The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps in Consumption Plans. Defaults to 0. | `number` | `0` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) Specifies whether the Function App Slot is enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_ftp_publish_basic_authentication_enabled"></a> [ftp\_publish\_basic\_authentication\_enabled](#input\_ftp\_publish\_basic\_authentication\_enabled) | (Optional) Specifies whether FTP deployment is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_functions_extension_version"></a> [functions\_extension\_version](#input\_functions\_extension\_version) | (Optional) The version of the Azure Functions runtime to use. Defaults to ~4. | `string` | `"~4"` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | (Optional) Specifies whether the Function App Slot requires HTTPS only. Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Specifies whether the Function App Slot is accessible from the public network. Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) A identity block. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | (Optional) The identity ID of the Key Vault reference. Required when identity.type is set to UserAssigned or SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | (Optional) Specifies the ID of the App Service Plan in which to create the Function App Slot. If not specified, the Function App Slot will be created in the same App Service Plan as the Function App. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_storage_account_access_key"></a> [storage\_account\_access\_key](#input\_storage\_account\_access\_key) | (Optional) The access key of the Storage Account to use for the Function App Slot. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Optional) The name of the Storage Account to use for the Function App Slot. | `string` | `null` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Optional) One or more storage\_account blocks. | <pre>list(object({<br>    access_key   = string<br>    account_name = string<br>    name         = string<br>    share_name   = string<br>    type         = string<br>    mount_path   = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_storage_uses_managed_identity"></a> [storage\_uses\_managed\_identity](#input\_storage\_uses\_managed\_identity) | (Optional) Specifies whether the Function App Slot uses a managed identity to access the Storage Account. Defaults to false. | `bool` | `false` | no |
| <a name="input_storage_key_vault_secret_id"></a> [storage\_key\_vault\_secret\_id](#input\_storage\_key\_vault\_secret\_id) | (Optional) The ID of the Key Vault secret containing the Storage Account access key. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `null` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | (Optional) The ID of the subnet in which to create the Function App Slot. | `string` | `null` | no |
| <a name="input_webdeploy_publish_basic_authentication_enabled"></a> [webdeploy\_publish\_basic\_authentication\_enabled](#input\_webdeploy\_publish\_basic\_authentication\_enabled) | (Optional) Specifies whether Web Deploy publishing is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | (Required) Specifies the operating system type of the Function App Slot. Value must be one of Windows or Linux. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_windows_function_app_slot_name"></a> [windows\_function\_app\_slot\_name](#output\_windows\_function\_app\_slot\_name) | n/a |
| <a name="output_windows_function_app_slot_id"></a> [windows\_function\_app\_slot\_id](#output\_windows\_function\_app\_slot\_id) | n/a |
| <a name="output_windows_function_app_slot_default_hostname"></a> [windows\_function\_app\_slot\_default\_hostname](#output\_windows\_function\_app\_slot\_default\_hostname) | n/a |
| <a name="output_windows_function_app_slot_possible_outbound_ip_address_list"></a> [windows\_function\_app\_slot\_possible\_outbound\_ip\_address\_list](#output\_windows\_function\_app\_slot\_possible\_outbound\_ip\_address\_list) | n/a |
| <a name="output_windows_function_app_slot_kind"></a> [windows\_function\_app\_slot\_kind](#output\_windows\_function\_app\_slot\_kind) | n/a |
| <a name="output_windows_function_app_slot_custom_domain_verification_id"></a> [windows\_function\_app\_slot\_custom\_domain\_verification\_id](#output\_windows\_function\_app\_slot\_custom\_domain\_verification\_id) | n/a |
| <a name="output_linux_function_app_slot_name"></a> [linux\_function\_app\_slot\_name](#output\_linux\_function\_app\_slot\_name) | n/a |
| <a name="output_linux_function_app_slot_id"></a> [linux\_function\_app\_slot\_id](#output\_linux\_function\_app\_slot\_id) | n/a |
| <a name="output_linux_function_app_slot_default_hostname"></a> [linux\_function\_app\_slot\_default\_hostname](#output\_linux\_function\_app\_slot\_default\_hostname) | n/a |
| <a name="output_linux_function_app_slot_possible_outbound_ip_address_list"></a> [linux\_function\_app\_slot\_possible\_outbound\_ip\_address\_list](#output\_linux\_function\_app\_slot\_possible\_outbound\_ip\_address\_list) | n/a |
| <a name="output_linux_function_app_slot_kind"></a> [linux\_function\_app\_slot\_kind](#output\_linux\_function\_app\_slot\_kind) | n/a |
| <a name="output_linux_function_app_slot_custom_domain_verification_id"></a> [linux\_function\_app\_slot\_custom\_domain\_verification\_id](#output\_linux\_function\_app\_slot\_custom\_domain\_verification\_id) | n/a |
| <a name="output_function_app_slot_name"></a> [function\_app\_slot\_name](#output\_function\_app\_slot\_name) | The name of the Function App Slot. |
| <a name="output_function_app_slot_id"></a> [function\_app\_slot\_id](#output\_function\_app\_slot\_id) | The ID of the Function App Slot. |
| <a name="output_function_app_slot_default_hostname"></a> [function\_app\_slot\_default\_hostname](#output\_function\_app\_slot\_default\_hostname) | The default hostname of the Function App Slot. |
| <a name="output_function_app_slot_possible_outbound_ip_address_list"></a> [function\_app\_slot\_possible\_outbound\_ip\_address\_list](#output\_function\_app\_slot\_possible\_outbound\_ip\_address\_list) | The possible outbound IP addresses of the Function App Slot. |
| <a name="output_function_app_slot_kind"></a> [function\_app\_slot\_kind](#output\_function\_app\_slot\_kind) | The kind of the Function App Slot. |
| <a name="output_function_app_slot_custom_domain_verification_id"></a> [function\_app\_slot\_custom\_domain\_verification\_id](#output\_function\_app\_slot\_custom\_domain\_verification\_id) | The custom domain verification ID of the Function App Slot. |
<!-- END_TF_DOCS -->
