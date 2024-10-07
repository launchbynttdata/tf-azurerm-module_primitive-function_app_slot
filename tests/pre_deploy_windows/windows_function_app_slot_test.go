// terratest go test to create a plan for the deployment of a function app with a windows-based slot using the module in the root
// of the repository. The test will create a plan based on the terraform module in the examples/complete_windows_plan_only directory.
// The test will not apply the plan, but only test the plan file against the variables provided in the examples/complete_windows_plan_only/test.tfvars file.

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

const testModulePath = "../../examples/complete_windows_plan_only"

func TestWindowsFunctionAppSlotPlan(t *testing.T) {
	t.Parallel()

	planFilePath := testModulePath + "/terraform.tfplan"

	// Define the path to the Terraform code that will be tested.
	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: testModulePath,

		// Variables to pass to our Terraform code using -var options
		VarFiles:     []string{testModulePath + "/test.tfvars"},
		PlanFilePath: planFilePath,
	}
	// Run "terraform init" and "terraform plan" and fail the test if there are any errors.n
	plan := terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)

	// Validate the plan
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.resource_group.azurerm_resource_group.resource_group")
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "module.function_app_slot.azurerm_windows_function_app_slot.main[0]")
	siteConfig := plan.ResourcePlannedValuesMap["module.function_app_slot.azurerm_windows_function_app_slot.main[0]"].AttributeValues["site_config"].([]interface{})
	require.NotEmpty(t, siteConfig)
	siteConfigMap := siteConfig[0].(map[string]interface{})
	require.NotEmpty(t, siteConfigMap)
	require.Equal(t, siteConfigMap["api_definition_url"], "https://api.example.com/windows_swagger.json")
	require.Equal(t, siteConfigMap["always_on"], true)
	require.Equal(t, siteConfigMap["app_command_line"], "dotnet MyApplication.dll")
	require.Equal(t, siteConfigMap["app_service_logs"], []interface{}([]interface{}{map[string]interface{}{"disk_quota_mb": float64(73), "retention_period_days": float64(7)}}))
	require.Equal(t, siteConfigMap["health_check_path"], "/healthz")
	require.Equal(t, siteConfigMap["application_stack"], []interface{}{map[string]interface{}{"dotnet_version": "v8.0", "java_version": interface{}(nil), "node_version": interface{}(nil), "powershell_core_version": interface{}(nil)}})
	slotBackup := plan.ResourcePlannedValuesMap["module.function_app_slot.azurerm_windows_function_app_slot.main[0]"].AttributeValues["backup"].([]interface{})
	require.NotEmpty(t, slotBackup)
	slotBackupMap := slotBackup[0].(map[string]interface{})
	require.NotEmpty(t, slotBackupMap)
	require.Equal(t, slotBackupMap["enabled"], true)
	require.Equal(t, slotBackupMap["name"], "slotbackup")
	require.Equal(t, slotBackupMap["schedule"], []interface{}{map[string]interface{}{"frequency_interval": float64(1), "frequency_unit": "Day", "keep_at_least_one_backup": true, "retention_period_days": float64(7)}})
}
