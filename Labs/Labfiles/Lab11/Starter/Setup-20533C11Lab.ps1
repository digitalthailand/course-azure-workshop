Param(
  [Parameter(Mandatory=$true,Position=1)]
    [String]$location
)

Set-Location -Path 'D:\Labfiles\Lab10\Starter'

$resourceGroup = New-AzureRmResourceGroup -Name '20533C1101-LabRG' -Location $location

New-AzureRmResourceGroupDeployment -Name 20533CLab11Setup -ResourceGroupName $resourceGroup.ResourceGroupName -TemplateFile 'D:\Labfiles\Lab11\Starter\Templates\azuredeploy.json' -TemplateParameterFile 'D:\Labfiles\Lab11\Starter\Templates\azuredeploy.parameters.json'