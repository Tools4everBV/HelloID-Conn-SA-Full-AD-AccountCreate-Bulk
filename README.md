<!-- Description -->
## Description
This HelloID Service Automation Delegated Form provides functionality for bulk AD user account creation using a CSV file. The following options are available:
 1. Manual provide a CSV file containing the account details (a sample file is provided; [click](https://github.com/Tools4everBV/HelloID-Conn-SA-Full-AD-AccountCreate-Bulk/blob/main/Manual%20resources/bulk_create_ad_account.csv)). _Please note that you can not upload this file using HelloID_
 2. Select one, multiple or all AD accounts to be created in bulk

## Versioning
| Version | Description | Date |
| - | - | - |
| 1.0.1   | Added version number and updated all-in-one script | 2021/11/03  |
| 1.0.0   | Initial release | 2021/09/03  |
 
<!-- TABLE OF CONTENTS -->
## Table of Contents
* [Description](#description)
* [All-in-one PowerShell setup script](#all-in-one-powershell-setup-script)
  * [Getting started](#getting-started)
* [Post-setup configuration](#post-setup-configuration)
* [Manual resources](#manual-resources)
* [Forum Thread](#forum-thread)


## All-in-one PowerShell setup script
The PowerShell script "createform.ps1" contains a complete PowerShell script using the HelloID API to create the complete Form including user defined variables, tasks and data sources.

 _Please note that this script asumes none of the required resources do exists within HelloID. The script does not contain versioning or source control_


### Getting started
Please follow the documentation steps on [HelloID Docs](https://docs.helloid.com/hc/en-us/articles/360017556559-Service-automation-GitHub-resources) in order to setup and run the All-in one Powershell Script in your own environment.

 
## Post-setup configuration
After the all-in-one PowerShell script has run and created all the required resources. The following items need to be configured according to your own environment
 1. Update the following [user defined variables](https://docs.helloid.com/hc/en-us/articles/360014169933-How-to-Create-and-Manage-User-Defined-Variables)
<table>
  <tr><td><strong>Variable name</strong></td><td><strong>Example value</strong></td><td><strong>Description</strong></td></tr>
  <tr><td>ADuserBulkCreateCSV</td><td>C:\ProgramData\Tools4ever\HelloID\Data\bulk_create_ad_account.csv</td><td>Path to CSV file containing the AD account details. This file needs to be accessible by your HelloID Agent (local file or shared folder) </td></tr>
</table>

 2. Update the Dynamic Form markdown element with the right reference to the CSV file. This is for information only, but nice to have the correct file location listed.
 3. Update the details of the CSV file according to your needs. If you want different AD attributes you need to update the CSV file, but also the executing Delegated Form Task.


## Manual resources
This Delegated Form uses the following resources in order to run

### Static data source 'AD-account-generate-table-bulk-create-empty'
This Static data source returns an empty list to be used in the Dual list form element.

### Powershell data source 'AD-account-generate-table-bulk-create'
This Powershell data source reads the CSV file containing the AD account details and returns the data into the dual list.  

### Delegated form task 'AD-user-bulk-create'
This delegated form task will bluk create new AD user accounts based on selected accounts from the form.

# HelloID Docs
The official HelloID documentation can be found at: https://docs.helloid.com/

## Forum Thread
The Forum thread for any questions or remarks regarding this connector can be found at: https://forum.helloid.com/forum/helloid-connectors/service-automation/327-helloid-sa-active-directory-bulk-ad-account-create
