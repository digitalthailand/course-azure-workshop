# Module 8: Implementing PaaS cloud services
# Lab: Implementing PaaS cloud services
  
### Scenario
  
 You want to evaluate the capabilities of PaaS cloud services to host A. Datum web applications. Your development team has provided a simple cloud service project that you can use to test Cloud Services functionality in Azure. You want to show how staging and production slots can be used to simplify the deployment of new versions of the cloud service. You also want to determine whether you can monitor the service to get clear information on resource usage.


### Objectives
  
 At the end of this lab, you will be able to:

- Configure and deploy a PaaS cloud service to Azure.

- Deploy a PaaS cloud service for staging and enable Remote Desktop Protocol (RDP) access.

- Configure metrics and alerts to monitor PaaS cloud service behavior.


### Lab Setup
  
Estimated Time: 60 minutes


## Exercise 1: Deploying a PaaS cloud service
  
### Scenario
  
 You have been asked to test the deployment of the sample PaaS cloud service to Azure.

 The main tasks for this exercise are as follows:

1. Create an Azure SQL Server Database for a PaaS cloud service

2. Create an Azure Storage account for a PaaS cloud service

3. Configure the service definition file

4. Deploy an PaaS cloud service



#### Task 1. Create an Azure SQL Server Database for a PaaS cloud service
  
1. Sign in to the MIA-CL1 lab virtual machine as **Student** with the password **Pa55w.rd**

2. Start Internet Explorer, browse to the Azure portal, and sign in with an account that is either the Service Administrator or a Co-Administrator of your Azure subscription.

3. Create a new Azure SQL Database with the following settings:

- Database name: **CloudServiceProdDB**

- Subscription: _your Azure subscription name_

- Resource group: _a new resource group named **20533C0801-LabRG**_

- Select source: **Blank database**

- Server: create a new server with the following settings:

  - Server name: _any valid, unique name_

  - Server admin login: **Student**

  - Password: **Pa55w.rd**

  - Confirm password: **Pa55w.rd**

  - Location: _the Azure region closest to the lab location_

  - Allow azure services to access server: _make sure that the checkbox is enabled_

- Want to use SQL elastic pool?: *Not now**

- Pricing tier: **Basic**

- Collation: _leave at the default value_

- Pin to dashboard: _leave the checkbox clear_


#### Task 2. Create an Azure Storage account for a PaaS cloud service

1. From the Azure portal, create a new storage account with the following settings: 

- Name: any unique name consisting of between 3 and 24 lower case letters or digits 

- Deployment model: **Classic**

- Account kind: **General purpose**

- Performance: **Standard**

- Replication: **Locally-redundant storage (LRS)**

- Subscription: _the name of the Azure subscription where you created the SQL database_

- Resource group: **20533C0801-LabRG**

- Location: _the same location you specified in the previous task_

- Pin to dashboard: _leave the checkbox clear_


#### Task 3: Configure the service definition file
  
1. Launch Visual Studio 2015, and then open the **ServiceConfiguration.Cloud.cscfg** file located in D:\\LabFiles\\Lab08\\Starter\\Production\\Package folder.

2. In the file, set the **Instance count** attribute for the **AdatumAdsWebRole** and **AdatumAdsWorkerRole** roles to **2**.

3. Switch to the Azure portal, navigate to the blade of the storage account you created earlier in this exercise and, from its **Access keys** blade, copy the value of the **CONNECTION STRING** entry of the **Primary** key.

4. Back in the **ServiceConfiguration.Cloud.cscfg** file in the Visual Studio 2015 interface, replace all values of the **StorageConnectionString** attribute with the value you copied from the Azure portal.

5. In the **ServiceConfiguration.Cloud.cscfg** file in the Visual Studio 2015 interface, replace all values of the **Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString** attribute with the value you copied from the Azure portal.

6. Switch to the Azure portal, navigate to the blade of the Azure SQL database you created earlier in this exercise, and, from its blade, copy the value of the **ADO.NET** database connection string entry.

7. In the **ServiceConfiguration.Cloud.cscfg** file in the Visual Studio 2015 interface, replace the value of the **AdatumAdsDbConnectionString** attribute with the value you copied from the Azure portal.

8. In the database connection string you just pasted, replace **{your_username}** with **Student**.

