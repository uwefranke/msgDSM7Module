#
# Modulmanifest für das Modul "msgDSM7Module"
#
# Generiert von: Uwe Franke
#
# Generiert am: 14.08.2018
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binï¿½rmoduldatei.
RootModule = 'msgDSM7Module.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '1.0.2.3'

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '02b5fc9c-4429-4012-9456-cb8a5a87b0ca'

# Autor dieses Moduls
Author = 'Uwe Franke'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'msg services AG'

# Urheberrechtserklï¿½rung fï¿½r dieses Modul
Copyright = 'msg services AG (c) 2013-2020. All rights reserved.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
Description = 'powershell Module for SOAP interface Ivanti (https://www.ivanti.com) DSM'

# Die fï¿½r dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '5.1'

# Der Name des fï¿½r dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die fï¿½r dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die fï¿½r dieses Modul mindestens erforderliche Microsoft .NET Framework-Version
DotNetFrameworkVersion = '2.0'

# Die fï¿½r dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime)
CLRVersion = '2.0.50727'

# Die fï¿½r dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden mï¿½ssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden mï¿½ssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgefï¿½hrt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen
FunctionsToExport = 'Write-Log', 'Remove-Log', 'Convert-ArrayToHash', 'Confirm-Creds', 
               'Connect-DSM7Web', 'Connect-DSM7WebRandom', 'DisConnect-DSM7Web', 
               'Get-DSM7ObjectList', 'Get-DSM7ObjectObject', 'Get-DSM7Object', 
               'Get-DSM7Objects', 'Get-DSM7LDAPPath', 'Get-DSM7AssociationList', 
               'Get-DSM7AssociationschemaList', 'New-DSM7Association', 
               'Get-DSM7DisplayNameLists', 'Get-DSM7ComputerList', 
               'Get-DSM7Computer', 'Update-DSM7Computer', 'Install-DSM7Computer', 
               'New-DSM7Computer', 'Remove-DSM7Computer', 'Move-DSM7Computer',
			   'WakeUp-DSM7Computer',
               'Get-DSM7OrgTreeContainer', 'Get-DSM7OrgTreeContainers', 
               'New-DSM7OrgTreeContainer', 'Move-DSM7OrgTreeContainer', 
               'Update-DSM7OrgTreeContainer', 'Remove-DSM7OrgTreeContainer', 
               'Get-DSM7Group', 'Get-DSM7GroupList', 'New-DSM7Group', 'Update-DSM7Group', 'Move-DSM7Group', 
               'Remove-DSM7Group', 'Get-DSM7ComputerGroupMembers', 
               'Get-DSM7ComputerInGroups', 'Get-DSM7ExternalGroupMembers', 
               'Get-DSM7GroupMembers', 'Get-DSM7ListOfMemberships', 
               'Update-DSM7MembershipInGroups', 'Update-DSM7MemberListOfGroup', 
               'Add-DSM7ComputerToGroup', 'Remove-DSM7ComputerFromGroup', 
               'Get-DSM7Policy', 'Update-DSM7Policy', 'Get-DSM7PolicyList', 
               'Move-DSM7PolicyToTarget', 'Remove-DSM7PolicyFromTarget', 
               'Add-DSM7PolicyToTarget', 'New-DSM7Policy', 'Copy-DSM7Policy', 
               'Remove-DSM7Policy', 'Get-DSM7PolicyListByAssignedSoftware', 
               'Get-DSM7PolicyListByTarget','Copy-DSM7PolicyListNewTarget', 
               'Get-DSM7PolicyStatisticsByTarget', 'Get-DSM7PolicyStatistics', 
               'Get-DSM7PolicyStatisticsByPolicies', 
               'Get-DSM7ComputerMissingPatch', 
               'Get-DSM7PolicyInstanceCountByPolicy', 
			   'Get-DSM7SwInstallationParamDefinitions',
               'Get-DSM7PolicyInstanceListByNode','Get-DSM7PolicyInstanceListByPolicy', 'Update-DSM7PolicyInstances', 
               'Remove-DSM7PolicyInstance', 
               'Get-DSM7SwInstallationConfigurationsObject', 'Get-DSM7SoftwareIDs', 
               'Get-DSM7Software', 'Move-DSM7Software', 'Update-DSM7Software', 
               'Get-DSM7SoftwareList', 'Get-DSM7SoftwareCategoryList', 
               'Get-DSM7SoftwareCategory', 'New-DSM7SoftwareCategory', 
               'Update-DSM7SoftwareCategory', 'Remove-DSM7SoftwareCategory', 
               'Get-DSM7ResolveVariablesForTarget', 'Get-DSM7VariableGroups', 
               'Set-DSM7VariablesOnTarget', 'Remove-DSM7VariablesOnTarget', 
               'Add-DSM7ComputerToUser', 'Remove-DSM7ComputerToUser','Get-DSM7ComputerToUser',
               'Get-DSM7ComputerToUserList', 'Get-DSM7User','Get-DSM7UserList',
               'Get-DSM7NCP','Get-DSM7NCPObjects'

# Aus diesem Modul zu exportierende Cmdlets
CmdletsToExport = '*'

# Die aus diesem Modul zu exportierenden Variablen
VariablesToExport = '*'

# Aus diesem Modul zu exportierende Aliase
AliasesToExport = 'Get-DSM7SoftwarebyIDs'

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul ï¿½bergeben werden sollen. Diese kï¿½nnen auch eine PSData-Hashtabelle mit zusï¿½tzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'DSM','ivanti','heat','frontrange','enteo','SOAP','BLS','automation'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/uwefranke/msgDSM7Module/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/uwefranke/msgDSM7Module'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/uwefranke/msgDSM7Module/blob/master/CHANGELOG.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo-URI dieses Moduls
HelpInfoURI = 'https://github.com/uwefranke/msgDSM7Module/blob/master/docs/about_msgDSM7Module.md'

# Standardprï¿½fix fï¿½r Befehle, die aus diesem Modul exportiert werden. Das Standardprï¿½fix kann mit "Import-Module -Prefix" ï¿½berschrieben werden.
# DefaultCommandPrefix = ''

}


