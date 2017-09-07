$deploymentName	= "WebTierDeployment"


$templateFile	= "D:\Labfiles\Lab03\Starter\ResDev\ResDevWindowsDeployTemplate.json"


$rgName		= "20533C0301-LabRG"


New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $rgName -TemplateFile $templateFile
