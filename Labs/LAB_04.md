# Module 4: Managing virtual machines
# Lab: Managing Azure virtual machines
  
### Scenario
  
 Now that you identified basic deployment options of Azure VMs, you need to start testing more advanced configuration features. As part of these tests, you need to place the two web servers, which will host the A. Datum ResDev application, in a load-balanced availability set. You will also install IIS on these virtual machines by using the VM Agent DSC extension. In addition, to enhance Azure VM storage, you will set up Storage Spaces-based volumes. You also want to test the managed disks functionality.


### Objectives
  
 After completing this lab, you will be able to:

- Configure Azure virtual machine availability.

- Implement desired state configuration in Azure virtual machines.

- Implement Storage Space-based simple volumes in Azure virtual machines.


### Lab Setup
  
 Estimated Time: 60 minutes


## Exercise 1: Configuring availability
  
### Scenario
  
 You need to redeploy the ResDev app to leverage Azure resiliency capabilities. You will start by provisioning ResDevWebVM1 and ResDevWebVM2 Azure VMs into an availability set named ResDevWebAS. Next, you will create an Azure load balancer and add both virtual machines to its backend pool.

The main tasks for this exercise are as follows:

1. Create virtual machines in an availability set

2. Configure the Azure Load Balancer



#### Task 1: Create virtual machines in an availability set
  
1. On MIA-CL1, open Internet Explorer and navigate to the Azure portal.

2. When prompted, sign in using the Microsoft account that is either the Service Administrator or Co-administrator of your subscription.

3. From the Azure portal, create a new availability set with the following settings:

  - Name: **ResDevWebAS**

  - Subscription: **_The Azure subscription you intend to use for this lab_**.

  - Resource group name: click **Create new** and then type **20533C0401-LabRG**

  - Location: **_The Azure region closest to the location of your lab computer_**.

  - Fault domains: **3**

  - Update domains: **5**
> **Note:** The number of update domains can vary between 5 and 20.

  - Use managed disks: **No (Classic)**


4. From the Azure portal, create a new Windows Server 2016 Datacenter virtual machine with the following settings:


  - Name: **ResDevWebVM1**

  - VM disk type: **HDD**

  - User name: **Student**

  - Password: **Pa55w.rd1234**

  - Subscription: **_The same Azure subscription you used in the previous task_**.

  - Resource group: **20533C0401-LabRG**

  - Location: **_The same location you chose for the availability set_**.

  - Size: **D1_v2 Standard**

  - Use managed disks: **No**

  - Virtual network: _Accept the default name **20533C0401-LabRG-vnet** and settings_

  - Subnet: _Accept the default_.

  - Public IP address: _Accept the default name **ResdevWebVM1-ip**_

  - Network security group: _Accept the default name **ResDevWebVM1-nsg**_

  - Availability set: **ResDevWebAS**

  - Boot diagnostics: **Disabled**

  - Guest OS diagnostics: **Disabled**


5. From the Azure portal, create a new Windows Server 2016 Datacenter virtual machine with the following settings:


  - Name: **ResDevWebVM2**

  - VM disk type: **HDD**

  - User name: **Student**

  - Password: **Pa55w.rd1234**

  - Subscription: **_The same Azure subscription you used in the previous task_**.

  - Resource group: **20533C0401-LabRG**

  - Location: **_The same location you chose for the availability set_**.

  - Size: **D1_v2 Standard**

  - Use managed disks: **No**

  - Virtual network: **20533C0401-LabRG-vnet**

  - Subnet: _Accept the default_.

  - Public IP address: _Accept the default name **ResdevWebVM2-ip**_

  - Network security group: _Accept the default name **ResDevWebVM2-nsg**_

  - Availability set: **ResDevWebAS**

  - Boot diagnostics: **Disabled**

  - Guest OS diagnostics: **Disabled**


6. From the Azure portal, display the blade of the **ResDevWebAS** availability set. On the **ResDevWebAS** blade, note that the availability set contains the two newly deployed virtual machines (at this point, both of them will likely display the **Creating** status). Point out that each VM has a unique fault domain and update domain. You might need to wait a few minutes and refresh the Azure portal page before the updated status is displayed.

7. Leave the instance of Internet Explorer with the Azure portal open.



#### Task 2: Configure the Azure Load Balancer
  
1. On MIA-CL1, in the Azure portal within the Internet Explorer window, create a new load balancer with the following settings: 


  - Name: **ResDevWebLB**

  - Type: **Public**

  - Public IP address: **_Create a new dynamic address named ResDevWebLB-ip_**.

  - Subscription: **_The same Azure subscription you used in the previous task_**.

  - Resource group: Click **Use existing** and, in the drop-down list, click **20533C0401-LabRG**

  - Location: **_The same location you chose for the availability set_**.


