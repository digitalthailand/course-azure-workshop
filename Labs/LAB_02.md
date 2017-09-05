# Module 2: Implementing and managing Azure networking
# Lab A: Using a deployment template and Azure PowerShell to implement Azure virtual networks
  
### Scenario
  
 A. Datum Corporation's Azure VMs currently uses a classic virtual network in the region corresponding to its branch office location. To prepare for deployment of Azure Resource Manager VMs in the Azure region corresponding to its headquarters location, A. Datum must deploy an Azure Resource Manager virtual network in that region. You determined this is a relatively straightforward process if you use an existing deployment template and modify its parameters during deployment. However, you want to also test deployment of a virtual network by using Azure PowerShell. In addition, you need to prepare your existing classic virtual network for establishing connectivity to the Azure Resource Manager virtual network by creating a virtual network gateway and deploy a test Azure Resource Manager VM to the virtual network deployed by using the template.


### Objectives
  
 After completing this lab, you will be able to:

- Create a virtual network by using deployment templates.

- Create a virtual network by using PowerShell.


### Lab Setup
  
 Estimated Time: 30 minutes


## Exercise 1: Creating an Azure virtual network by using a deployment template
  
### Scenario
  
 A. Datum intends to implement virtual networks for the A. Datum headquarters. You have been asked to test provisioning of a virtual network by using deployment templates from GitHub. 

The main tasks for this exercise are as follows:

1. Access the template on GitHub

2. Create a new template-based deployment by using the Azure portal

3. Perform the deployment from the Azure portal



#### Task 1: Access the template on GitHub
  
1. Ensure that you are logged on to MIA-CL1 as **Student** with the password **Pa55w.rd**.

2. Start Internet Explorer and browse to **http://aka.ms/Mt32e4**

3. Open a GitHub template that you can use to create a virtual network with two subnets. 



#### Task 2: Create a new template-based deployment by using the Azure portal
  
1. In Internet Explorer, under Virtual Network with two Subnets, click **Deploy to Azure**.

2. When prompted, sign in by using the Microsoft account that is either the Service Administrator or a Co-Administrator of your Azure subscription.

3. In the Azure portal, from the **Create a Virtual Network with two Subnets** blade, review content of the template.

4. Review the structure of the JSON file. Examine the placeholders for values that can be edited during the deployment. This template contains the following parameters that you can edit: _vnetName_, _vnetAddressPrefix_, _subnet1Name_, _subnet1Prefix_, _subnet2Name_, _subnet2Prefix_.

5. Review the content under **resources** to identify type of the resources, their names and properties.

6. Click **Discard** to close the Edit Template blade.

