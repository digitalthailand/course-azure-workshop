# Module 6: Planning and implementing storage, backup, and recovery services
# Lab: Planning and implementing Azure Storage
  
### Scenario
  
 The IT department at A. Datum Corporation uses an asset management application to track IT assets such as computer hardware and peripherals. The application stores images of asset types and invoices for asset purchases As part of A. Datum's evaluation of Azure, you need to test migration of these images and invoice documents to Azure storage. A. Datum also wants to evaluate Azure File storage for providing SMB 3.0 shared access to invoices. Currently, corporate file servers host this content. Additionally, A. Datum wants to evaluate the ability of Azure Backup to protect files and folders of on-premises computers.

### Objectives
  
 After completing this lab, you will be able to:

- Create and configure Azure Storage.

- Use Azure file storage.

- Protect data with Azure Backup.

### Lab Setup
  
 Estimated Time: 60 minutes

## Exercise 1: Creating and configuring Azure Storage
  
### Scenario
  
A. Datum currently stores images for IT assets on the on-premises file servers. As part of your Azure evaluation, you want to test storing these images as blobs in Azure storage so that a new Azure-based version of the asset management application can easily access them.

The main tasks for this exercise are as follows:

1. Create a storage account

2. Install AzCopy 

3. Use AzCopy to upload blobs

#### Task 1: Create a storage account
  
1. Ensure that you are signed in to the MIA-CL1 virtual machine as **Student** with the password **Pa55w.rd** and that the setup script that you ran in the "Preparing the environment" demonstration has completed.

2. Use Internet Explorer to sign in to the Azure portal by using the Microsoft account that is the Service Administrator or a Co-Administrator of your Azure subscription.

3. Create a new storage account with the following settings:

  - Name: a valid, unique name consisting of between 3 and 24 lower case characters or digits.

  - Deployment model: **Resource Manager**

  - Account kind: **General purpose**

  - Performance: **Standard**

  - Replication: **Locally-redundant storage (LRS)**

  - Storage service encryption: **Disabled**

  - Subscription: _the name of your Azure subscription_

  - Resource group: ensure that **Create new** is selected and, in the textbox below, type **20533C0602-LabRG**.

  - Location: _the same Azure region that you chose when runnng **Setup-Azure** at the beginning of this module_

  - Pin to dashboard: _clear the check box_

4. After the storage account creates, add a blob container named **asset-images** with private access.


#### Task 2: Install AzCopy
  
1. Download and install AzCopy from http://aka.ms/AzCopy. Note that this page also includes documentation and examples for using AzCopy.

2. Start Windows PowerShell ISE as Administrator.

3. In the console pane of Windows PowerShell ISE, change the current directory by running `Set-Location -Path 'C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy'`.

3. Test the installation by running the following command at a command prompt: 

  ```
  .\AzCopy /?
  ```

4. Keep the Windows PowerShell ISE window open for the next task.



#### Task 3: Use AzCopy to upload blobs
  

1. In the Windows PowerShell ISE window, type the following in the script pane:
  ```
  .\AzCopy /Dest:https://<Your-storage-account>.blob.core.windows.net/asset-images /destkey:<Your-access-key> /Source:D:\Labfiles\Lab06\Starter\asset-images
  ```

2. In the Azure portal, copy the name of the Storage account you created earlier in this exercise. 

3. In the script pane of the Windows PowerShell ISE, replace the `<Your-storage-account>` entry with the storage account name you copied from the Azure portal.

4. In the Azure portal, copy the first access key of the Storage account. 

5. In the script pane of the Windows PowerShell ISE, replace the `<Your-access-key>` entry with the storage account key you copied from the Azure portal.

6. Execute the command in the script pane and wait for the command to complete. Review the file transfer information.

7. In the Azure portal, navigate to the **asset-images** container blade and verify that the container contains six blobs.

> **Result**: At the end of this exercise, you should have created a new Azure storage account with a container named **asset-images** and copied files from your local computer to that container by using the **AzCopy** utility.


## Exercise 2: Using Azure File storage
  
### Scenario
  
 A. Datum currently stores invoices for IT assets on the on-premises file servers. As part of your evaluation of Azure, you want to test an upload of these files to a file share in your Azure storage account.

The main tasks for this exercise are as follows:

1. Create a file share and upload files

2. Access a file share from a VM



#### Task 1: Create a file share and upload files
  
1. Switch to the Windows PowerShell ISE window and run `Add-AzureRmAccount`. When prompted, sign in by using the Microsoft account that is either the Service Administrator or a Co-Administrator of your Microsoft Azure subscription. 

2. From the Windows PowerShell ISE, open D:\\Labfiles\\Lab06\\Starter\\New-FileShare_20533C06.ps1.

3. In the script pane, in the **$storageAccountName** variable declaration at the beginning, replace the `<your_storage_account_name>` value with the name of the Azure storage account that you created in the previous exercise.

4. Review the script, noting that it:

  - Sets the values of variables named **$shareName** and **$directoryName** for the file share and the directory to create in the Azure Storage account

  - Uses the **Get-AzureRmStorageAccountKey** cmdlet to retrieve the access key for your storage account.

  - Uses the **New-AzureStorageContext** cmdlet to create a security context for connections to the target storage account based on the key you retrieved

  - Uses the **New-AzureStorageShare** cmdlet to create an Azure Storage account file share

  - Uses the **New-AzureStorageDirectory** cmdlet to create a directory in the share

  - Sets the location of the folder hosting source files to be copied to the Azure Storage file share directory

  - Loops through the files in the source folder and uses the **Set-AzureStorageFileContent** cmdlet to copy each of them the folder in the Azure file share.

5. Run the script to upload the files.

6. Observe the script as it runs, and then view the output. When you finish, close Windows PowerShell ISE.