9. In the database connection string you just pasted, replace **{your_password}** with **Pa55w.rd**.

10. Save **ServiceConfiguration.Cloud.cscfg**.



#### Task 4: Deploy the PaaS cloud service
  
1. From the Azure portal, create a new PaaS cloud service with the following settings:

- DNS name: _any valid, unique name_

- Subscription: _the name of the Azure subscription you have been using for this lab_

- Resource group: **20533C0801-LabRG**

- Location: _the same location you have been using in this lab_

2. As part of the creation of the cloud service, set the production deployment name to **AdatumAdsProd**.

3. Upload the package **AdatumAds.cspkg** from D:\\LabFiles\\Lab08\\Starter\\Production\\Package.

4. Upload the configuration file **ServiceConfiguration.Cloud.cscfg** from D:\\LabFiles\\Lab08\\Starter\\Production\\Package.

5. Wait for the deployment to complete.

> **Note:** The deployment might take a few minutes. 

> **Result**: At the end of this exercise, you should have created a storage account and a SQL database, edited the service configuration file, and deployed the cloud service to the production slot.


## Exercise 2: Configuring deployment slots and RDP
  
### Scenario
  
 The development team has provided another version of the PaaS cloud service you deployed to Azure. You want to determine how you can use deployment slots to stage and deploy new versions of cloud services. You will use the same configuration you used for the production service. You also want to test Remote Desktop connectivity to individual instances of cloud service roles.

The main tasks for this exercise are as follows:

1. Perform a staged deployment of a PaaS cloud service

2. Configure RDP access

3. Test connectivity



#### Task 1: Perform a staged deployment of a PaaS cloud service
  
1. From the Azure portal, add a new staging deployment to the newly created PaaS cloud service by uploading package and configuration files.

2. Set the staging deployment name to **AdatumAdsStage**.

3. Upload the package **AdatumAds.cspkg** from D:\\LabFiles\\Lab08\\Starter\\Staging\\Package.

4. Upload the configuration file **ServiceConfiguration.Cloud.cscfg** from D:\\LabFiles\\Lab08\\Starter\\Production\\Package.

5. Wait for the deployment to complete

> **Note:** Wait for the deployment to complete. This might take a few minutes. You can monitor the progress in the **Roles and instances** section of the staging blade.


#### Task 2: Configure RDP access

1. On MIA-CLI, start **Windows PowerShell** as Administrator**

2. From the Windows PowerShell session, run `Add-AzureAccount` and sign in with an account that is either the Service Administrator or a Co-Administrator of your Azure subscription.

3. If there are multiple subscriptions associated with your account, execute the following cmdlet:

  ```
  Select-AzureSubscription -SubscriptionId 'Your-subscription-Id'
  ```
 where `Your-subscription-Id` designates the subscription ID to which you deployed the cloud service earlier in this lab

4. Next, execute the following script:
  ```
  $serviceName = 'Your-cloud-service'

  $userName = 'Student'

  $securePassword = 'Pa55w.rd1234' | ConvertTo-SecureString -AsPlainText -Force

  $expirationDate = $(Get-Date).AddDays(31)

  $credential = New-Object System.Management.Automation.PSCredential $userName,$securePassword

  Set-AzureServiceRemoteDesktopExtension -ServiceName $serviceName -Credential $credential -Expiration $expirationDate -Slot Production

  Set-AzureServiceRemoteDesktopExtension -ServiceName $serviceName -Credential $credential -Expiration $expirationDate -Slot Staging
  ```

 where `Your-cloud-service` designates the name of the cloud service you deployed earlier in this lab


#### Task 3: Test connectivity
  
1. From the Azure portal, identify the URL of the production deployment of the PaaS cloud service you deployed in the previous exercise.

2. Use Internet Explorer to navigate to the URL representing the production deployment of the PaaS cloud service.

3. Leave the Internet Explorer window open. You will use it later in this exercise.

4. From the Azure portal, identify the URL of the staging deployment of the PaaS cloud service you deployed in the previous exercise.

5. Navigate to the URL representing the staging deployment of the PaaS cloud service by using Internet Explorer.

6. Close the Internet Explorer tab showing the staging deployment.

7. Connect via Remote Desktop to the **AdatumAdsWebRole_IN_0** instance of the production deployment.

8. Close the remote desktop connection.


