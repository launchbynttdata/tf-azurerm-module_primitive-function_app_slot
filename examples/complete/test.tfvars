instance_env            = 0
instance_resource       = 0
logical_product_family  = "launch"
logical_product_service = "funcapp"
class_env               = "gotest"
location                = "eastus"
os_type                 = "Windows"
slot_site_config = {
  application_stack = {
    dotnet_version              = "v8.0"
    use_dotnet_isolated_runtime = true
    cors = {
      allowed_origins = [
        "https://www.example.com",
        "https://www.contoso.com",
        "http://localhost:8080"
      ]
      support_credentials = false
    }
    http2_enabled       = true
    minimum_tls_version = "1.2"
  }
}