2. Wait for the deployment to complete. This should take a few seconds.

3. From the Azure portal, add a backend pool named **ResDevWebLBPool** to the newly created load balancer, associated with the **ResDevWebAS** availability set and both virtual machines that are part of it (ResDevWebVM1 and ResDevWebVM2).

4. Add a probe to the load balancer with the following settings:


  - Name: **ResDevWebProbe80**

  - Protocol: **HTTP**

  - Port: **80**

  - Path: **/**

  - Interval: **5**

  - Unhealthy threshold: **2**


5. Add a load balancer rule to the newly created load balancer with the following settings:


  - Name: **ResDevWebLBRule80**

  - Frontend IP address: **LoadBalancerFrontEnd**

  - Protocol: **TCP**

  - Port: **80**

  - Backend port: **80**

  - Backend Pool: **ResDevWebPool (2 virtual machines)**

  - Probe: **ResDevWebProbe80 (HTTP:80)**

  - Session persistence: **None**

  - Idle timeout: **4**

  - Floating IP (direct server return): **Disabled**

6. On the ResDevWebLB blade, click **Overview**. In the **Essentials** section, you should be able to identify the public IP address assigned to the load balancer. Note that at this point, you will not be able to connect to the two virtual machines in the backend pool, because they are not running a web server and the connectivity is additionally restricted by default network security group settings and the operating system-level firewall. You will change these settings later in this lab.


> **Result**: After completing this exercise, you should have created an availability set for Azure IaaS v2 virtual machines and configured them up as a load balanced pair.


## Exercise 2: Implementing DSC
  
### Scenario
  
 You need to test the implementation of the desired state configuration in Azure by using VM Agent DSC extension to install the default IIS Web site on both virtual machines that will host the A. Datum ResDev application. Once the installation is complete, you must test the availability of this setup by verifying that load balanced access to the default Web site is not affected by shutting down one of the virtual machines.

The main tasks for this exercise are as follows:

1. Install and configure IIS by using DSC and Windows PowerShell

2. Test the DSC configuration and virtual machine availability



#### Task 1: Install and configure IIS by using DSC and Windows PowerShell
  
1. On MIA-CL1, start File Explorer and browse to the D:\\Labfiles\\Lab04\\Starter folder.

2. In the D:\\Labofiles\\Lab04\\Starter folder, right-click on the **IISInstall.ps1** file and select **Edit** from the right-click menu. This will open the file in the **Windows PowerShell ISE**.

3. Review the content of the file. Note that this is a DSC configuration that controls the installation of the Windows Server 2016 Web-Server role. 

4. Close the Windows PowerShell ISE window.

5. In the File Explorer, right click on the D:\\Labfiles\\Lab04\\Starter\\DeployAzureDSC.ps1 file and select **Edit** from the right-click menu. This will open the file in the **Windows PowerShell ISE** window with the current directory set to D:\\Labfiles\\Lab04\\Starter.

6. Review the content of the script. Note the variables that it uses, including the storage account and its key. The script first retrieves the storage account from the resource group, and then publishes the DSC configuration defined in the **Install.ps1** into it, placing it in the default DSC container named **windows-powershell-dsc**, stores the resulting module URL in a variable, and then sets the Azure Agent VM DSC extension on two virtual machines deployed in the previous lab by referencing that URL. The script generates a shared access signature token that provides read only access to the blob representing the DSC configuration archive. 

7. Start the execution of the script. When prompted, sign in with the username and the password of an account that is either a Service Administrator or a Co-Admin of your Azure subscription. Wait until the script completes. 

8. On MIA-CL1, open Internet Explorer and navigate to the Azure portal.

9. Initiate a Remote Desktop session to ResDevWebVM1 from the Azure portal.

10. When prompted to enter credentials to connect, type **Student** as the user name and **Pa55w.rd1234** as the password.

11. Once you establish a Remote Desktop session to the VM, in the **Server Manager** window, verify that IIS appears in the left pane, indicating that the Web Server (IIS) server role is installed.

12. Repeat steps 9 through 11 for the other virtual machine, ResDevWebVM2.

13. After completing the tasks, switch back to your lab computer MIA-CL1. Leave both Remote Desktop sessions open.



#### Task 2: Test the DSC configuration and virtual machine availability
  
1. From the Azure portal within the Internet Explorer window on MIA-CL1, create a new inbound security rule for the **ResDevWebVM1-nsg** security group with the following settings:


  - Name: **allow-http**

  - Priority: **1010**

  - Source: **Any**

  - Service: **HTTP**

  - Action: **Allow**


2. From the Azure portal within the Internet Explorer window on MIA-CL1, create a new inbound security rule for the **ResDevWebVM2-nsg** security group with the following settings:


  - Name: **allow-http**

  - Priority: **1010**

  - Source: **Any**

  - Service: **HTTP**

  - Action: **Allow**


3. From the Azure portal, identify the IP address of the **ResDevWebLB** load balancer.

4. From MIA-CL1, open a new InPrivate Browsing Internet Explorer session and browse to this IP address.

5. Verify that you can access the default IIS webpage and close the InPrivate Browsing session.

6. From the Remote Desktop sessions to two Azure VMs, stop the **World Wide Web Publishing Service** service on both **ResDevWebVM1** and **ResDevWebVM2**.

7. From MIA-CL1, open a new InPrivate Browsing Internet Explorer session. 

8. In the new InPrivate Browsing window, delete browsing history.

9. Browse to the IP address of the **ResDevWebLB** load balancer again and verify that you can no longer access the default IIS webpage.

10. From the Remote Desktop session window, start the **World Wide Web Publishing Service** service on **ResDevWebVM1**.

11. Once the service is running, switch back to MIA-CL1 and refresh the InPrivate Browsing Internet Explorer window. Verify that you can again access the default the default IIS webpage. Note that you might need to wait about a minute after you start the **World Wide Web Publishing Service** service.

> **Note:** Optionally you can repeat this sequence, but this time stopping the **World Wide Web Publishing Service** on ResDevWebVM1 and starting it on ResDevWebVM2. As long as the service is running on at least one of the two virtual machines, you should be able to access the webpage.

> **Result**: After completing this exercise, you should have implemented DSC.


## Exercise 3: Implementing Storage Space-based volumes
  
### Scenario
  
 To test enhanced storage configuration of the virtual machines that will host the A. Datum ResDev application, you need to create three new virtual machine disks, attach them to one of the virtual machines, and create a Storage Spaces volume on the virtual machine.

The main tasks for this exercise are as follows:

1. Attach VHDs to an Azure VM

2. Configure a Storage Spaces simple volume

3. Reset the environment



#### Task 1: Attach VHDs to an Azure VM
  
1. On MIA-CL1, from the Azure portal in the Internet Explorer window, attach two managed data disks named **ResDevWebVM1dd01** and **ResDevWebVM1dd02** to the ResDevWebVM1 virtual machine with the following settings:

  - Source type: **New (empty disk)**

  - Account type: **Standard (HDD)**

  - Size: **1023**

  - Storage Container: Select the existing storage account and the **vhds** container

2. Note that with current VM size (Standard A1), there is a limit of 2 data disks per VM.



#### Task 2: Configure a Storage Spaces simple volume
  
1. On MIA-CL1, switch to the Remote Desktop session to ResDevWebVM1.

2. While connected to ResDevWebVM1, from the Server Manager window, create a storage pool named **StoragePool1** consisting of two newly attached disks.

3. From the Server Manager window, create a new virtual disk named **VirtualDisk1** using **StoragePool1** with the **Simple** storage layout, the **Fixed** provisioning type, and the maximum size.

4. From the Server Manager window, create a new 2 TB volume as drive F formatted with NTFS and a default allocation unit.

5. From the desktop of ResDevWebVM1, open File Explorer and verify that there is a new drive F with 2 TB of available disk space.

6. Close the Remote Desktop session to ResDevWebVM1.



#### Task 3: Reset the environment
  
1. Launch **Windows PowerShell** as Administrator.

2. From the Windows PowerShell prompt, run:

  ```
  Reset-Azure
  ```

3. When prompted (twice), sign in using the Microsoft account associated with your Azure subscription.

4. If you have multiple Azure subscriptions, select the one you want to target by the script.
> **Note:** This script will remove Azure services in your subscription. We, therefore, recommend that you use an Azure trial pass that was provisioned specifically for this course, and not your own Azure account.
> The script will take 5 to 10 minutes to reset your Microsoft Azure environment, before it is ready for the next lab.
> The script removes all storage, VMs, virtual networks, cloud services, and resource groups.
5. When prompted for confirmation, type **y**.

> **Result**: After completing this exercise, you should have implemented Storage Spaces based volumes.


**Question** 
Why would you use Storage Spaces in an Azure VM?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.
