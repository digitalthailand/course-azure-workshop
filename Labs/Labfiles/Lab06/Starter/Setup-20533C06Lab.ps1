Param(
  [Parameter(Mandatory=$true,Position=1)]
    [String]$location
)

Set-Location -Path 'D:\Labfiles\Lab06\Starter'

$resourceGroup = New-AzureRmResourceGroup -Name '20533C0601-LabRG' -Location $location

New-AzureRmResourceGroupDeployment -Name 20533CLab06Setup -ResourceGroupName $resourceGroup.ResourceGroupName -TemplateFile 'D:\Labfiles\Lab06\Starter\Templates\azuredeploy.json' -TemplateParameterFile 'D:\Labfiles\Lab06\Starter\Templates\azuredeploy.parameters.json'