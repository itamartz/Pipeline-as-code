# Pipeline-as-code
Continuous Delivery with Jenkins, Kubernetes, and Terraform

## Github Book ##
https://github.com/mlabouardy/pipeline-as-code-with-jenkins

## VSCode Plugins ##
https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform
https://marketplace.visualstudio.com/items?itemName=4ops.packer

## Packer 
Packer v1.10.0

## Terraform
Terraform v1.6.4
hashicorp/aws v5.36.0
hashicorp/http v3.4.1

## AWS
Region:  us-west-2
Route53: ammaso.net (11.00 USD)
AIM:     2 Images

## Bastion
ssh -L 4000:10.0.0.73:22 ec2-user@54.190.188.219
ssh ec2-user@localhost -p 4000

## puttygen
use puttygen to convert ppk to id_dsa and id_rsa.pub

## manning
https://livebook.manning.com/book/pipeline-as-code/chapter-4/178

## powershell
Install-Module -Name AWSPowerShell -Force

$Region = 'us-west-2'

$List = New-Object System.Collections.Generic.List[string]
$List.Add('jenkins-master')

$Filter = [Amazon.EC2.Model.Filter]::new('tag:name',$List)
$EC2Image = Get-EC2Image -Owner self -Region $Region -Filter $Filter
$EC2Image | Unregister-EC2Image -Region $Region

Get-EC2Snapshot -Region $Region -OwnerId 887234254276
Remove-EC2Snapshot -SnapshotId $EC2Image.BlockDeviceMapping.ebs.SnapshotId -Region $Region -Confirm:$false -ErrorAction SilentlyContinue -Verbose