$storageAccountName = '<your_storage_account_name>'
$shareName = 'assets'
$directoryName = 'invoices'
$resourceGroupName = '20533C0602-LabRG'

# Get the storage account key and context
$storageAccountKey = (Get-AzureRmStorageAccountKey -StorageAccountName $storageAccountName -ResourceGroupName $resourceGroupName)[0].Value
$context = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Create an Azure Storage file share
$share = New-AzureStorageShare -Name $shareName -Context $context

# Create a new directory in the share
$directory = New-AzureStorageDirectory -Share $share -Path $directoryName

# Set the local source folder
$sourceFolder = 'D:\LabFiles\Lab06\Starter\invoices'

# Upload each file in the local folder to the directory in the share
$files = Get-ChildItem -Path $sourceFolder -File
foreach ($file in $files) { Set-AzureStorageFileContent -Share $share -Source "$sourcefolder\$file" -Path $directoryName}