# Module 1: Introduction to Microsoft Azure
# Lab: Managing Microsoft Azure
  
### Scenario
  
A. Datum Corporation wants to expand their cloud presence by taking advantage of the benefits of Azure. You have been asked to explore the available Azure IaaS features by using the Azure portals and Windows PowerShell.


### Objectives
  
 After completing this lab, you will be able to:

- Use the Azure portals.

- Use Azure Resource Manager features via the Azure portal.

- Use Azure PowerShell.


### Lab Setup
  
 Estimated Time: 50 minutes


## Exercise 1: Using the Azure portals
  
### Scenario
  
You have been asked to explore the available browser-based Azure portals to assess how A. Datum Corporation will use them. In the Azure classic portal, you must confirm the domain name of your subscription for use in your testing.
In the Azure portal, you must observe the organization of resources and customize the interface to make your testing environment more accessible. In the account page of the Azure portal, you must view and download your current billing data and sign up for an available preview feature that you will use later in your testing.

 The main tasks for this exercise are as follows:

1. Use the Azure classic portal

2. Use the Azure portal

3. Use the Azure account portal

#### Task 1: Use the Azure classic portal
  
1. Sign in to the MIA-CL1 lab virtual machine as **Student** with the password **Pa55w.rd**.

2. Start Internet Explorer, browse to the Azure classic portal. Sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

3. In the Azure classic portal, view the default Azure Active Directory (AD) tenant and note the user account you just added. 

4. View the default domain name associated with your Azure AD tenant.

#### Task 2: Use the Azure portal

1. In Internet Explorer, navigate to the Azure portal. 

2. Edit dashboard by configuring the following settings

- set the size of the **All resources** tile to **4x6**.

- set the size of the **Azure health** tile to **4x4**.

- rearrange the remaining tiles by moving them to the left

3. Drag the **Azure health** tile up to the top of the dashboard until its top edge aligns with the top edge of the **All resources** tile.

4. Pin **Virtual machine scale sets** to the hub menu.

#### Task 3: Use the Azure account portal
  
1. In Internet Explorer, navigate to the account portal. If prompted, sign in by using the Microsoft account that is the Account Administrator of your Azure subscription.

2. On the summary page, review the billing summary for your subscription on the page.

3. Download the usage details in **Version 2 - Preview**.

4. View the contents of the file in Notepad. Note that this is intended to simply review its content – typically to analyze it in more details, you would use Microsoft Excel or other program capable of parsing csv files. The file might not include any data at this point if you have not yet deployed any resources into your subscription.


>  **Result**: After completing this exercise, you should have used the Azure portals.



## Exercise 2: Using the Azure Resource Manager features in the Azure portal
  
### Scenario
  
You have been asked to create some temporary resources in Azure to test the management capabilities available via the Azure portal. You must create a resource group in Azure, create a new resource in that resource group, assign a tag to to each, and finally grant access to both by using Role Based Acces Control. Your intention is to apply permissions on the resource group level.


The main tasks for this exercise are as follows:

1. Create and manage a resource group

2. Create Azure resources

3. Configure tagging

4. Configure RBAC


#### Task 1: Create and manage a resource group

1. In Internet Explorer, browse to the Azure portal. If prompted, sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

2. In the Azure portal, create a new resource group with the following settings:

  - Resource group name: **20533C0101-LabRG**

  - Subscription: the name of your Azure subscription

  - Resource group location: the closest Azure region (to your location)

#### Task 2: Create Azure resources

1. In the Azure portal, create a new **Route table** with the following settings:

  - Name: **AdatumRT01**

  - Subscription: the same Azure subscription in which you created the resource group

  - Resource group name: click **Use existing** and select **20533C0101-LabRG** from the drop-down list

  - Resource group location: this entry will be automatically populated once you select the resource group name

#### Task 3: Configure tagging

1. In the Azure portal, assign the following tag to the resource group and the resource you created earlier in this exercise:

