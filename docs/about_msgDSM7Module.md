﻿# msgDSM7Module

## about_msgDSM7Module

powershell Module for SOAP interface [Ivanti](https://www.ivanti.com) DSM

# SHORT DESCRIPTION

powershell Module for SOAP interface [Ivanti](https://www.ivanti.com) DSM
```text
to connect SOAP interface:
http://bls.example.com:8080/blsAdministration/AdministrationService.asmx
```

# LONG DESCRIPTION

# EXAMPLE

```powershell
PS> Connect-DSM7Web -WebServer <BLSServer> -UseDefaultCredential
PS> New-DSM7Computer -Name <Computername> -LDAPPath "Managed Users & Computers/OU1/OU2" -InitialMACAddress "0123456789Ac" -Values @("Computer.ComputerType=Server:String","Description=Test123","CustomInventory.Patchlink=1")
PS> Install-DSM7Computer -Name <Computername> -UpgradePolicyInstances -RecalculateInstallationOrder -UpdatePolicyInstancesActive
PS> DisConnect-DSM7Web
```

# NOTE

## functions in msgDSM7Module

### common functions

* [Write-Log](Write-Log.md)
* [Remove-Log](Remove-Log.md)
* [Confirm-Creds](Confirm-Creds.md)

### DSM Connect

* [Connect-DSM7Web](Connect-DSM7Web.md)
* [Connect-DSM7WebRandom](Connect-DSM7WebRandom.md)
* [DisConnect-DSM7Web](DisConnect-DSM7Web.md)

### DSM Objects

* [Get-DSM7ObjectList](Get-DSM7ObjectList.md)
* [Get-DSM7Object](Get-DSM7Object.md)
* [Get-DSM7Objects](Get-DSM7Objects.md)

### DSM computer objects

* [Get-DSM7ComputerList](Get-DSM7ComputerList.md)
* [Get-DSM7Computer](Get-DSM7Computer.md)
* [Update-DSM7Computer](Update-DSM7Computer.md)
* [Install-DSM7Computer](Install-DSM7Computer.md)
* [New-DSM7Computer](New-DSM7Computer.md)
* [Remove-DSM7Computer](Remove-DSM7Computer.md)
* [Move-DSM7Computer](Move-DSM7Computer.md)
* [Get-DSM7ComputerToUser](Get-DSM7ComputerToUser.md)
* [Add-DSM7ComputerToUser](Add-DSM7ComputerToUser.md)
* [Remove-DSM7ComputerToUser](Remove-DSM7ComputerToUser.md)

* [WakeUp-DSM7Computer](Send-DSM7ComputerWakeUP.md)
* [FastInstall-DSM7Computer](Send-DSM7ComputerFastInstall.md)

### DSM user objects

* [Get-DSM7UserList](Get-DSM7UserList.md)
* [Get-DSM7User](Get-DSM7User.md)

### DSM group objects

* [Get-DSM7Group](Get-DSM7Group.md)
* [New-DSM7Group](New-DSM7Group.md)
* [Move-DSM7Group](Move-DSM7Group.md)
* [Update-DSM7Group](Update-DSM7Group.md)
* [Remove-DSM7Group](Remove-DSM7Group.md)
* [Get-DSM7GroupMembers](Get-DSM7GroupMembers.md)
* [Get-DSM7ListOfMemberships](Get-DSM7ListOfMemberships.md)
* [Add-DSM7ComputerToGroup](Add-DSM7ComputerToGroup.md)
* [Remove-DSM7ComputerFromGroup](Remove-DSM7ComputerFromGroup.md) 

### DSM policy objects

* [Get-DSM7PolicyList](Get-DSM7PolicyList.md)
* [Get-DSM7Policy](Get-DSM7Policy.md)
* [Remove-DSM7Policy](Remove-DSM7Policy.md)
* [New-DSM7Policy](New-DSM7Policy.md)
* [Update-DSM7Policy](Update-DSM7Policy.md)
* [Copy-DSM7Policy](Copy-DSM7Policy.md)
* [Copy-DSM7PolicyListNewTarget](Copy-DSM7PolicyListNewTarget.md)
* [Add-DSM7PolicyToTarget](Add-DSM7PolicyToTarget.md)
* [Move-DSM7PolicyToTarget](Move-DSM7PolicyToTarget.md)
* [Get-DSM7PolicyListByTarget](Get-DSM7PolicyListByTarget.md)
* [Get-DSM7PolicyListByAssignedSoftware](Get-DSM7PolicyListByAssignedSoftware.md)
* [Get-DSM7PolicyStatisticsByTarget](Get-DSM7PolicyStatisticsByTarget.md)
* [Get-DSM7PolicyStatistics](Get-DSM7PolicyStatistics.md)

### DSM policy instance objects

* [Get-DSM7PolicyInstanceCountByPolicy](Get-DSM7PolicyInstanceCountByPolicy.md)
* [Get-DSM7PolicyInstanceListByNode](Get-DSM7PolicyInstanceListByNode.md)
* [Update-DSM7PolicyInstance](Update-DSM7PolicyInstance.md)

### DSM software objects

* [Get-DSM7SoftwareList](Get-DSM7SoftwareList.md)
* [Get-DSM7SoftwareIDs](Get-DSM7SoftwareIDs.md)
* [Get-DSM7Software](Get-DSM7Software.md)
* [Move-DSM7Software](Move-DSM7Software.md)
* [Update-DSM7Software](Update-DSM7Software.md)
* [Get-DSM7SoftwareCategoryList](Get-DSM7SoftwareCategoryList.md)
* [Get-DSM7SoftwareCategory](Get-DSM7SoftwareCategory.md)
* [New-DSM7SoftwareCategory](New-DSM7SoftwareCategory.md)
* [Update-DSM7SoftwareCategory](Update-DSM7SoftwareCategory.md)
* [Remove-DSM7SoftwareCategory](Remove-DSM7SoftwareCategory.md)
* [Get-DSM7GroupMembers](Get-DSM7GroupMembers.md)
* [Get-DSM7ListOfMemberships](Get-DSM7ListOfMemberships.md)
* [Update-DSM7MembershipInGroups](Update-DSM7MembershipInGroups.md)
* [Update-DSM7MemberListOfGroup](Update-DSM7MemberListOfGroup.md)

### DSM OrgTreeContainers

* [Get-DSM7OrgTreeContainer](Get-DSM7OrgTreeContainer.md)
* [New-DSM7OrgTreeContainer](New-DSM7OrgTreeContainer.md)
* [Move-DSM7OrgTreeContainer](Move-DSM7OrgTreeContainer.md)
* [Remove-DSM7OrgTreeContainer](Remove-DSM7OrgTreeContainer.md)
* [Update-DSM7OrgTreeContainer](Update-DSM7OrgTreeContainer.md)

# TROUBLESHOOTING NOTE

# SEE ALSO

# KEYWORDS

