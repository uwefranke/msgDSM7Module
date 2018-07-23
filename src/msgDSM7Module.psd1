#
# Modulmanifest für das Modul "PSGet_msgDSM7Module"
#
# Generiert von: Uwe Franke
#
# Generiert am: 23.07.2018
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
RootModule = 'msgDSM7Module.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '1.0.1.5'

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '02b5fc9c-4429-4012-9456-cb8a5a87b0ca'

# Autor dieses Moduls
Author = 'Uwe Franke'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'msg services AG'

# Urheberrechtserklärung für dieses Modul
Copyright = 'msg services AG (c) 2013-2018. All rights reserved.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
Description = 'powershell Module for SOAP interface Ivanti(https://www.ivanti.com) DSM'

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '3.0'

# Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version
DotNetFrameworkVersion = '2.0'

# Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime)
CLRVersion = '2.0.50727'

# Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen
FunctionsToExport = '*'

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

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

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

# Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
# DefaultCommandPrefix = ''

}