- Key: **project**

- Value: **test**

2. In the Azure portal, view the list of resources with the tag **project : test** in your subscription. 

3. Pin the list of resources with the tag to dashboard and use the tile to view the list of resources again.

#### Task 4: Configure RBAC
  
1. In the Azure portal, navigate to the **20533C0101-LabRG** resource group.

2. From the resource group blade, grant the **Owner** role to a valid Microsoft account.

>  **Result**: After completing this exercise, you should have used the Azure Resource Manager features in the Azure portal.




## Exercise 3: Using Azure PowerShell
  
### Scenario
  
You have been asked to investigate the capabilities of Azure PowerShell for A. Datum Corporation. You must connect to your Azure subscription by using Azure PowerShell and then use Azure PowerShell to create a new resource group and move the resource you created in the previous exercise to the new resource group.

The main tasks for this exercise are as follows:

1. Connect Azure PowerShell to your Azure subscription

2. Manage Azure resources and resource groups by using Azure PowerShell

3. Reset the environment

## Exercise 3: Using Azure PowerShell
  
#### Task 1: Connect Azure PowerShell to your Azure subscription
  
1. On MIA-CL1, start a Windows PowerShell ISE as Administrator. 

2. From the Windows PowerShell Integrated Scripting Environment (ISE), sign in by using the Microsoft account that is the Service Administrator of your Azure subscription by running:
  ```
Login-AzureRmAccount
  ```

3. From the Windows PowerShell ISE window, retrieve your subscription details by running:
  ```
Get-AzureRmSubscription
  ```

4. From the Windows PowerShell ISE window, enumerate Azure resource providers, resource types, and the Azure regions where these resources are available by running:
  ```
Get-AzureRmResourceProvider
  ```

#### Task 2: Manage Azure resources and resource groups by using Azure PowerShell

1. In the Windows PowerShell ISE window, open the D:\\Labfiles\\Lab01\\Starter\\Start-AzureRm20553C01Lab.ps1 file.

2. In the **# Variables** section, note the values of predefined variables. They need to match the names of resource and the resource group you created in the previous exercise.

3. Under the line that states **# Identify the location of the resource group containing the resource**, add the following and execute the updated script:
  ```
$locName = (Get-AzureRmResourceGroup -Name $rg1Name).Location
  ```

4. Under the line that states **# Create a new resource group in the same location**, add and execute the following line:
  ```
$rg2 = New-AzureRmResourceGroup -Name $rg2Name -Location $locName
  ```

5. Under the line that states **# Retrieve an object representing the resource and store it in a variable**, add and execute the following line:
  ```
$res = Get-AzureRmResource -ResourceName $resName -ResourceGroupName $rg1Name
  ```

6. Under the line that states **# Move the resource to the new resource group**, add and execute the following line (click **Yes** when prompted whether you want to proceed):
  ```
Move-AzureRmResource -DestinationResourceGroupName $rg2Name -ResourceId $res.ResourceId
  ```

7. Wait for the move to complete (monitor the progress bar displayed in the Administrator: Windows PowerShell ISE window). Next, under the line that states **# View resources in the new resource group**, add and execute the following line:
  ```
Get-AzureRmResource | Where-Object ResourceGroupName -eq $rg2Name
  ```

#### Task 3: 

1. Close all open apps without saving any files.

2. Start Windows PowerShell as Administrator

3. From the Windows PowerShell sessoin, run:
  ```
Reset-Azure
  ```

4. When prompted (twice), sign in by using the Microsoft account that is the Service Administrator of your Azure subscription.

5. If you have multiple Azure subscriptions, select the one you want the script to target.

6. When prompted for confirmation, type **y**.

>  **Result**: After completing this exercise, you should have used Azure PowerShell to manage Azure resources and resource groups.


**Question** 
Why did you use Azure PowerShell cmdlets that contained **Rm** in the lab?



©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.