> **Result**: At the end of this exercise you have performed a staging deployment of a PaaS cloud service, enable RDP access to a PaaS cloud service, and connected to cloud service instances via HTTP and via RDP.


## Exercise 3: Monitoring cloud services
  
### Scenario
  
 You have been asked to evaluate the network traffic used by the new version of the PaaS cloud service that you deployed to the production environment. To accomplish this, you will start collecting network-related monitoring metrics and configure an alert.

The main tasks for this exercise are as follows:

1. Add metrics to the PaaS cloud service monitoring 

2. Create an alert for a cloud service

3. Monitor a cloud service

4. Reset the environment



#### Task 1: Add metrics to the PaaS cloud service monitoring
  
1. In the Azure portal, navigate to the **Monitoring** pane of the **Production slot**

2. Add the **Network In** of instances of the AdatumAdsWebRole to the list of metrics displayed on the **Monitoring** pane.



#### Task 2: Create an alert
  
1. From the Azure portal, add an alert to the Production slot of the cloud service with the following settings:

- Resource: _leave at its default value_

- Name: **Network In Alert**

- Description: **Test network in alert**

- Metric: **Network In**

- Condition: **greater than**

- Threshold: **1**

- Period: **Over the last 5 minutes**

- Email owners, contributors, and readers: _enable the checkbox_

- Additional administrator email(s): _type the email address of the Service Administrator account of your Azure subscription_

- Webhook: _leave the textbox clear_

2. Generate network traffic to the production deployment by refreshing the production deployment page displayed in Internet Explorer, which you opened earlier in this exercise.

> **Note:** It will take over 5 minutes before the alert is triggered.


#### Task 3: Monitor an active cloud service
  
1. In the Azure portal, navigate to the **Monitor** blade, locate the **Network In Alert** entry, and identify the value in the **LAST FIRED** column.

2. Open another Internet Explorer tab, browse to **www.hotmail.com**, and sign in with the username and password of the Microsoft Account that is the Service Administrator of your Azure subscription. 

3. In the list of emails, click **Microsoft Azure Alerts**.

4. Inspect the details of the alert.

5. Close Internet Explorer.



#### Task 4: Reset the environment
  
1. Launch Windows PowerShell as an Administrator.

2. From the **Windows PowerShell** prompt, run the following command.

  ```
  Reset-Azure
  ```

3. When prompted (twice), sign in by using the Microsoft account associated with your Azure subscription.

4. If you have multiple Azure subscriptions, select the one you want the script to target.

5. When prompted for confirmation, type **y**.

> **Note:** This script removes Azure services from your subscription. It is therefore recommended that you use an Azure trial pass that was provisioned specifically for this course and not your own Azure account.
>  The script takes 5-10 minutes to reset your Microsoft Azure environment so that it is ready for the next lab. The script removes all storage, virtual machines, virtual networks (VNETs), cloud services, and resource groups.
> **Important**: The script might not be able to get exclusive access to a storage account to delete it. (If this occurs, you will see an error.) If you find objects remaining after the reset script is complete, you can rerun `Reset-Azure` or use the Azure portal and the Azure portal to manually delete all the objects in your Azure subscription with the exception of the default directory.

> **Result**: At the end of this exercise, you will have configured monitoring for a PaaS cloud service with a new metric and an alert.



**Question** 
In Exercise 2, you enabled RDP access and used the RDP client to connect to an instance of a web role. Why would administrators want to connect to cloud service role instances via RDP?

**Question** 
You want to ensure you can identify the volume of network traffic your PaaS cloud service has received over the last hour. Should you configure a monitoring metric or an alert?


©2016 Microsoft Corporation. All rights reserved.

The text in this document is available under the [Creative Commons Attribution 3.0 License](https://creativecommons.org/licenses/by/3.0/legalcode "Creative Commons Attribution 3.0 License"), additional terms may apply.  All other content contained in this document (including, without limitation, trademarks, logos, images, etc.) are **not** included within the Creative Commons license grant.  This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.

This document is provided "as-is." Information and views expressed in this document, including URL and other Internet Web site references, may change without notice. You bear the risk of using it. Some examples are for illustration only and are fictitious. No real association is intended or inferred. Microsoft makes no warranties, express or implied, with respect to the information provided here.

  
