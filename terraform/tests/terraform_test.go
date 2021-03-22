package tests

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"strings"
	"testing"
)

func TestTerraformAwsEnvironment(t *testing.T) {

	awsRegion := "eu-west-1"
	bucketName := strings.ToLower(fmt.Sprintf("my-bucket-%s", random.UniqueId()))
	securityGroupName := strings.ToLower(fmt.Sprintf("my-security-group-%s", random.UniqueId()))
	securityGroupDescription := strings.ToLower(fmt.Sprintf("security-group-description-%s", random.UniqueId()))

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"bucket_name":                bucketName,
			"security_group_name":        securityGroupName,
			"security_group_description": securityGroupDescription,
			"aws_region":                 awsRegion,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
		TerraformDir: "../environments/base-example",
	})
	// cleanup created resources at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// run terraform init & apply
	terraform.InitAndApply(t, terraformOptions)

	// Perform assertions regarding s3 bucket
	bucketNameResult := terraform.Output(t, terraformOptions, "bucket_name")
	bucketArnResult := terraform.Output(t, terraformOptions, "bucket_arn")
	expectedBucketArn := fmt.Sprintf("arn:aws:s3:::%s", bucketName)
	assert.Equal(t, expectedBucketArn, bucketArnResult)
	assert.Equal(t, bucketName, bucketNameResult)

	// Perform assertions regarding VPC
	vpcCidrResult := terraform.Output(t, terraformOptions, "vpc_cidr")
	assert.Equal(t, "10.0.0.0/16", vpcCidrResult)

	// Perform assertions regarding security group
	securityGroupNameResult := terraform.Output(t, terraformOptions, "security_group_name")
	assert.Equal(t, securityGroupName, securityGroupNameResult)

}