> **Note:** If the template fails to load into the Azure portal, navigate to the following URL:
        [http://aka.ms/Fpqovq](http://aka.ms/Fpqovq) . Then, select and copy all the text. Paste the copied text into the **Edit template** blade, and then perform steps 4 and 5 to review the template and close the Edit Template blade without making any changes.


#### Task 3: Perform the deployment from the Azure portal
  
1. From the **Create a Virtual Network with two Subnets** blade, deploy the template with the following settings:

  - Subscription: use the Azure subscription that you selected when running **Setup-Azure** at the beginning of this module

  - Resource group: create a new resource group named **20533C0201-LabRG**

  - Location: in the drop-down list, select the Azure region you want to deploy the template to

  - Vnet Name: **HQ**

  - Vnet Address Prefix: **10.0.0.0/16**

  - Subnet1Prefix: **10.0.0.0/24**

  - Subnet1Name: **Subnet1**

  - Subnet2Prefix: **10.0.1.0/24**

  - Subnet2Name: **Subnet2**

  - I agree to the terms and conditions stated above: enabled

2. Verify that provisioning of the new virtual network with name **HQ** completed successfully.


> **Result**: After completing this exercise, you should have created virtual networks for A. Datum HQ.


## Exercise 2: Creating a virtual network by using PowerShell
  
### Scenario
  
 A. Datum is expanding their services in Azure by using both declarative and imperative deployment methods and they ask you to test provisioning of a new network by using Azure PowerShell. 

The main tasks for this exercise are as follows:

1. Create a virtual network by using PowerShell


#### Task 1: Create a virtual network by using PowerShell
  
1. From the taskbar, start Windows PowerShell and sign in to your subscription by using the **Login-AzureRMAccount** command.

2. Select your subscription by using the **Set-AzureRMContext** command, and then use **New-AzureRMResourceGroup** command to create a new resource group named **20533C0202-LabRG** in the primary Azure region provided by the instructor.

3. By using the **New-AzureRMVirtualNetwork** command, create a new virtual network named **AdatumTestVnet** with the address space **10.0.0.0/16** in the newly created resource group and in the same region as the resource group.

4. Add a subnet named **FrontEnd** with the IP range of 10.0.0.0/24 to the virtual network **AdatumTestVNet**.


> **Result**: After completing this exercise, you should have created a test virtual networks for A. Datum by using Azure PowerShell. 


## Exercise 3: Configuring virtual networks
  
### Scenario
  
 As part of expanding their network environment, A. Datum needs to prepare for connecting classic virtual networks and Azure Resource Manager virtual networks by creating a virtual network gateway on an classic virtual network. You also need to test provisioning of an Azure Azure Resource Manager VM onto an Azure Resource Manager virtual network. 

The main tasks for this exercise are as follows:

1. Create a classic virtual network gateway

2. Deploy an Azure virtual machine by using the Resource Manager deployment model



#### Task 1: Create an classic virtual network gateway
  
1. Switch to Internet Explorer displaying the Azure portal.

2. Navigate to the **ADATUM-BRANCH-VNET** classic virtual network.

3. From the **ADATUM-BRANCH-VNET** blade, create a gateway with the following settings:

  - Address range (CIDR block): **192.168.254.224/27**

  - Size: **Default** 

  - Routing Type: **Dynamic**.

> **Note:** The creation of the VPN gateway could take 30 - 35 minutes to complete.


#### Task 2: Deploy an Azure virtual machine by using the Resource Manager deployment model
  
1. From MIA-CL1, start Windows PowerShell ISE as Administrator

2. From the Windows PowerShell ISE console, run D:\\Labfiles\\Lab02\\Starter\\New-AzureRm20533C02VM.ps1

3. When prompted to sign in (twice), type in the user name and the password which is either the Service Administrator or a Co-Administrator in your Azure subscription.

4. If you have multiple subscription, when prompted, select the subscription to which you deployed the virtual network in the first exercise.

> **Note:** The script takes about 10 minutes to complete.
>  The script deploys a Azure VM named ARMSrv2 onto the first subnet of the HQ virtual network you provisioned earlier in this lab by using the Azure Resource Manager deployment model

> **Result**: After completing this exercise, you should have created a virtual network gateway on the existing classic virtual network and deployed a virtual machine to the HQ virtual network by using Azure Resource Manager deployment model.


**Question** 
What are some of the methods you can use to create an Azure virtual network?


# Lab B: Configuring connectivity between classic and Azure Resource Manager virtual networks
  
### Scenario
  
 Now that A. Datum has deployed an Azure Resource Manager VNet, the company wants to be able to provide direct connectivity to the classic VMs on the existing classic VNet. To allow for direct communication between VMs on both virtual networks, you need to implement VNet-to-VNet connection between them. You will accomplish this by using an Azure PowerShell script. You also want to implement a point-to-site VPN, so that you can connect to Azure VMs in the headquarters Azure region from your administrative computer.


### Objectives
  
 After completing this lab, you should be able:

- Connect Azure virtual networks using a VNet-to-VNet VPN.

- Configure and test a point-to-site VPN.

- Validate virtual network connectivity using Azure-based and VM-based tools.


### Lab Setup
  
 Estimated Time: 35 minutes

Virtual Machine: **20533C-MIA-CL1**

 User Name: **Student**

 Password: **Pa55w.rd**

 Before you begin this lab, ensure that you have completed the first lab in this module: Creating virtual networks.


## Exercise 1: Using a Windows PowerShell script to connect a classic VNet and an Azure Resource Manager VNet
  
### Scenario
  
 A. Datum now wishes to connect the A. Datum HQ and branch virtual networks by using a VPN.

The main tasks for this exercise are as follows:

1. Configure Resource Manager virtual network

2. Configure classic virtual network



#### Task 1: Configure Resource Manager virtual network
  
1. On MIA-CL1, in the Internet Explorer window, in the Azure portal, on the **ADATUM-BRANCH-VNET** blade, on the **VPN connections** tile, verify that the **Gateway** entry has an IP address assigned to it. If this is not the case, wait until IP address does appear. 

2. On MIA-CL1, from the Windows PowerShell window, first review and then run D:\\Labfiles\\Lab02\\Starter\\New-AzureRm20533C02Gateway.ps1

3. When prompted, sign-in (twice) with an account that is either the Service Administrator or a Co-Administrator of your Azure subscription.

4. Occasionally monitor the execution status.

> **Note:** The script might take 20-25 minutes to complete. Wait for it to complete.


#### Task 2: Configure classic virtual network
  
1. On MIA-CL1, in the Internet Explorer window, in the Azure portal, navigate to the **HQ** virtual network blade.

2. From the HQ blade, identify the IP address of the **gatewayARM**.

3. On MIA-CL1, open the **D:\Configfiles\Lab02\NetworkConfig.txt** file by using Notepad.

4. In Notepad, under the **LocalNetworkSite** section, modify the value of **&lt;VPNGatewayAddress&gt;** (which is at this point set to **1.1.1.1**) by replacing **1.1.1.1** with the value of the IP address that you identified in step 2.

5. Replace **Location1** in the **&lt;VirtualNetworkSite name="ADATUM-BRANCH-VNET" Location="Location1"&gt;** element with the name of the Azure region in which you created the **ADATUM-BRANCH-VNET** virtual network.

6. Save the modified file as **NetworkConfig.xml** and then close the file.

7. Switch to the Windows PowerShell window.

8. From the Windows PowerShell prompt, sign into your Azure subscription by running:

  ```
  Add-AzureAccount
  ```

9. If you have multiple subscriptions, select the target one by running (replace '_SubscriptionId_' with the value of the SubscriptionId property of your subscription):

  ```
  Get-AzureSubscription
  Set-AzureSubsciption -SubscriptionId 'SubscriptionId'
  ```

10. Update the network configuration by running the following:

  ```
  Set-AzureVNetConfig -ConfigurationPath D:\Configfiles\Lab02\NetworkConfig.xml
  ```

11. Set the IPSec shared key for the classic VNet gateway by running the following:

  ```
  Set-AzureVNetGatewayKey -VnetName Adatum-Branch-Vnet -LocalNetworkSiteName  HQ -SharedKey 12345
  ```

12. Wait for the command to complete and display the StatusCode **OK**.

13. Switch to the Azure portal displayed in the Internet Explorer window. 

14. Navigate to the **ADATUM-BRANCH-VNET** classic virtual network.

15. On the **ADATUM-BRANCH-VNET** blade, on the **VPN connections** tile, verify that the **ADATUM-BRANCH-VNET** and **HQ** are connected. 

16. Leave the Internet Explorer window open.


> **Result**: After completing this exercise, you should have deployed dynamic routing gateways for each virtual network as well as connected the A. Datum HQ and branch virtual networks.


## Exercise 2: Configuring a point-to-site VPN
  
### Scenario
  
 A. Datum now wants to implement secure communications from on-premises resources to Azure. Management wishes to start by configuring and testing a point-to-site VPN connection to a virtual network in Azure.

The main tasks for this exercise are as follows:

1. Configure a VPN from a client to the headquarters virtual network

2. Connect to the HQ virtual network



#### Task 1: Task 1: Configure a VPN from a client to the HQ virtual network
  
1. In Internet Explorer, in the Azure portal, browse to the gatewayARM blade.

2. Modify the Point-to-site configuration of the gatewayARM by adding the address pool of **172.16.0.0/24**.

3. Switch to the Windows PowerShell window.

4. From the Windows PowerShell prompt, create a root certificate by running:
 
  ```
  $rootCert = New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject 'CN=AdatumRootCertificate' -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation 'Cert:\CurrentUser\My' -KeyUsageProperty Sign -KeyUsage CertSign -FriendlyName 'AdatumRootCertificate'
  ```

5. From the Windows PowerShell prompt, retrieve the public key of the root certificate by running:
  ```
  [System.Convert]::ToBase64String($rootCert.RawData)
  ```

6. Copy the output of the previous command to Clipboard.

7. Paste the content of Clipboard into Notepad.

8. In Notepad, remove all line breaks and any trailing spaces.

9. Copy the content of Notepad into Clipboard.

10. Paste the copied text into the **PUBLIC CERTIFICATE DATA** textbox on the **gatewayARM - Point-to-site configuration** blade of the Azure portal. 

11. In the **NAME** text box to the left, type **AdatumRootCertificate** and save the change.

12. Switch back to the Windows PowerShell window.

13. At the Windows PowerShell prompt, run the following command:

  ```
  New-SelfSignedCertificate -Type Custom -KeySpec Signature -Subject 'CN=AdatumClientCertificate' -KeyExportPolicy Exportable -HashAlgorithm sha256 -KeyLength 2048 -CertStoreLocation 'Cert:\CurrentUser\My' -Signer $rootCert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2") -FriendlyName 'AdatumClientCertificate'
  ```

14. At the Windows PowerShell prompt, run the following command:

  ```
  Get-ChildItem Cert:\CurrentUser\My\
  ```

15. Verify that both the **AdatumClientCertificate** and **AdatumRootCertificate** display in the Personal store.



#### Task 2: Connect to the HQ virtual network

1. Configure a VPN client by downloading the 64-bit Client VPN Package from the Azure portal and installing it on the local client.

2. From the local client, connect by using the newly configured VPN connection, and verify the resulting IP configuration by examining the output of **ipconfig /all**.

3. Verify the VPN connection by initiating an RDP session to the private IP address of ARMSrv2 Azure virtual machine. Verify that you can successfully log on to ARMSrv2. Sign in by using the following credentials:

  - User name: **Student**

  - Password: **Pa55w.rd1234**
  
> **Note:** Note that you could potentially also test connectivity to a file share on ARMSrv2 Azure virtual machine or ping it by its IP address, however, that would require modifying Windows Firewall settings on ARMSrv2 in order to allow File and Printer Sharing traffic.

4. Close the RDP session and disconnect the VPN connection.


> **Result**: After completing this exercise, you should have configured and tested a point-to-site VPN connection.


## Exercise 3: Validating virtual network connectivity
  
### Scenario
  
 A. Datum now wants to test the new Azure networking configuration and validate the connectivity between the A. Datum headquarters and the branch virtual network.
> **Note:** **Important:** Even if you do not complete this exercise, you must ensure that you complete the _Reset the Environment_ task. This task resets your Azure subscription in preparation for later labs and ensures that no unnecessary costs accrue.

 The main tasks for this exercise are as follows:

1. Connect to the A. Datum VMs

2. Test direct TCP/IP connectivity between the Azure regions

3. Reset the environment



#### Task 1: Connect to the A. Datum VMs
  
1. Connect to **ClassicSrv1** via an Remote Desktop Protocol (RDP) session from the Azure portal.

2. Sign in by using the following credentials:

  - User name: **Student**

  - Password: **Pa55w.rd1234**


1. Minimize the **ClassicSrv1** RDP session.

2. Connect to **ARMSrv2** via an RDP session from the Azure portal.

3. Sign in by using the following credentials:


  - User name: **Student**

  - Password: **Pa55w.rd1234**



#### Task 2: Test direct TCP/IP connectivity between the Azure regions
  
1. From the ARMSrv2 RDP session, if prompted whether to enable network discovery, click **No**

2. Turn **Windows Firewall** off for the **Public** profile.

3. From the **ClassicSrv1** RDP session, run the **Test-Connection** Windows PowerShell cmdlet targeting the private IP address **(10.0.0.4)** of **ARMSrv2** and verify that you are receiving a response.



#### Task 3: Reset the environment
  
1. Close all open applications without saving any files.

2. On the taskbar, right-click **Windows PowerShell**, and then click **Run as administrator**. In the User Account Control dialog, click **Yes**.

3. Type the following command, and then press Enter:

  ```
  Reset-Azure
  ```

4. When prompted, sign in (twice) by using the Microsoft account that is the Service Administrator or Co-Administrator of your Azure subscription.

5. If you have multiple Azure subscriptions, select the one you want to target with the script.

6. When prompted for confirmation, type **y**.

> **Note:** This script might remove Azure services in your subscription. Therefore, we recommend that you use an Azure trial pass that was provisioned specifically for this course, and not your own Azure account.
> The script will take 5-10 minutes to reset your Microsoft Azure environment, ready for the next lab. 
> The script removes all storage, VMs, virtual networks and gateways, cloud services, and resource groups.
> **Important**: The script might not be able to get exclusive access to a storage account to delete it (you will see an error, if this occurs). If you find objects remaining after the reset script is complete, you can re-run **Reset-Azure** script, or use the full Azure Management Portal to manually delete all the objects in your Azure subscription, with the exception of the default directory.

> **Result**: After completing this exercise, you should have verified that VMs can communicate between the virtual networks.



**Question** 
What are the key steps for configuring a point-to-site VPN?

**Question** 
How can you enable communications between Azure VMs that were created with the Azure classic deployment model and Azure VMs that were created with the Azure Resource Manager deployment model if they reside in different Azure regions?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.

  
