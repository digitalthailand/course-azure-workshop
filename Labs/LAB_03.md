# Module 3: Implementing virtual machines
# Lab A: Creating Azure virtual machines
  
### Scenario
  
 As part of the planning for deployment of Azure Resource Manager virtual machines to Azure, A. Datum has evaluated its deployment options. You must use the Azure portal and Azure PowerShell to deploy two Windows virtual machines for the Database tier of the Research and Development application. Additionally, to facilitate resource tracking, you should ensure that the virtual machines are part of the same resource group.


### Objectives
  
 After completing this lab, you will be able to:

- Create virtual machines by using the Azure portal and Azure PowerShell.

- Validate virtual-machine creation.


### Lab Setup
  
 Estimated Time: 35 minutes


## Exercise 1: Creating virtual machines by using the Azure portal and Azure PowerShell
  
### Scenario
  
 You must deploy two virtual machines that will be running Windows Server 2016 Datacenter. Name these machines ResDevDB1 and ResDevDB2, and use them as database servers for the Research and Development app, ResDev. You will use the Azure portal to deploy one of the virtual machines, and you will use Azure PowerShell to deploy the other VM. You must deploy both virtual machines into the 20533C0301-LabRG resource group, and you must configure the virtual machines to use the database subnet of the HQ-VNET virtual network. After deploying the virtual machines, you will confirm that the virtual machines are deployed to the correct resource group and are on the database subnet.

The main tasks for this exercise are as follows:

1. Use the Azure portal to create a virtual machine

2. Use Azure PowerShell to create a virtual machine



#### Task 1: Use the Azure portal to create a virtual machine
  
1. On MIA-CL1, in Internet Explorer, navigate to the Azure portal.

2. Sign in using the Microsoft account that is either the Service Administrator or Co-administrator of your subscription.

3. From the Azure portal, create an Azure Resource Manager virtual machine based on the Windows Server 2016 Datacenter operating system image with the following parameters:


  - Name: **ResDevDB1**

  - VM disk type: **HDD**

  - User name: **Student**

  - Password: **Pa55w.rd1234**

  - Subscription: _Your subscription_

  - Resource group: use the existing resource group named **20533C0301-LabRG**

  - Location: _accept the default location, which should match the location of the resource group_

  - Size: **D1_V2 Standard**

  - Use managed disks: **No**

  - Network name: **HQ-VNET**

  - Subnet name: **Database**
  
  - Boot diagnostics: **Disabled**.

  - Guest OS diagnostics: **Disabled**.


#### Task 2: Use Azure PowerShell to create a virtual machine
  
1. On MIA-CL1, open a Windows PowerShell Integrated Scripting Environment (ISE) window.

2. In the Windows PowerShell ISE, open the script D:\\Labfiles\\Lab03\\Starter\\New-AzureRm20533C03VM.ps1 and review its content.

3. Run the script. 

4. When prompted to sign in, type the name of the account that is either the Service Administrator or a Co-administrator of your Azure subscription.

5. If you have multiple subscriptions, select the one you used when running **Setup-Azure** at the beginning of this module.

6. When the script is complete, leave the Windows PowerShell ISE window open.


> **Result**: After completing this exercise, you have created virtual machines by using the Azure portal and Azure PowerShell.


## Exercise 2: Validating virtual-machine creation
  
### Scenario
  
 You now must validate the creation and configuration of the virtual machines that you created to ensure that they function properly.

The main tasks for this exercise are as follows:

1. Use Azure PowerShell to validate virtual machine deployment

2. Use the Azure portal to validate virtual machine deployment



#### Task 1: Use Azure PowerShell to validate virtual machine deployment
  
1. In the Windows PowerShell ISE window, at the command prompt, run the following command:

  ```
  Get-AzureRmResource | Where-Object ResourceType -like "*VirtualMachines"
  ```

2. Confirm that the ResDevDB1 and the ResDevDB2 virtual machines are listed. Note that both virtual machines belong to the 20533C0301-LabRG resource group.

3. Close the Windows PowerShell ISE window.


#### Task 2: Use the Azure portal to validate virtual machine deployment
  
1. On MIA-CL1, in the Internet Explorer window, in the Azure portal, view the virtual machine resources. 

2. Confirm that both ResDevDB1 and ResDevDB2 have been created, that they belong to the **20533C0301-LabRG** resource group, and that they reside on the **Database** subnet of the **HQ-VNET** virtual network.


> **Result**: After completing this exercise, you will have validated the creation and configuration of Azure Virtual Machines.



**Question** 
What storage related differences did you notice when you created a virtual machine in the Azure portal versus in Azure PowerShell?