#### Task 2: Access a file share from a VM
  
1. Connect to the AdatumSvr06 VM in your Azure subscription via Remote Desktop by using the following credentials:

  - User name: **Student**
  - Password: **Pa55w.rd1234**

2. Once connected, on AdatumSvr06, turn off **IE Enhanced Security Configuration** for administrators. 

3. Use Internet Explorer to navigate to the Azure portal and, when prompted, sign in by using the Microsoft account that is the Service Administrator or a Co-Administrator of your Azure subscription.

4. In the Azure portal, browse to the storage account created in the previous exercise, and copy the `net use` command that needs to be run in order to connect to its file share you created in the previous task. 

5. In the Remote Desktop session, start Windows PowerShell ISE and paste the `net use` command into the script window. 

6. Modify the command you copied so by removing leading ` >` and replace `[drive letter]` with `*`.

7. In Windows PowerShell ISE, execute the command and verify it completed successfully by creating a **Z:** drive mapping. 

8. In the Command Prompt window, enter the following command to view the contents of the invoices folder in drive Z:, which is now mapped to the assets file share that you created in the previous task:

  ```
  Get-ChildItem -Path 'Z:\invoices'
  ```

9. Verify that invoices are listed.

10. Sign out of the AdatumSvr06 VM to end the remote desktop session.


> **Result**: At the end of this exercise, you should have created an Azure storage account file share named **assets** that contains a folder named **invoices** with copies of invoice documents. You should have also mapped a drive from an Azure VM to the Azure storage account file share.


## Exercise 3: Protecting data with Azure Backup
  
### Scenario
  
 A. Datum currently uses an on-premises backup solution. As part of your Azure evaluation, you want to test protection of on-premises asset image files and invoices by backing them up to the cloud. To accomplish this, you intend to use Azure Backup.

The main tasks for this exercise are as follows:

1. Create a recovery services vault

2. Configure the vault for on-premises backup

3. Install and configure the Azure Recovery Services Agent

4. Create a backup schedule

5. Run a backup

6: Stop backups and delete the Azure Recovery services vault

7. Reset the environment


#### Task 1: Create a recovery services vault
  
1. In Internet Explorer, open the Azure portal.

2. Create a new recovery services vault with the following settings:

  - Name: **adatumvault06**

  - Subscription: _the name of your Azure subscription_

  - Resource group: _create a new resource group named_ **20533C0603-LabRG**

  - Location: _the same Azure region that you chose when runnng **Setup-Azure** at the beginning of this module_

  - Pin to dashboard: _Ensure that the check box is cleared_

  Wait until the vault is provisioned. The Azure portal will automatically display its blade.


#### Task 2: Configure the vault for on-premises backup
  
1. In the Azure portal, configure the backup goal with the following settings:

- Where is your workload running?: **On-premises**

- What do you want to back up?: **Files and folders**

2. Click on **Click here to prepare your infrastructure for backup to Azure**. 


#### Task 3: Install and configure the Azure Recovery Services Agent
  
1. Download the **Microsoft Azure Recovery Services Agent** from the Azure portal and install it on MIA-CL1 with the default settings.

2. Download the vault credentials file from the Azure portal

3. Register MIA-CL1 with the vault. Prior to registration, generate a passphrase and store it in the D:\\Labfiles\\Lab06\\Starter folder.

4. At the end of the registration process, start the Azure Backup console and leave it open for the next task.



#### Task 4: Create a backup schedule
  
1. Use Azure Backup to schedule a daily backup to run at 4:30 AM and protect the following subfolders in the D:\\Labfiles\\Lab06\\Starter folder:

  - asset-images

  - invoices

2. Keep the defaults for the other backup settings.



#### Task 5: Run a backup
  
1. From the Microsoft Azure Backup console, run an on-demand backup.

2. From the Azure portal, verify that MIA-CL1 is registered with the Recovery Services vault and note the most recent backup items, which should include files and folders on the D: drive.



#### Task 6: Stop backups and delete the Azure Recovery services vault
  
1. From the Azure portal, in the Recovery Services vault, delete references to **mia-cl1.** 

2. From the Azure portal, delete the Recovery Services vault.



#### Task 7: Reset the environment
  
1. Open Windows PowerShell as an administrator.

2. At the Windows PowerShell command prompt, run the following command:

  ```
  Reset-Azure
  ```

3. When prompted (twice), sign in by using the Microsoft account that is either the Service Administrator or a Co-Administrator of your Microsoft Azure subscription.

4. If you have multiple Azure subscriptions, select the one that you want to target with the script.

5. When prompted for confirmation, type **y** and press Enter.

> **Note:** This script will remove Azure services in your subscription. We therefore recommended that you use an Azure trial pass that was provisioned specifically for this course, and not your own Azure account.
>  The script will take 5-10 minutes to reset your Azure environment, ready for the next lab. 
>  The script removes all storage, virtual machines, virtual networks, cloud services, and resource groups.
> **Note:** **Important**: The script might not be able to access a storage account to delete it (if this occurs, you will see an error). If you find objects remaining after the reset script is complete, you can rerun the **Reset-Azure** script, or you can use the Azure portal and the Azure classic portal to delete all the objects in your Azure subscription manuallyâ€”with the exception of the default directory.

> **Result**: At the end of this exercise, you should have created an Azure Recovery Services vault in your subscription, downloaded vault credentials, and installed the Azure Recovery Services agent on the MIA-CL1 lab computer. You should have backed up the contents of the asset-images and invoices folders to the Recovery Services vault.



**Question** 
The asset management application stores images of hardware components as blobs and invoices as files. If the application also needed to search the location of each asset by using an asset type, a unique asset number, and a text description of the location, what storage options should you consider?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.
