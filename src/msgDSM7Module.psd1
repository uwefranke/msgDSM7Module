#
# Modulmanifest f�r das Modul "PSGet_msgDSM7Module"
#
# Generiert von: Uwe Franke
#
# Generiert am: 20.08.2020
#

@{

# Die diesem Manifest zugeordnete Skript- oder Bin�rmoduldatei.
RootModule = 'msgDSM7Module.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '1.0.2.5'

# Unterst�tzte PSEditions
# CompatiblePSEditions = @()

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '02b5fc9c-4429-4012-9456-cb8a5a87b0ca'

# Autor dieses Moduls
Author = 'Uwe Franke'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'msg services AG'

# Urheberrechtserkl�rung f�r dieses Modul
Copyright = 'msg services AG (c) 2013-2020. All rights reserved.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
Description = 'powershell Module for SOAP interface Ivanti (https://www.ivanti.com) DSM'

# Die f�r dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '5.1'

# Der Name des f�r dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die f�r dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die f�r dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur f�r die PowerShell Desktop-Edition g�ltig.
DotNetFrameworkVersion = '2.0'

# Die f�r dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur f�r die PowerShell Desktop-Edition g�ltig.
CLRVersion = '2.0.50727'

# Die f�r dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden m�ssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden m�ssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgef�hrt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und l�schen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
FunctionsToExport = 'Get-DSM7SoftwareList', 'New-DSM7Computer', 'Get-DSM7ComputerList', 
               'Get-DSM7Software', 'Get-DSM7NCPObjects', 'Get-DSM7LDAPPath', 
               'Update-DSM7MemberListOfGroup', 'Get-DSM7Group', 
               'Get-DSM7PolicyListByAssignedSoftware', 'Remove-DSM7PolicyInstance', 
               'Remove-DSM7Group', 'Update-DSM7SoftwareCategory', 
               'Get-DSM7SoftwareCategoryList', 'Get-DSM7ComputerInGroups', 
               'Get-DSM7UserList', 'Update-DSM7Policy', 
               'Remove-DSM7PolicyFromTarget', 'Update-DSM7MembershipInGroups', 
               'Write-Log', 'Get-DSM7ComputerMissingPatch', 
               'Get-DSM7PolicyListByTarget', 'Get-DSM7ObjectList', 
               'Update-DSM7Group', 'Move-DSM7Group', 'Update-DSM7OrgTreeContainer', 
               'Connect-DSM7Web', 'Get-DSM7OrgTreeContainers', 
               'Get-DSM7ResolveVariablesForTarget', 'DisConnect-DSM7Web', 
               'Get-DSM7ComputerGroupMembers', 'New-DSM7Group', 
               'Get-DSM7ComputerToUser', 'Get-DSM7DisplayNameLists', 
               'Update-DSM7Computer', 'Get-DSM7SoftwareIDs', 
               'Get-DSM7OrgTreeContainer', 'Remove-DSM7VariablesOnTarget', 
               'Get-DSM7Policy', 'Remove-Log', 'Move-DSM7Software', 
               'Remove-DSM7ComputerFromGroup', 'Get-DSM7PolicyStatisticsByTarget', 
               'Get-DSM7PolicyStatistics', 'Get-DSM7VariableGroups', 
               'Remove-DSM7SoftwareCategory', 'Remove-DSM7OrgTreeContainer', 
               'Get-DSM7User', 'Get-DSM7ComputerToUserList', 'Install-DSM7Computer', 
               'Confirm-Creds', 'Get-DSM7Object', 'Get-DSM7PolicyList', 
               'Get-DSM7PolicyInstanceListByPolicy', 'Update-DSM7PolicyInstances', 
               'Get-DSM7PolicyInstanceCountByPolicy', 
               'Get-DSM7SwInstallationParamDefinitions', 
               'Move-DSM7OrgTreeContainer', 'Get-DSM7Computer', 'Get-DSM7GroupList', 
               'Send-DSM7ComputerWakeUP', 'Get-DSM7NCP', 'Move-DSM7PolicyToTarget', 
               'Get-DSM7GroupMembers', 'Get-DSM7ExternalGroupMembers', 
               'Add-DSM7PolicyToTarget', 'New-DSM7Association', 
               'Set-DSM7VariablesOnTarget', 'Get-DSM7AssociationList', 
               'Get-DSM7ListOfMemberships', 'Remove-DSM7Computer', 
               'Add-DSM7ComputerToGroup', 'Connect-DSM7WebRandom', 
               'Get-DSM7SwInstallationConfigurationsObject', 
               'Get-DSM7AssociationschemaList', 'New-DSM7SoftwareCategory', 
               'Add-DSM7ComputerToUser', 'Copy-DSM7PolicyListNewTarget', 
               'Copy-DSM7Policy', 'Get-DSM7PolicyStatisticsByPolicies', 
               'Convert-ArrayToHash', 'Get-DSM7SoftwareCategory', 
               'Remove-DSM7Policy', 'New-DSM7OrgTreeContainer', 
               'Remove-DSM7ComputerToUser', 'Update-DSM7Software', 
               'Get-DSM7PolicyInstanceListByNode', 'Get-DSM7Objects', 
               'New-DSM7Policy', 'Move-DSM7Computer'

# Aus diesem Modul zu exportierende Cmdlets. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und l�schen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Cmdlets vorhanden sind.
CmdletsToExport = '*'

# Die aus diesem Modul zu exportierenden Variablen
VariablesToExport = '*'

# Aus diesem Modul zu exportierende Aliase. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und l�schen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Aliase vorhanden sind.
AliasesToExport = 'Get-DSM7SoftwarebyIDs', 'WakeUp-DSM7Computer'

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul �bergeben werden sollen. Diese k�nnen auch eine PSData-Hashtabelle mit zus�tzlichen von PowerShell verwendeten Modulmetadaten enthalten.
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

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo-URI dieses Moduls
HelpInfoURI = 'https://github.com/uwefranke/msgDSM7Module/blob/master/docs/about_msgDSM7Module.md'

# Standardpr�fix f�r Befehle, die aus diesem Modul exportiert werden. Das Standardpr�fix kann mit "Import-Module -Prefix" �berschrieben werden.
# DefaultCommandPrefix = ''

}

