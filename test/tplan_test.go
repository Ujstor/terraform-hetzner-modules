package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"path/filepath"
	"testing"
)

const (
	server_plan                  = "Plan: 3 to add, 0 to change, 0 to destroy."
	firewall_plan                = "Plan: 4 to add, 0 to change, 0 to destroy."
	servers_network_plan         = "Plan: 22 to add, 0 to change, 0 to destroy."
	servers_volumes_plan         = "Plan: 11 to add, 0 to change, 0 to destroy."
	cluster_plan                 = "Plan: 37 to add, 0 to change, 0 to destroy."
	loadbalacer_k8s_cluster_plan = "Plan: 20 to add, 0 to change, 0 to destroy."
	floating_ip_plan             = "Plan: 10 to add, 0 to change, 0 to destroy."

	server_path                  = "../examples/server/"
	firewall_path                = "../examples/firewall/"
	servers_network_path         = "../examples/servers_network/"
	servers_volumes_path         = "../examples/servers_volumes/"
	cluster_path                 = "../examples/cluster/"
	loadbalacer_k8s_cluster_path = "../examples/loadbalancer_k8s_cluster/"
	floating_ip                  = "../examples/floating_ip/"
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

func TestTfPlanFirewall(t *testing.T) {
	runTerraformPlanHTest(t, firewall_path, firewall_plan)
}

func TestTfPlanServer(t *testing.T) {
	runTerraformPlanHTest(t, server_path, server_plan)
}

func TestTfPlanServerNetwork(t *testing.T) {
	runTerraformPlanHCTest(t, servers_network_path, servers_network_plan)
}

func TestTfPlanServerVolumes(t *testing.T) {
	runTerraformPlanHTest(t, servers_volumes_path, servers_volumes_plan)
}

func TestTfPlanCluster(t *testing.T) {
	runTerraformPlanHCTest(t, cluster_path, cluster_plan)
}

func TestTfPlanLbK8s(t *testing.T) {
	runTerraformPlanHCTest(t, loadbalacer_k8s_cluster_path, loadbalacer_k8s_cluster_plan)
}

func TestTfPlanFloatingIP(t *testing.T) {
	runTerraformPlanHTest(t, floating_ip, floating_ip_plan)
}