# Lab B: Deploying Azure Resource Manager virtual machines by using Azure Resource Manager templates
  
### Scenario
  
 You must use an Azure Resource Manager template to deploy two additional Linux virtual machines and two additional Windows virtual machines that the ResDev application will use. The virtual machines should be part of the 20533C0301-LabRG resource group, to facilitate resource tracking. Linux virtual machines should reside on the app subnet of the HQ-VNET virtual network, and Windows virtual machines should reside on the web subnet of the HQ-VNET virtual network.


### Objectives
  
 After completing this lab, you must be able to:

- Use Visual Studio and an Azure Resource Manager template to deploy Azure Resource Manager virtual machines.

- Use Azure PowerShell and an Azure Resource Manager template to deploy virtual machines.


### Lab Setup
  
 Estimated Time: 25 minutes

 Virtual machine: **20533C-MIA-CL1**

 User name: **Student**

 Password: **Pa55w.rd**

 The virtual machine should be running from the previous lab.


## Exercise 1: Using Visual Studio and an Azure Resource Manager template to deploy Azure Resource Manager virtual machines
  
### Scenario
  
 You must use Visual Studio to deploy two Linux Azure Resource Manager virtual machines for use as app servers in the ResDev app. You should name the servers ResDevApp1 and ResDevApp2. You have a deployment-template solution and the deployment details for both virtual machines. You must deploy the two virtual machines from Visual Studio, and then confirm that the virtual machines have been deployed successfully by using Azure PowerShell.

The main tasks for this exercise are as follows:

1. Use Visual Studio to deploy the Linux app server's virtual machines

2. Use Azure PowerShell to validate the deployment of the app server's virtual machines



#### Task 1: Use Visual Studio to deploy the Linux app server's virtual machines
  
1. On MIA-CL1, on the taskbar, click the **Visual Studio** icon. If prompted with the message that the evaluation period has ended, click the **Sign in** and provide your Microsoft account credentials. Then, on the **Host your next project in Visual Studio Team Services** page, click the **Not now, maybe later** link. Next, click **Close**.

2. In Visual Studio, open the solution **ResDevLinuxDeploy.sln** from D:\\Labfiles\\Lab03\\Starter\\ResDev\\ResDevLinuxDeploy. 

3. View the contents of the **azuredeploy.json** template.

4. From the Solution Explorer, start a new deployment process for the first virtual machine.

5. Deploy a new virtual machine into the **20533C0301-LabRG** resource group, by using the following parameter values:


  - vmName: **ResDevApp1**

  - adminUsername: **Student**

  - adminPassword: **Pa55w.rd1234**

  - virtualNetworkName: **HQ-VNET**

  - resourceGroupName: **20533C0301-LabRG**

  - subnetName: **App**

  - vmSize: **Standard_D1_V2**

  - ubuntuOSVersion: choose the most recent version

  - storageAccountType: **Standard_LRS**

> **Note:** Deployment will run with the output that appears in the Output pane, which is at the bottom of the window. When deployment is complete, you will receive a message stating that the template was deployed successfully to the resource group 20533C0301-LabRG.

6. View the contents of the Azuredeploy.parameters.json file to see that the parameters that you entered have been saved in this file.

7. Start another deployment process by using the deployment that you used for the first virtual machine. 

8. Repeat step 4, changing only the following parameter:


  - vmName: **ResDevApp2

> **Note:** Deployment will run with the output that appears in the Output pane, which is at the bottom of the window. When deployment is complete, you will receive a message stating the template was deployed successfully to the resource group 20533C0301-LabRG.

9. Close the solution but leave Visual Studio open.



#### Task 2: Use Azure PowerShell to validate the deployment of the app server's virtual machines
  
1. On MIA-CL1, open a new Windows PowerShell ISE window as Administrator.

2. Sign in to your Azure subscription with an account that is either the Service Administrator or Co-administrator of your Azure subscription by using the following cmdlet:
  ```
  Login-AzureRmAccount
  ```

3. If you have multiple subscriptions associated with your account, at the Windows PowerShell ISE prompt, run the following cmdlet: 

  ```
  Get-AzureRmSubscription
  ```

4. Identify the Id of the Azure subscription to which you deployed virtual machines in the previous task of this exercise, type in the following cmdlet, and then press Enter (replace  _'subscriptionId'_ with the actual SubscriptionId property of your subscription):

  ```
  Set-AzureRmContext -SubscriptionId 'subscriptionId'
  ```

5. In the Windows PowerShell ISE, at the command prompt, run the following cmdlet:

  ```
  Find-AzureRMResource -ResourceGroupNameContains 20533C0301-LabRG | Format-Table -Property ResourceName, ResourceType
  ```

