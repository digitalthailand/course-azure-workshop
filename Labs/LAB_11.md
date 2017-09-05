# Module 11: Implementing Azure-based management and automation
# Lab: Implementing Automation
  
### Scenario
  
 A. Datum Corporation wishes to minimize administrative overhead as much as possible, especially for tasks such as deploying and deprovisioning VMs. For this reason, as part of A. Datum's evaluation of Microsoft Azure, you have been asked to test the new Azure Automation features and, as part of your tests, manage Azure VMs by using runbook automation.


### Objectives
  
 After completing this lab, you will be able to:

- Configure Automation accounts.

- Create runbooks.


### Lab Setup
  
 Estimated Time: 40 minutes


## Exercise 1: Configuring Automation accounts
  
### Scenario
  
 Administrators at A. Datum Corporation spend considerable time managing Azure VMs. You want to increase administrator productivity by using Automation to execute such tasks as shuttting down Azure VMs at the end of the day.

The main tasks for this exercise are as follows:

1. Create an Automation account

2. Create and review Automation assets



#### Task 1: Create an Automation account
  
1. Ensure that you are signed in to MIA-CL1 as **Student** with the password **Pa55w.rd**, and that the setup script you ran in the previous demonstration to prepare the environment has completed.

2. Sign in to the Azure portal by using the Microsoft account that is the Service Administrator or a Co-Administrator of your Azure subscription. If necessary, in the Azure portal, switch to the Default Directory.

3. From the **Virtual machines** blade, note that **myVM0** and **myVM1** virtual machines are currently running.

4. Create a new Azure Automation account with the following settings:


  - Name: **LabAutomationAccount**

  - Subscription: _your current subscription_

  - Resource group: create a new resource group **20533C1102-LabRG**

  - Location: _an Azure region that you chose when running **Setup-Azure** or, if not available, another region close to it_

  - Create Azure Run As account: **Yes**


5. Wait for the Automation account to be provisioned. This should take less than a minute.



#### Task 2: Create and review Automation assets
  
1. In the Azure portal, from the **LabAutomationAccount** blade, create the following Azure Automation non-encrypted string variables


  - Name: **VM0**

  - Description: **myVM0**

  - Value: **myVM0**


  - Name: **VM1**

  - Description: **myVM1**

  - Value: **myVM1**


  - Name: **ResourceGroup**

  - Description: **VM resource group**

  - Value: **20533C1101-LabRG**


2. In the same Automation account, create the following Schedule asset:


  - Name: **EndOfDay**

  - Description: **End of day**

  - Starts: _tomorrow's date at **6:00:00 PM** with the time zone of the Azure region containing the Automation account_

  - Recurrence: **Recurring**

  - Recur every: **1 Day**

  - Set expiration: **No**


3. In the list of assets, note two precreated connections **AzureClassicRunAsConnection** and **AzureRunAsConnection**. They were created automatically during provisioning of the Automation account since you selected the option to create the Azure Run As account.

> **Result**: After completing this exercise, you should have configured a new Azure Automation account, created Automation variable assets and Automation schedule asset, and reviewed the precreated Azure Automation connection assets


## Exercise 2: Creating and executing runbooks
  
### Scenario
  
 As part of your tests of the new Azure Automation features, you will now deploy Azure virtual machines by using an Automation runbook.

The main tasks for this exercise are as follows:

1. Import a runbook

2. Publish and execute a runbook

3. Reset the environment



#### Task 1: Import a runbook
  
1. From the Azure portal, import the PowerShell workflow script D:\\Labfiles\\Lab11\\Starter\\Stop-AzureRm20533C11VMs.ps1 into your Automation account.

2. Review the content of the runbook.



#### Task 2: Publish and execute a runbook
  
1. Publish the **Stop-AzureVMs-Workflow** runbook.

2. Start the newly published runbook.

3. View the progress of the runbook execution. Wait until the job completes.

4. From the Azure portal, verify that the of **myVM0** and **myVM1** virtual machines have been stopped.



#### Task 3: Reset the environment
  
1. Launch Windows PowerShell as **Administrator**.

2. From the Windows PowerShell prompt, run:

  ```
  Reset-Azure
  ```

3. When prompted (twice), sign in by using the Microsoft account that is the Service Administrator or a Co-Administrator of your Azure subscription. 

4. If you have multiple Azure subscriptions, select the one you want to target with the script.

5. When prompted for confirmation, type **y**.

> **Note:** This script will remove Azure services in your subscription. We therefore recommend that you use an Azure trial pass that was provisioned specifically for this course, and not your own Azure account.
> The script will take 5-10 minutes to reset your Microsoft Azure environment to be ready for the next lab. 
> The script removes all storage, VMs, virtual networks, cloud services, and resource groups.
> **Important**: The script might not be able to get exclusive access to a storage account to delete it (if this occurs, you will see an error). If you find remaining objects after the reset script is complete, you can rerun the **Reset-Azure** script, or use the Azure portal and Azure classic portal to delete all the objects in your Azure subscription manually with the exception of the default Azure AD tenant.

> **Result**: After completing this exercise, you should have imported, published, and executed a PowerShell workflow-based runbook that deploys two virtual machines in parallel.



**Question** 
What mechanism did you use to authenticate when accessing the Azure subscription when running the Azure Automation runbook in the lab?

**Question** 
What should you consider when testing the execution of an Automation runbook?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.

  
