package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"path/filepath"
	"testing"
)

const (
	server_plan          = "Plan: 3 to add, 0 to change, 0 to destroy."
	servers_network_plan = "Plan: 21 to add, 0 to change, 0 to destroy."
	cluster_plan         = "Plan: 23 to add, 0 to change, 0 to destroy."
)

var (
	server_path          = "../examples/server/"
	servers_network_path = "../examples/servers_network/"
	cluster_path         = "../examples/cluster/"
)

// Hetzner
func runTerraformPlanHTest(t *testing.T, exampleDir string, expectedPlan string) {
	t.Helper()
	moduleDir, err := filepath.Abs(exampleDir)
	if err != nil {
		t.Fatal(err)
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: moduleDir,
		// VarFiles:     []string{filepath.Join(moduleDir, ".auto.tfvars")},
		Vars: map[string]interface{}{
			"hcloud_token": os.Getenv("HCLOUD_TOKEN"),
		},
		NoColor: true,
	})

	planResult := terraform.InitAndPlan(t, terraformOptions)
	assert.Contains(t, planResult, expectedPlan)
}

// Hetzner + Cloudflare
func runTerraformPlanHCTest(t *testing.T, exampleDir string, expectedPlan string) {
	t.Helper()
	moduleDir, err := filepath.Abs(exampleDir)
	if err != nil {
		t.Fatal(err)
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: moduleDir,
		// VarFiles:     []string{filepath.Join(moduleDir, ".auto.tfvars")},
		Vars: map[string]interface{}{
			"hcloud_token":         os.Getenv("HCLOUD_TOKEN"),
			"cloudflare_api_token": os.Getenv("CLOUDFLARE_API_TOKEN"),
			"cloudflare_zone_id":   os.Getenv("CLOUDFLARE_ZONE_ID"),
		},
		NoColor: true,
	})

	planResult := terraform.InitAndPlan(t, terraformOptions)
	assert.Contains(t, planResult, expectedPlan)
}

func TestTfPlanServer(t *testing.T) {
	runTerraformPlanHTest(t, server_path, server_plan)
}

func TestTfPlanServerNetwork(t *testing.T) {
	runTerraformPlanHCTest(t, servers_network_path, servers_network_plan)
}

func TestTfPlanCluster(t *testing.T) {
	runTerraformPlanHCTest(t, cluster_path, cluster_plan)
}