6. In the cmdlet output, note the resources created in this exercise including **ResDevApp1** virtual machine, a NIC, a public IP, and a storage account.

7. Leave the Windows PowerShell ISE window open for the next exercise.


> **Result**: After completing this exercise, you will have deployed Azure Virtual Machines by using Visual Studio and an Azure Resource Manager template.


## Exercise 2: Using Azure PowerShell and an Azure Resource Manager template to deploy virtual machines
  
### Scenario
  
 You must deploy the Web tier virtual machines by using an Azure Resource Manager template and the Azure portal. The Web tier should consist of two virtual machines that are running Windows Server 2016, ResDevWeb1 and ResDevWeb2. You should deploy them to the 20533C0301-LabRG resource group, and then host them on the web subnet of the HQ-VNet virtual network. You have a template and a Windows PowerShell script that you should edit to complete the deployment. After you deploy the virtual machines, confirm the deployment by viewing the newly deployed resources in the Azure portal.

The main tasks for this exercise are as follows:

1. Use Azure PowerShell to deploy the Windows virtual machines 

2. Use the Azure portal to validate deployment of the Windows virtual machines

3. Reset the environment



#### Task 1: Use Azure PowerShell to deploy the Windows virtual machines
  
1. In the Windows PowerShell ISE window that you opened in the previous exercise, open D:\\Labfiles\\Lab03\\Starter\\ResDev\\ResDevWindowsDeploy.ps1

2. Review the script that will initiate the template.
> **Note:** Note the $templateFile and $rgName variables. These represent the location of the Azure Resource Manager template file and the resource group to which you will deploy the virtual machines.

3. Switch to Visual Studio and open the file D:\\Labfiles\\Lab03\\Starter\\ResDev\\ResDevWindowsDeployTemplate.json. 
> **Note:** Note that the template has the same structure as the template for the Linux virtual machines in the previous exercise. The only difference between the two templates is the variables declaring the image and operating system details.

4. Close Visual Studio.

5. Switch back to the Windows PowerShell ISE window and run the **ResDevWindowsDeploy.ps1** script. When prompted, provide the following values:


  - vmName: **ResDevWeb1**

  - adminUsername: **Student**

  - adminPassword: **Pa55w.rd1234**

  - virtualNetworkName: **HQ-VNET**

  - subnetName: **Web**


6. When the script completes, repeat step 5, changing only the value of the vmName parameter to **ResDevWeb2**



#### Task 2: Use the Azure portal to validate deployment of the Windows virtual machines
  
1. In Internet Explorer, in the Azure portal, navigate to the blade of the **20533C0301-LabRG** resource group.

2. On the 20533C0301-LabRG resource group blade, view the full list of its resources.
> **Note:** Note the virtual machines, as well as the NIC and public IP resources for each virtual machine.

3. View the details for the ResDevWeb1 virtual machine. On the ResDevWeb1 blade, note that ResDevWeb1 has been assigned to the **HQ-VNet/Web** virtual network/subnet, and the operating system is **Windows**.

4. Close Internet Explorer.



#### Task 3: Reset the environment
  
1. Close all open applications without saving any files.

2. On the taskbar, right-click **Windows PowerShell**, and then click **Run as administrator**. In the User Account Control dialog, click **Yes**.

3. Type the following command, and then press Enter:

  ```
  Reset-Azure
  ```

4. When prompted, sign in (twice) by using the Microsoft account associated with your Azure subscription.

5. If you have multiple Azure subscriptions, select the one you want to target with the script.

6. When prompted for confirmation, type **y**.

> **Note:** This script might remove Azure services in your subscription. Therefore, we recommend that you use an Azure trial pass that was provisioned specifically for this course, and not your own Azure account.
> The script will take 5-10 minutes to reset your Microsoft Azure environment, and prepare it for the next lab. 
> The script removes all storage, VMs, virtual networks and gateways, cloud services, and resource groups.
> **Important**: The script might not be able to get exclusive access to a storage account to delete it (you will see an error, if this occurs). If you still find objects after the reset script is complete, you can rerun the **Reset-Azure** script, or use the full Azure portal to manually delete all the objects in your Azure subscription, with the exception of the default directory.

> **Result**: After completing this exercise, you will have deployed Azure Virtual Machines by using Windows PowerShell and a Resource Manager template.



**Question** 
Can you use the same template to deploy a virtual machine from Visual Studio and from Windows PowerShell?

**Question** 
How would you configure an Azure Resource Manager template to deploy multiple virtual machines with different settings?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.
