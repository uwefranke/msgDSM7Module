<#  
.SYNOPSIS  
    msg powershell Module f�r die SOAP Schnittstelle f�r Ivanti DSM (Version 7.0 - 2018.1)  
.DESCRIPTION
 	msg powershell Module f�r die SOAP Schnittstelle f�r Ivanti DSM (Version 7.0 - 2018.1)  
.NOTES  
    File Name	: msgDSM7Module.psm1  
    Author		: Raymond von Wolff, Uwe Franke
	Version		: 1.0.0.79
    Requires	: PowerShell V3 CTP3  
	History		:
		V1.0.0.0 - 10.01.2013 - Uwe Franke - Intitial
		V1.0.0.1 - 25.03.2013 - Uwe Franke - Fehlerbereinigung (Objectlist) 
		V1.0.0.2 - 26.03.2013 - Uwe Franke - Strukturojekte vervollst�ndigt
		V1.0.0.3 - 27.03.2013 - Uwe Franke - Computer Funktionen �berarbeitet
		V1.0.0.4 - 27.03.2013 - Uwe Franke - Container Funktionen �berarbeitet
		V1.0.0.5 - 28.03.2013 - Uwe Franke - Gruppen Funktionen �berarbeitet, neu New-DSM7Group
		V1.0.0.6 - 02.04.2013 - Uwe Franke - Fehlerbereinigung (Sommerzeit) 
		V1.0.0.7 - 03.04.2013 - Uwe Franke - neu Update-DSM7Group, Move-DSM7Group
		V1.0.0.8 - 09.04.2013 - Uwe Franke - Fehlerbereinigung (Get-DSM7SoftwareList)
		V1.0.0.9 - 22.04.2013 - Uwe Franke - Erweiterung (Get-DSM7SoftwareList)
		V1.0.0.10 - 23.05.2013 - Uwe Franke - Erweiterung (Get-DSM7PolicyStatisticsByTarget)
		V1.0.0.11 - 17.06.2013 - Uwe Franke - Ueberarbeitung (Move-DSM7Computer)
		V1.0.0.12 - 17.06.2013 - Uwe Franke - Erweiterung (Get-DSM7SwInstallationParamDefinitions)
		V1.0.0.14 - 26.05.2014 - Uwe Franke - Fehlerbereinigung Description(Update-DSM7Computer)
		V1.0.0.15 - 26.05.2014 - Uwe Franke - Fehlerbereinigung return Wert(Update-DSM7Computer)
		V1.0.0.16 - 27.05.2014 - Uwe Franke - Ueberarbeitung (Get-DSM7ComputerInGroups)
		V1.0.0.17 - 29.07.2014 - Uwe Franke - Erweiterung PolicyInstance
		V1.0.0.18 - 24.09.2014 - Uwe Franke - Erweiterung Ueberarbeitung (Get-DSM7PolicyListByTarget)
		V1.0.0.19 - 22.10.2014 - Uwe Franke - Erweiterung Ueberarbeitung (Remove-DSM7PolicyInstance)
		V1.0.0.20 - 07.11.2014 - Uwe Franke - Erweiterung Ueberarbeitung (Update-DSM7Group)
		V1.0.0.21 - 05.12.2014 - Uwe Franke - Erweiterung Ueberarbeitung (Copy-DSM7PolicyListNewTarget)
		V1.0.0.22 - 20.02.2015 - Uwe Franke - Erweiterung PSCredential, Get-DSM7ExternalGroupMembers 
		V1.0.0.23 - 10.03.2015 - Uwe Franke - Fehlerbereinigung Credential
		V1.0.0.24 - 11.03.2015 - Uwe Franke - Fehlerbereinigung LDAPPATH
		V1.0.0.25 - 12.03.2015 - Uwe Franke - Powershell Version Abfrage, wegen Fehler mit Array
		V1.0.0.26 - 19.03.2015 - Uwe Franke - Erweiterung Confirm-Creds, Convert-ArrayToHash
		V1.0.0.27 - 05.06.2015 - Uwe Franke - Fehlerbereinigung Connect-DSM7Web
		V1.0.0.28 - 08.06.2015 - Uwe Franke - Fehlerbereinigung Get-DSM7Group, Neue Funktion Connect-DSM7WebRandom
		V1.0.0.29 - 17.06.2015 - Uwe Franke - Get-DSM7ComputerGroupMembers durch Get-DSM7GroupMembers ersetzt 
											  Get-DSM7ComputerInGroups durch Get-DSM7ListOfMemberships ersetzt
											  Get-DSM7ExternalGroupMembers durch Get-DSM7GroupMembers ersetzt
											  neue Objekte ab Version 7.2.3
											  neue Funktion Update-DSM7MembershipInGroups
											  neue Funktion Update-DSM7MemberListOfGroup
		V1.0.0.30 - 19.06.2015 - Uwe Franke - Fehlerbereinigung, neue Funktion Update-DSM7Software, alte Funktionen �berarbeitet
		V1.0.0.31 - 08.07.2015 - Uwe Franke - Fehlerbereinigung Gruppen Funktionen - Wenn Gruppe leer oder Computer in keiner Gruppe jetzt mit richtigem Ergebnis
		V1.0.0.32 - 09.07.2015 - Uwe Franke - Fehlerbereinigung Get-DSM7SoftwareList 
		V1.0.0.33 - 28.07.2015 - Uwe Franke - Erweiterung Ueberarbeitung New-DSM7Computer
		V1.0.0.34 - 10.08.2015 - Uwe Franke - Ueberarbeitet Hilfe f�r Gruppen Funktionen
		V1.0.0.35 - 19.08.2015 - Uwe Franke - Ueberarbeitet Update-DSM7Policy
		V1.0.0.36 - 25.08.2015 - Uwe Franke - Teste auf Verbindung (Confirm-Connect)
		V1.0.0.37 - 23.09.2015 - Uwe Franke - Anpassung f�r DSM CallScript
		V1.0.0.38 - 30.09.2015 - Uwe Franke - Anpassung Get-DSM7Object
		V1.0.0.39 - 27.10.2015 - Uwe Franke - Anpassung Remove-DSM7Policy
		V1.0.0.40 - 12.11.2015 - Uwe Franke - Anpassung Write-Host ge�ndert f�r Ochestrator, Update-DSM7PolicyInstances
		V1.0.0.41 - 12.11.2015 - Uwe Franke - Erweiterung Ueberarbeitung (Copy-DSM7PolicyListNewTarget Copy-DSM7Policy)
		V1.0.0.42 - 12.01.2016 - Uwe Franke - Anpassen an Version 7.3 Update-DSM7PolicyObject, Remove-DSM7PolicyObject, New-DSM7Policy, Update-DSM7PolicyInstances, Install-DSM7ReinstallComputer und Fehlerbehebung
		V1.0.0.43 - 27.01.2016 - Uwe Franke - Fehlerbereinigung Update-DSM7PolicyInstances, neue Funktion Get-DSM7SwInstallationConfigurations
		V1.0.0.44 - 16.02.2016 - Uwe Franke - Ueberarbeitung (Update-DSM7Policy, Get-DSM7Policy, Convert-DSM7PolicytoPSObject)
		V1.0.0.45 - 17.02.2016 - Uwe Franke - neue Funktion  (Move-DSM7Group)
		V1.0.0.46 - 18.02.2016 - Uwe Franke - neue Funktion  (Get-DSM7OrgTreeContainers, Get-DSM7Objects) Fehlerbereinigung (New-DSM7Policy)
		V1.0.0.47 - 01.03.2016 - Uwe Franke - Fehlerbereinigung (Remove-DSM7Policy, Get-DSM7Group)
		V1.0.0.48 - 23.03.2016 - Uwe Franke - Fehlerbereinigung (Convert-DSM7PolicyListtoPSObject)
		V1.0.0.49 - 08.08.2016 - Uwe Franke - neue Funktion Remove-Log, Fehlerbereinigung (Get-DSM7SoftwareList, Get-DSM7ComputerList) 
		V1.0.0.50 - 25.08.2016 - Uwe Franke - Fehlerbereinigung (Get-DSM7SoftwareList, Get-DSM7ComputerList) 
		V1.0.0.51 - 26.08.2016 - Uwe Franke - Fehlerbereinigung (Update-DSM7MembershipInGroups, Update-DSM7MemberListOfGroup)
		V1.0.0.52 - 24.11.2016 - Uwe Franke - Fehlerbereinigung (Convert-DSM7PolicyInstaceListtoPSObject - Deny Policy haben keine Konfig)
		V1.0.0.53 - 15.12.2016 - Uwe Franke - Anpassen an Version 7.3.2 (Get-DSM7GroupMembersObject)
		V1.0.0.54 - 20.12.2016 - Uwe Franke - neue Funktion (Get-DSM7VariableGroups, Get-DSM7ResolveVariablesForTarget, Set-DSM7VariablesOnTarget, Remove-DSM7VariablesOnTarget)
		V1.0.0.55 - 10.01.2017 - Uwe Franke - Anpassen an Version 7.3.2 und Fehlerbereinigung (Get-DSM7AssociationsObjectchemaList, Get-DSM7AssociationList, New-DSM7Association)
		V1.0.0.56 - 16.01.2017 - Uwe Franke - neue Funktionen (Get-DSM7User, Add-DSM7ComputerToUser,Remove-DSM7ComputerToUser )
		V1.0.0.57 - 18.01.2017 - Uwe Franke - Fehlerbehebung Versionsabh�nigkeiten
		V1.0.0.58 - 20.01.2017 - Uwe Franke - neue Funktionen (Get-DSM7SoftwareCategory,New-DSM7SoftwareCategory,Update-DSM7SoftwareCategory,Remove-DSM7SoftwareCategory,Remove-DSM7Group)
											  Anpassung f�r SwCategory (Get-DSM7GroupMembers, Get-DSM7ListOfMemberships, Update-DSM7MembershipInGroups, Update-DSM7MemberListOfGroup)
		V1.0.0.59 - 25.01.2017 - Uwe Franke - Fehlerbehebung (Get-DSM7ObjectList)
		V1.0.0.60 - 27.01.2017 - Uwe Franke - Fehlerbehebung (Convert-DSM7PolicyInstaceListtoPSObject)
		V1.0.0.61 - 30.01.2017 - Uwe Franke - Fehlerbehebung (Add-DSM7TargetToPolicy, New-DSM7Policy) und Help Bereinigung
		V1.0.0.62 - 10.03.2017 - Uwe Franke - Fehlerbehebung (Get-DSM7ComputerList) und Version 2016.2.1
		V1.0.0.63 - 17.03.2017 - Uwe Franke - Fehlerbehebung (Get-DSM7AssociationList) 
		V1.0.0.64 - 30.03.2017 - Uwe Franke - Erweiterung Get-DSM7ObjectList
		V1.0.0.65 - 03.05.2017 - Uwe Franke - neue Funktion (remove-DSM7TargetFromPolicy)
		V1.0.0.66 - 09.06.2017 - Uwe Franke - Erweiterung (Update-DSM7Object, Connect-DSM7Web)
		V1.0.0.67 - 12.06.2017 - Uwe Franke - Fehlerbehebung (DisConnect-DSM7Web)
		V1.0.0.68 - 14.06.2017 - Uwe Franke - Fehlerbehebung (New-DSM7Policy, Remove-DSM7PolicyFromTarget)
		V1.0.0.69 - 19.06.2017 - Uwe Franke - Fehlerbehebung (Update-DSM7Object)
		V1.0.0.70 - 11.07.2017 - Uwe Franke - Export Get-DSM7LADPPath
		V1.0.0.71 - 16.08.2017 - Uwe Franke - Erweiterung New-DSM7SoftwareCategory mit APM
		V1.0.0.72 - 31.08.2017 - Uwe Franke - Fehlerbehebung (Update-DSM7Software)
		V1.0.0.73 - 14.11.2017 - Uwe Franke - Fehlerbehebung (Connect-DSM7Web - reconnect)
		V1.0.0.74 - 17.11.2017 - Uwe Franke - Erweiterung (Get-DSM7SoftwareCategoryList,Get-DSM7SoftwareCategory,New-DSM7SoftwareCategory,Update-DSM7SoftwareCategory)
		V1.0.0.75 - 27.11.2017 - Uwe Franke - Erweiterung (Get-DSM7SoftwareCategoryList,Get-DSM7SoftwareList,Get-DSM7ComputerList,Get-DSM7ObjectList)
		V1.0.0.76 - 13.12.2017 - Uwe Franke - Anpassung 7.3.3 (Get-DSM7GroupMembers)
		V1.0.0.77 - 25.01.2018 - Uwe Franke - Anpassung 7.3.3 (Get-DSM7ServerInfo) f�r Installationsmodus
		V1.0.0.78 - 25.01.2018 - Uwe Franke - Anpassung 7.4.0 (New-DSM7Object, New-DSM7Computer, New-DSM7OrgTreeContainer, New-DSM7Policy, Copy-DSM7Policy und $global:DSM7CreationSource)
		V1.0.0.79 - 24.05.2018 - Uwe Franke - Fehlerbehebung (Convert-DSM7PolicyInstacetoPSObject)
		V1.0.0.80 - 31.05.2018 - Uwe Franke - Fehlerbehebung (Update-DSM7Policy)
		V1.0.1.0 - 14.06.2018 - Uwe Franke - Fehlerbehebung (Convert-DSM7PolicyInstanceListtoPSObject, change Convert-DSM7PolicytoPSObject,Copy-DSM7Policy,New-DSM7PolicyObject, Convert-DSM7PolicyInstancetoPSObject) , Changelog.md , new Helpfiles *.md
.LINK  
		http://www.msg-services.de
.LINK  
		http://www.ivanti.com
#>
###############################################################################
# Allgemeine Variablen
$DSM7requiredVersion = "7.0" # ben�tigte DSM Version 7.0 oder gr��er
$DSM7testedVersion = "7.4.1.4" # h�chste getestet DSM Version mit diesem Modul
$DSM7Targets = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=Computer)(SchemaTag=User)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=DynamicGroup))"
$DSM7Structure = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=DynamicGroup)(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$DSM7Container = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$DSM7StructureComputer = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=DynamicGroup))"
$DSM7StructureSoftware = "(|(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$global:DSM7GenTypeData = "ModifiedBy,CreatedBy,Modified,Created"
###############################################################################
# Allgemeine interne Funktionen
function Get-PSCredential {
	[CmdletBinding()] 
	param ($User,$Password)
	$SecPass = convertto-securestring -asplaintext -string $Password -force
	$Creds = new-object System.Management.Automation.PSCredential -argumentlist $User,$SecPass
	return $Creds
}
###############################################################################
# Allgemeine externe Funktionen
function Write-Log {
	<#
	.SYNOPSIS
		eigene Log Funktion 
	.DESCRIPTION
		eigene Log Funktion 
	.EXAMPLE
		Write-Log 0 "Text" $MyInvocation.MyCommand
	.NOTES
	.LINK
		Write-Log
	.LINK
		Remove-Log
	#>
	[CmdletBinding()] 
	param ([int]$typ, [system.String]$message, [system.String]$Name)
	$typs = @("Info   ","Warning","Error  ")
	$dt = Get-Date -format "yyyy-MM-dd HH:mm:ss"
	$strtyp = $typs[$typ]
	$global:LogMessage = "[$Name] - $message"
	$global:LogMessageTyp = $strtyp
	$LogMessageStr = "$dt - $strtyp - [$Name] - $message"
	if (!$Ochestrator) {
		if (!$DSM) {
			switch ($typ) {
				0 {Write-Host $LogMessageStr}
				1 {Write-Host $LogMessageStr -ForegroundColor Yellow}
				2 {Write-Host $LogMessageStr -ForegroundColor Red}
			}
		}
		else {
			switch ($typ) {
				0 {write-nireport $LogMessage}
				1 {write-nireport $LogMessage}
				2 {Set-NIError $LogMessage}
			}
		}
	}
	if ($logfile) {
		echo $LogMessageStr >> $logfile
	}
}
Export-ModuleMember -Function Write-Log
function Remove-Log {
	<#
	.SYNOPSIS
		eigene Log Funktion 
	.DESCRIPTION
		eigene Log Funktion 
	.EXAMPLE
		Remove-Log -CountLogFiles 10 -DaysLogFilesAge 30 -Logpath "c:\Logs" -Logname "Test"
	.NOTES
	.LINK
		Write-Log
	.LINK
		Remove-Log
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[system.String]$Logpath, 
		[Parameter(Position=1, Mandatory=$true)]
		[system.String]$Logname,
		[int]$CountLogFiles = 0, 
		[int]$DaysLogFilesAge = 0
	)
	$DateLogFiles = (Get-Date).AddDays(-$DaysLogFilesAge)
	Write-Log 0 "Loesche alle Datei(en), behalte die letzen $CountLogFiles,aelter $DaysLogFilesAge und enthaelt im Namen $Logname befindet sich im Path $Logpath" $MyInvocation.MyCommand
	try { 
		$filestodelete = Get-ChildItem $logpath -Recurse| Where-Object {$_.Name -like "$Logname*"} 
		if ($DaysLogFilesAge -gt 0) {
			$filestodelete = $filestodelete| Where-Object {$_.LastWriteTime -lt $DateLogFiles}
			Write-Log 0 "Loesche $($filestodelete.count) Datei(en) die aelter als $DaysLogFilesAge Tage sind." $MyInvocation.MyCommand
			$filestodelete |Remove-Item -Force -Verbose
			$filestodelete = Get-ChildItem $logpath -Recurse| Where-Object {$_.Name -like "$Logname*"} 
		}
		if ($filestodelete.Count -gt $CountLogFiles -and $CountLogFiles -gt 0) {
			$filestodelete = $filestodelete|sort LastWriteTime -Descending|select -Last ($filestodelete.Count - $CountLogFiles)
			Write-Log 0 "Loesche $($filestodelete.count) Datei(en) ueber der Anzahl $CountLogFiles." $MyInvocation.MyCommand
			$filestodelete |Remove-Item -Force -Verbose
		}
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
Export-ModuleMember -Function Remove-Log

function Convert-ArrayToHash {
	<#
	.SYNOPSIS
		konvertiert eine Array zu einem Hash mit Keylist
	.DESCRIPTION
		konvertiert eine Array zu einem Hash mit Keylist
	.EXAMPLE
		Convert-ArrayToHash Array Key
	.NOTES
	.LINK
	#>
	[CmdletBinding()] 
	param (
		$myArray,
		$myKey
	)
	$myHash = @{}
	$myArray | foreach { $myHash[$_.$myKey] = $_ }
	return $myHash
}
Export-ModuleMember -Function Convert-ArrayToHash
function Confirm-Creds {
	<#
	.SYNOPSIS
		�berpr�ft die Benutzerinformationen und ggf. Passwortabfrage
	.DESCRIPTION
		�berpr�ft die Benutzerinformationen und ggf. Passwortabfrage
	.EXAMPLE
		Confirm-Creds -User Benutzer -Password *******
	.NOTES
	.LINK
	#>
	[CmdletBinding()] 
	param (
		$Domain,
		$User,
		$Password
	)
	if (!$Domain) {
		if (!$User) {
			$User = Read-Host "Bitte Benutzer eingeben (Domain\Benutzer):" 
		}
		else {
			if ($User.Contains("\") -or $User.Contains("@")) {
				Write-Log 0 "Benutzer ist: $User" $MyInvocation.MyCommand
			}
			else { 
				$User = Read-Host "Bitte Benutzer eingeben (Domain\Benutzer):" 
			}
			if ($User.Contains("\")) {
				$Domain = $User.Split("\")[0]
				$User = $User.Split("\")[1]
			}
			if ($User.Contains("@")) {
				$Domain = $User.Split("@")[1]
				$User = $User.Split("@")[0]
			}
		}
	}
	else {
		if (!$User) {
			$User = Read-Host "Bitte Benutzer eingeben (Benutzer)"
		}
	} 
	if (!$Password) {
		$Password = Read-Host "Bitte Passwort f�r ($Domain\$User) eingeben" -AsSecureString 
	}
	else {
		$Password = convertto-securestring -asplaintext -string $Password -force
	}
	$DomainUser = "$Domain\$User"
	$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $DomainUser, $Password
	return $cred
}
Export-ModuleMember -Function Confirm-Creds
###############################################################################
# DSM7 Funktionen - allgemein 
function Connect-DSM7Web { 
	<#
	.SYNOPSIS
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her.
	.DESCRIPTION
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her.
	.EXAMPLE
		Connect-DSM7Web -WebServer "DSM7 BLS" -UseDefaultCredential
	.EXAMPLE
		Connect-DSM7Web -WebServer "DSM7 BLS" -Port 8080 -User "Dom�ne\Benutzer" -UserPW "******"
	.EXAMPLE
		Connect-DSM7Web -WebServer "DSM7 BLS" -Port 8080 -Credential PSCredential
	.NOTES
	.LINK
		Connect-DSM7Web
	.LINK
		Connect-DSM7WebRandom
	#>
	[CmdletBinding()] 
	param (
		[System.String]$WebServer = "localhost",
		[System.String]$Port = "8080",
		[switch]$UseDefaultCredential = $false,
		[System.String]$User,
		[System.String]$UserPW,
		$Credential
	)
	$DSM7wsdlURL = "http://" + $WebServer + ":" + $Port + "/blsAdministration/AdministrationService.asmx?WSDL" 
	$global:DSM7Types = @{} 
	try {
		Write-Log 0 "Verbinde zu $DSM7wsdlURL." $MyInvocation.MyCommand
		Write-Log 0 "Powershell Version: $($Host.Version)" $MyInvocation.MyCommand
		if ($UseDefaultCredential) {
			$global:DSM7WebService = New-WebServiceProxy -uri $DSM7wsdlURL -UseDefaultCredential -ErrorAction:Stop 
			Write-Log 0 "Verbinde mit Benutzer ($(whoami))." $MyInvocation.MyCommand
		}
		else {
			if (!$Credential) {
				if ($User) {
					$Credential = Confirm-Creds -User $User -Password $UserPw
				}
				else {
					return $false
				}
			} 
			else { if (!($Credential -is [PSCredential])) {
					$Credential = Confirm-Creds -User $Credential 
				}
			}
			$global:DSM7WebService = New-WebServiceProxy -uri $DSM7wsdlURL -Credential $Credential -ErrorAction:Stop 
			$DSM7WebService.Credentials = $Credential
			Write-Log 0 "Verbinde mit Benutzer $($Credential.Username)." $MyInvocation.MyCommand
		}
		Write-Log 0 "Module Name   : $($MyInvocation.MyCommand.Module.Name)" $MyInvocation.MyCommand
		Write-Log 0 "Module Version: $($MyInvocation.MyCommand.Module.Version)" $MyInvocation.MyCommand
		if ($global:DSM7WebService) {
			foreach ($Type in $DSM7WebService.GetType().Assembly.GetExportedTypes()) { 
				$global:DSM7Types.Add($Type.Name, $Type.FullName) 
			}
			$DSM7ServerInfo = Get-DSM7ServerInfo
			if ($DSM7ServerInfo) {
				$global:DSM7Version = $DSM7ServerInfo.CmdbVersionString
				Write-Log 0 "Verbindung hergestellt." $MyInvocation.MyCommand 
				Write-Log 0 "CmdbGuid = $($DSM7ServerInfo.CmdbGuid)" $MyInvocation.MyCommand 
				Write-Log 0 "CmdbVersionString = $DSM7Version" $MyInvocation.MyCommand 
				Write-Log 0 "MetaModelVersion = $($DSM7ServerInfo.MetaModelVersion)" $MyInvocation.MyCommand 
				if ($DSM7Version -lt $DSM7requiredVersion) {
					Write-Log 2 "DSM Version wird nicht unterst�tzt!!!" $MyInvocation.MyCommand 
					return $false
				}
				if ($DSM7Version -gt $DSM7testedVersion) {
					Write-Log 1 "DSM Version ($DSM7Version) nicht getestet!!! Einige Funktionen k�nnten nicht mehr richtige Ergebnisse liefern oder gar nicht mehr funktionieren!!!" $MyInvocation.MyCommand 
				}
				if ($DSM7Version -gt "7.4.0") {
					$global:DSM7GenTypeData = "$DSM7GenTypeData,CreationSource"
				} 
				Write-Log 0 "SOAP Verbindung erfolgreich hergestellt. ($DSM7wsdlURL)" $MyInvocation.MyCommand 
				return $true
			}
			else {
				Write-Log 2 "keine Verbindung" $MyInvocation.MyCommand 
				return $false
			}
		}
		else {
			Write-Log 2 "keine Verbindung" $MyInvocation.MyCommand 
			return $false
		}
	}
	catch [System.Net.WebException] {
		Write-Log 2 "keine Verbindung" $MyInvocation.MyCommand 
		$global:DSM7WebService = $false
	} 
	catch {
		Write-Log 2 "Verbindungsfehler: $_ $($_.Exception.Message)" $MyInvocation.MyCommand 
		$global:DSM7WebService = $false
	}
}
Export-ModuleMember -Function Connect-DSM7Web -Variable DSM7WebService,DSM7Types
function Connect-DSM7WebRandom {
	<#
	.SYNOPSIS
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zuf�llig ausgew�hlt wird.
	.DESCRIPTION
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zuf�llig ausgew�hlt wird.
	.EXAMPLE
		Connect-DSM7WebRandom -WebServer "DSM7 BLS" -UseDefaultCredential
	.EXAMPLE
		Connect-DSM7WebRandom -WebServer "DSM7 BLS" -Port 8080 -User "Dom�ne\Benutzer" -UserPW "******"
	.EXAMPLE
		Connect-DSM7WebRandom -WebServer "DSM7 BLS" -Port 8080 -Credential PSCredential
	.NOTES
	.LINK
		Connect-DSM7Web
	.LINK
		Connect-DSM7WebRandom
	#>
	[CmdletBinding()] 
	param (
		[System.String]$WebServer = "localhost",
		[System.String]$Port = "8080",
		[switch]$UseDefaultCredential = $false,
		[System.String]$User,
		[System.String]$UserPW,
		$Credential
	)
	if ($UseDefaultCredential) {
		$SOAP = Connect-DSM7Web -WebServer $WebServer -UseDefaultCredential
	}
	else { 
		if (!$Credential) {
			if ($User) {
				$Credential = Confirm-Creds -User $User -Password $UserPw
			}
			else {
				return $false
			}
		} 
		$SOAP = Connect-DSM7Web -WebServer $WebServer -Credential $Credential
	}
	if ($SOAP) {
		$AllBLS = Get-DSM7ComputerList -Filter "(BasicInventory.InfrastructureRole:IgnoreCase=BLS)" -Attributes "BasicInventory.FullQualifiedName"
		Write-Log 0 "Anzahl der gefunden BLS Server = $($AllBLS.count)" $MyInvocation.MyCommand 
		$BLSrandom = Get-Random -Maximum $AllBLS.count
		if ($AllBLS[$BLSrandom]."BasicInventory.FullQualifiedName" -ne $BLSServer) {
			DisConnect-DSM7Web
			$BLSServer = $AllBLS[$BLSrandom]."BasicInventory.FullQualifiedName"
			Write-Log 0 "Neuer BLS Server = $BLSServer" $MyInvocation.MyCommand 
			if ($User) {
				$SOAP = Connect-DSM7Web -WebServer $BLSServer -Credential $Credential
			}
			else {
				$SOAP = Connect-DSM7Web -WebServer $BLSServer -UseDefaultCredential
			}
		} 
	}
}
Export-ModuleMember Connect-DSM7WebRandom
function DisConnect-DSM7Web {
	<#
	.SYNOPSIS
		Verbindung trennen.
	.DESCRIPTION
		Verbindung trennen.
	.EXAMPLE
		DisConnect-DSM7Web
	.NOTES
	.LINK
	
	#>
	$global:DSM7Types = $null
	$global:DSM7WebService = $null 
	$global:DSM7Version = $null
	$global:DSM7Version = $null
	$global:DSM7AssociationSchemaList = $null
	$global:DSM7PropGroupDefList = $null
	Write-Log 0 "Verbindung getrennt." $MyInvocation.MyCommand 
	return $true
}
Export-ModuleMember -Function DisConnect-DSM7Web

function Get-DSM7RequestHeader ($action) {
	$action = $action +"Request" 
	$Webrequest = New-Object $DSM7Types[$action] 
	if ($DSM7Version -gt "7.3.2" -and $Webrequest.MaxResults -eq 0) {
		$Webrequest.MaxResults = -1
	}
	$Webrequest.Header = New-Object $DSM7Types["RequestHeader"] 
	$Webrequest.Header.UserCulture = $Host.CurrentCulture
	$Webrequest.Header.ClientInfo = New-Object $DSM7Types["ClientInfo"] 
	$Webrequest.Header.ClientInfo.Name = $Host.Name 
	$Webrequest.Header.ClientInfo.Version = $Host.Version 
	$Webrequest.ServerInfo = New-Object $DSM7Types["ServerInfo"] 
	$Webrequest.ServerInfo.CmdbGuid = {0000000 - 0000 - 0000 - 0000 - 000000000000} 
	$Webrequest.ServerInfo.MetaModelVersion = 203 
	return $Webrequest 
} 
function Get-DSM7ServerInfo {
	[CmdletBinding()] 
	param (
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetServerInfo"
		$Webresult = $DSM7WebService.GetServerInfo($Webrequest).ServerInfo
		if ($Webresult) {
			Write-Log 0 "GetServerInfo erfolgreich." $MyInvocation.MyCommand
			return $Webresult
		}
		else {
			Write-Log 2 "GetServerInfo nicht gefunden!" $MyInvocation.MyCommand 
			return $false
		}
	}
	catch [System.Web.Services.Protocols.SoapException] 
	{
		Write-Log 2 $_.Exception.Detail.Message.'#text' $MyInvocation.MyCommand 
		return $false 
	} 
	catch
	{
		Write-Log 2 $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7IdentifiedUser {
	[CmdletBinding()] 
	param (
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetIdentifiedUser"
		$Webresult = $DSM7WebService.GetIdentifiedUser($Webrequest)
		if ($Webresult) {
			Write-Log 0 "GetIdentifiedUser erfolgreich." $MyInvocation.MyCommand
			return $Webresult
		}
		else {
			Write-Log 2 "GetIdentifiedUser nicht gefunden!" $MyInvocation.MyCommand 
			return $false
		}
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Confirm-Connect {
	if (!$DSM7WebService) {
		Write-Log 1 "Keine Verbindung zum Webserver (SOAP)!!!`n`t`t`t`tBitte die Funktion `"Connect-DSM7Web`" f�r die Verbindung benutzen,`n`t`t`t`toder es ist ein Fehler beim verbinden aufgetreten." $MyInvocation.MyCommand
		return $false
	}
	else {
		return $true
	}
}
###############################################################################
# DSM7 Funktionen - Convert
###############################################################################
function Convert-StringtoLDAPString ($String) {
	if ($String.contains("\")) { $String = $String.Replace("\","\\")}
	if ($String.Contains("(") -or $String.Contains(")") ) {
		$String = $String.Replace("(","\(")
		$String = $String.Replace(")","\)")
	}
	return $String
}
function Convert-LDAPStringToReplaceString ($String) {
	if ($String.contains("\(")) {$String = $String.Replace("\(","\+")}
	if ($String.Contains("\)")) {$String = $String.Replace("\)","\-")}
	return $String
}
function Convert-ReplaceStringToLDAPString ($String) {
	if ($String.contains("\+")) {$String = $String.Replace("\+","\(")}
	if ($String.Contains("\-")) {$String = $String.Replace("\-","\)")}
	return $String
}

function Convert-DSM7ObjectListtoPSObject {
	[CmdletBinding()] 
	param ( 
		$ObjectList,
		[switch]$LDAP = $false
	)
	$DSM7ObjectMembers = ($ObjectList[0]|Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $ObjectList) {
		$Raw = Convert-DSM7ObjecttoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -LDAP:$LDAP
		$DSM7ObjectList += @($Raw)
	}
	return $DSM7ObjectList
}
function Convert-DSM7ObjectListtoPSObjectID {
	[CmdletBinding()] 
	param ( 
		$ObjectList,
		[switch]$LDAP = $false
	)
	$DSM7ObjectList = @{}
	$DSM7ObjectMembers = ($ObjectList|Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $ObjectList) {
		$Raw = Convert-DSM7ObjecttoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -LDAP:$LDAP
		$DSM7ObjectList[$DSM7Object.ID]= @($Raw)
	}
	return $DSM7ObjectList
}
function Convert-DSM7ObjecttoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Object,
		$DSM7ObjectMembers,
		[switch]$LDAP = $false
	)
	if (!$DSM7ObjectMembers) {
		$DSM7ObjectMembers = ($DSM7Object|Get-Member -MemberType Properties).Name
	}
	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData" -and $DSM7ObjectMember -ne "TargetObjectList" -and $DSM7ObjectMember -ne "SwInstallationParameters" -and $DSM7ObjectMember -ne "PropGroupList") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0){
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists|Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers){
						for ($I = 0;$I -lt $($DSM7ObjectMemberLists.Count)-1; $I++){
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData|get-member -membertype properties)) { 
									add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
								}
							} 
							else {
								add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.$DSM7ObjectMemberListsMember" -Value $DSM7ObjectMemberLists.$DSM7ObjectMemberListsMember[$I]
							}
						}
					}
				}
				else {
					add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember

				}
			}
			else {
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember

			}
		} 
	}

	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData|get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}
	if ($LDAP) {
		$LDAPPath = Get-DSM7LDAPPath $DSM7Object.ParentContID
		add-member -inputobject $Raw -MemberType NoteProperty -name LDAPPath -Value $LDAPPath
	} 
	if ($DSM7Object.PropGroupList) {
		foreach ($PropGroup in $DSM7Object.PropGroupList) {
			$Groupname = $PropGroup.Tag
			foreach ($Prop in $PropGroup.PropertyList) {
				$TypedValue = $Prop.TypedValue
				if ($Prop.Type -eq "CatalogLink" -and $TypedValue -and $LDAP) {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag).Name" -Value (Get-DSM7ObjectObject -ID $TypedValue -ObjectGroupType "Catalog" ).Name
				}
				if ($TypedValue -and $TypedValue.GetType().Name -eq "MdsVersion") {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue.Version
				}
				else {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue
				} 
			}
		}
	} 
	return $Raw
}

function Convert-DSM7AssociationListtoPSObject {
	[CmdletBinding()] 
	param ( 
		$ObjectList,
		[switch]$resolvedName = $false
	)
	$IDs = @()
	$IDs += ($ObjectList|Select-Object -ExpandProperty SourceObjectID)
	$IDs += ($ObjectList|Select-Object -ExpandProperty TargetObjectID)
	$IDs = $IDs|Get-Unique
	$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
	$DSM7Objects += Get-DSM7ObjectsObject -IDs $IDs -ObjectGroupType "Catalog"
	$DSM7Objects = Convert-DSM7ObjectListtoPSObjectID ($DSM7Objects)
	foreach ($DSM7Object in $ObjectList) {
		$DSM7Object = Convert-DSM7AssociationtoPSObject -DSM7Object $DSM7Object -DSM7Objects $DSM7Objects -resolvedName:$resolvedName
		$DSM7ObjectList += @($DSM7Object)
	}
	return $DSM7ObjectList
}
function Convert-DSM7AssociationtoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Object,
		$DSM7Objects,
		[switch]$resolvedName = $false
	)
	$Raw = New-Object PSObject
	add-member -inputobject $Raw -MemberType NoteProperty -name ID -Value $DSM7Object.ID
	add-member -inputobject $Raw -MemberType NoteProperty -name SchemaTag -Value $DSM7Object.SchemaTag
	add-member -inputobject $Raw -MemberType NoteProperty -name SourceObjectID -Value $DSM7Object.SourceObjectID
	add-member -inputobject $Raw -MemberType NoteProperty -name TargetObjectID -Value $DSM7Object.TargetObjectID
	add-member -inputobject $Raw -MemberType NoteProperty -name TargetSchemaTag -Value $DSM7Object.TargetSchemaTag
	if ($DSM7Object.PropGroupList) {
		foreach ($PropGroup in $DSM7Object.PropGroupList) {
			$Groupname = $PropGroup.Tag
			foreach ($Prop in $PropGroup.PropertyList) {
				$TypedValue = $Prop.TypedValue
				# 				if ($Prop.Type -eq "CatalogLink" -and $TypedValue) {
				# 					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag).Name" -Value (Get-DSM7ObjectObject -ID $TypedValue -ObjectGroupType "Catalog" ).Name
				# 				}
				add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue
			}
		}
	}
	if ($resolvedName) {
		$SourceObjectName = $DSM7Objects.item($Raw.SourceObjectID)[0].Name 
		$TargetObjectName = $DSM7Objects.item($Raw.TargetObjectID)[0].Name 
		add-member -inputobject $Raw -MemberType NoteProperty -name SourceObjectName -Value $SourceObjectName
		add-member -inputobject $Raw -MemberType NoteProperty -name TargetObjectName -Value $TargetObjectName
	}
	return $Raw
}
function Convert-DSM7PolicyListtoPSObject {
	[CmdletBinding()] 
	param ( 
		$ObjectList,
		[switch]$resolvedName = $false
	) 
	if ($resolvedName) {
		$IDs = @() 
		$IDs += ($ObjectList|Select-Object -ExpandProperty AssignedObjectID)
		$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
		$DSM7ObjectsTargetIDs = $ObjectList|Select-Object -ExpandProperty TargetObjectList|Select-Object -ExpandProperty TargetObjectID -Unique
		foreach ($DSM7ObjectsTargetID in $DSM7ObjectsTargetIDs) {
			$filter = "$filter(ObjectID=$DSM7ObjectsTargetID)"
		}
		$filter = "(|$filter)"
		$DSM7ObjectsTargets = Get-DSM7ObjectList -Filter $filter
	}
	$DSM7ObjectMembers = ($ObjectList[0]|Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $ObjectList) {
		$DSM7Object = Convert-DSM7PolicytoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -DSM7Objects $DSM7Objects -DSM7ObjectsTargets $DSM7ObjectsTargets -resolvedName:$resolvedName
		$DSM7ObjectList += @($DSM7Object)
	}
	return $DSM7ObjectList
}
function Convert-DSM7PolicytoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Object,
		$DSM7ObjectMembers,
		$DSM7Objects,
		$DSM7ObjectsTargets,
		[switch]$resolvedName = $false
	)
	$AssignedObjectNameOld = "###"
	if (!$DSM7ObjectMembers) {$DSM7ObjectMembers = ($DSM7Object|Get-Member -MemberType Properties).Name}
	if ($resolvedName) {
		if (!$DSM7Objects) {
			$IDs = @() 
			$IDs += ($DSM7Object|Select-Object -ExpandProperty AssignedObjectID)
			$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
		}
		if (!$DSM7ObjectsTargets) {
			$DSM7ObjectsTargetIDs = $DSM7Object|Select-Object -ExpandProperty TargetObjectList|Select-Object -ExpandProperty TargetObjectID -Unique
			foreach ($DSM7ObjectsTargetID in $DSM7ObjectsTargetIDs) {
				$filter = "$filter(ObjectID=$DSM7ObjectsTargetID)"
			}
			$filter = "(|$filter)"
			$DSM7ObjectsTargets = Get-DSM7ObjectList -Filter $filter
		}
	}

	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData" -and $DSM7ObjectMember -ne "TargetObjectList" -and $DSM7ObjectMember -ne "SwInstallationParameters" -and $DSM7ObjectMember -ne "PropGroupList") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0){
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists|Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers){
						for ($I = 0;$I -lt $($DSM7ObjectMemberLists.Count)-1; $I++){
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData|get-member -membertype properties)) { 
									add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
								}
							} 
							else {
								add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.$DSM7ObjectMemberListsMember" -Value $DSM7ObjectMemberLists.$DSM7ObjectMemberListsMember[$I]
							}
						}
					}
				}
				else {
					add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember

				}
			}
			else {
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember
			}
		} 
	}
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData|get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}

	if ($resolvedName) {
		if ($AssignedObjectName -ne $AssignedObjectNameOld) {
			$AssignedObjectName = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).Name 
			$AssignedObjectUniqueId = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).UniqueId 
			$AssignedObjectSchemaTag = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).SchemaTag
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectName -Value $AssignedObjectName
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectSchemaTag -Value $AssignedObjectSchemaTag
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectUniqueId -Value $AssignedObjectUniqueId 
		$AssignedObjectNameOld = $AssignedObjectName
	}
	if ($DSM7Object.SwInstallationParameters) {
		$SW = 0
		foreach ($SwInstallationParameter in $DSM7Object.SwInstallationParameters) {
			add-member -inputobject $Raw -MemberType NoteProperty -name "SwInstallationParameter.$($SwInstallationParameter.Tag).Name" -Value $SwInstallationParameter.Tag
			add-member -inputobject $Raw -MemberType NoteProperty -name "SwInstallationParameter.$($SwInstallationParameter.Tag).ID" -Value $SwInstallationParameter.ID
			add-member -inputobject $Raw -MemberType NoteProperty -name "SwInstallationParameter.$($SwInstallationParameter.Tag).Value" -Value $SwInstallationParameter.Value
			$SW++
		}
	}
	if ($DSM7Object.PropGroupList) {
		foreach ($PropGroup in $DSM7Object.PropGroupList) {
			$Groupname = $PropGroup.Tag
			foreach ($Prop in $PropGroup.PropertyList) {
				$TypedValue = $Prop.TypedValue
				if ($Prop.Type -eq "CatalogLink" -and $TypedValue -and $LDAP) {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag).Name" -Value (Get-DSM7ObjectObject -ID $TypedValue -ObjectGroupType "Catalog" ).Name
				}
				add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue
			}
		}
	} 

	if ($DSM7Object.TargetObjectList) {
		$TargetObjectList = @()
		foreach ($TargetObject in $DSM7Object.TargetObjectList) {
			$TargetPSObject = New-Object PSObject
			if ($resolvedName) {
				$TargetObjectName = $($DSM7ObjectsTargets|where {$_.ID -eq $TargetObject.TargetObjectID}).Name 
				add-member -inputobject $TargetPSObject -MemberType NoteProperty -name TargetObjectName -Value $TargetObjectName
			}
			add-member -inputobject $TargetPSObject -MemberType NoteProperty -name TargetObjectID -Value $TargetObject.TargetObjectID
			$TargetObjectList += $TargetPSObject
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name "TargetObjectList" -Value $TargetObjectList
	}
	return $Raw
}
function Convert-DSM7PolicyInstancetoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Object,
		$DSM7ObjectMembers,
		$DSM7Objects,
		$DSM7Configs,
		[switch]$resolvedName = $false
	)
	$AssignedObjectNameOld = "###"
	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData" -and $DSM7ObjectMember -ne "TargetObjectList") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0){
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists|Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers){
						for ($I = 0;$I -lt $($DSM7ObjectMemberLists.Count)-1; $I++){
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData|get-member -membertype properties)) { 
									add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
								}
							} 
							else {
								add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.$DSM7ObjectMemberListsMember" -Value $DSM7ObjectMemberLists.$DSM7ObjectMemberListsMember[$I]
							}
						}
					}
				}
				else {
					add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember

				}
			}
			else {
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember
			}
		} 
	}
	if ($DSM7Version -gt "7.3.0") {
		$AssignedObjectID = $($DSM7Configs|where {$_.ID -eq $Raw.AssignedConfiguration}).SoftwareObjectID
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectID -Value $AssignedObjectID
	} 

	if ($resolvedName) {
		if ($AssignedObjectName -ne $AssignedObjectNameOld) {
			$AssignedObjectName = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).Name 
			$AssignedObjectSchemaTag = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).SchemaTag 
			$AssignedObjectUniqueId = $($DSM7Objects|where {$_.ID -eq $Raw.AssignedObjectID}).UniqueId 
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectName -Value $AssignedObjectName
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectSchemaTag -Value $AssignedObjectSchemaTag
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectUniqueId -Value $AssignedObjectUniqueId 
		$AssignedObjectNameOld = $AssignedObjectName
	}
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData|get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}
	if ($DSM7Object.PropGroupList) {
		foreach ($PropGroup in $DSM7Object.PropGroupList) {
			$Groupname = $PropGroup.Tag
			foreach ($Prop in $PropGroup.PropertyList) {
				$TypedValue = $Prop.TypedValue
				if ($Prop.Type -eq "CatalogLink" -and $TypedValue -and $LDAP) {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag).Name" -Value (Get-DSM7ObjectObject -ID $TypedValue -ObjectGroupType "Catalog" ).Name
				}
				add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue
			}
		}
	} 

	if ($DSM7Object.TargetObjectList) {
		$TargetObjectList = @()
		foreach ($TargetObject in $DSM7Object.TargetObjectList) {
			$TargetPSObject = New-Object PSObject
			$TargetObjectName = $($DSM7Objects|where {$_.ID -eq $TargetObject.TargetObjectID}).Name 
			add-member -inputobject $TargetPSObject -MemberType NoteProperty -name TargetObjectName -Value $TargetObjectName
			add-member -inputobject $TargetPSObject -MemberType NoteProperty -name TargetObjectID -Value $TargetObject.TargetObjectID
			$TargetObjectList += $TargetPSObject
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name "TargetObjectList" -Value $TargetObjectList
	}
	return $Raw
}
function Convert-DSM7PolicyInstanceListtoPSObject {
	[CmdletBinding()] 
	param ( $ObjectList,[switch]$resolvedName = $false)
	if ($DSM7Version -gt "7.3.0") {
		$DSM7ConfigIDs += ($ObjectList|where {$_.AssignedConfiguration}|Select-Object -ExpandProperty AssignedConfiguration)
		$DSM7Configs = Get-DSM7SwInstallationConfigurationsObject $DSM7ConfigIDs
	} 
	if ($resolvedName) {
		$IDs = @() 
		if ($DSM7Version -gt "7.3.0") {
			$IDs += ($DSM7Configs|where {$_.SoftwareObjectID}|Select-Object -ExpandProperty SoftwareObjectID)
		}
		else {
			$IDs += ($ObjectList|Select-Object -ExpandProperty AssignedObjectID)
		}
		$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
	} 
	$DSM7ObjectMembers = ($ObjectList|Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $ObjectList) {
		$DSM7Object = Convert-DSM7PolicyInstancetoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -DSM7Objects $DSM7Objects -DSM7Configs $DSM7Configs -resolvedName:$resolvedName
		$DSM7ObjectList += @($DSM7Object)
	}
	return $DSM7ObjectList
}

function Convert-DSM7StatiscstoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Statistics
	)
	$Raw = New-Object PSObject
	foreach ($Stat in $DSM7Statistics) {
		add-member -inputobject $Raw -MemberType NoteProperty -name $Stat.Key -Value $Stat.Count
	}
	return $Raw
}
function Convert-DSM7VariableGrouptoPSObject {
	[CmdletBinding()] 
	param (
		$DSM7Objects
	) 
	foreach ($DSM7Object in $DSM7Objects) {
		foreach ($Variable in $($DSM7Object.VariableList)) {
			$Raw = New-Object PSObject

			add-member -inputobject $Raw -MemberType NoteProperty -name GroupTag -Value $DSM7Object.Tag
			add-member -inputobject $Raw -MemberType NoteProperty -name GroupID -Value $DSM7Object.ID
			add-member -inputobject $Raw -MemberType NoteProperty -name GroupVisibility -Value $DSM7Object.Visibility
			add-member -inputobject $Raw -MemberType NoteProperty -name GroupIsSystem -Value $DSM7Object.IsSystem
			add-member -inputobject $Raw -MemberType NoteProperty -name Tag -Value $Variable.Tag
			add-member -inputobject $Raw -MemberType NoteProperty -name ID -Value $Variable.ID
			add-member -inputobject $Raw -MemberType NoteProperty -name IsDisabled -Value $Variable.IsDisabled
			add-member -inputobject $Raw -MemberType NoteProperty -name IsSystem -Value $Variable.IsSystem
			add-member -inputobject $Raw -MemberType NoteProperty -name AvailableOnClient -Value $Variable.AvailableOnClient
			add-member -inputobject $Raw -MemberType NoteProperty -name VariableType -Value $Variable.VariableType
			if ($Variable.GenTypeData) {
				foreach ($GenTypeData in $($Variable.GenTypeData|get-member -membertype properties)) { 
					add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $Variable.GenTypeData.$($GenTypeData.Name)
				}
			}
			$AllVariable +=@($Raw)
		} 
	}
	return $AllVariable
}
function Convert-DSM7VariabletoPSObject {
	[CmdletBinding()] 
	param (
		$DSM7Object,
		$DSM7VariableGroups
	)
	$DSM7VariableGroups = Convert-ArrayToHash -myArray $DSM7VariableGroups -myKey "ID"
	$Raw = New-Object PSObject
	add-member -inputobject $Raw -MemberType NoteProperty -name ID -Value $DSM7Object.ID
	add-member -inputobject $Raw -MemberType NoteProperty -name IsInherited -Value $DSM7Object.IsInherited
	add-member -inputobject $Raw -MemberType NoteProperty -name SchemaTag -Value $DSM7Object.SchemaTag
	add-member -inputobject $Raw -MemberType NoteProperty -name TargetObjectID -Value $DSM7Object.TargetObjectID
	add-member -inputobject $Raw -MemberType NoteProperty -name Value -Value $DSM7Object.Value
	add-member -inputobject $Raw -MemberType NoteProperty -name VariableID -Value $DSM7Object.VariableID
	add-member -inputobject $Raw -MemberType NoteProperty -name VariableName -Value $DSM7VariableGroups.Item($DSM7Object.VariableID).Tag
	add-member -inputobject $Raw -MemberType NoteProperty -name GroupID -Value $DSM7VariableGroups.Item($DSM7Object.VariableID).GroupID
	add-member -inputobject $Raw -MemberType NoteProperty -name GroupName -Value $DSM7VariableGroups.Item($DSM7Object.VariableID).GroupTag
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData|get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}

	return $Raw

}
function Convert-DSM7VariabletoPSObjects {
	[CmdletBinding()] 
	param (
		$DSM7Objects
	) 
	$VariableGroups = Get-DSM7VariableGroups
	foreach ($DSM7Object in $DSM7Objects) {
		$DSM7Object = Convert-DSM7VariabletoPSObject -DSM7Object $DSM7Object -DSM7VariableGroups $VariableGroups
		$DSM7ObjectList += @($DSM7Object)
	}
	return $DSM7ObjectList
}
function Convert-DSM7AssociationSchemaListtoPSObject {
	[CmdletBinding()] 
	param ( 
		$DSM7Object,
		$DSM7ObjectMembers
	)
	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0){
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists|Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers){
						for ($I = 0;$I -lt $DSM7ObjectMemberLists.Count; $I++){
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData|get-member -membertype properties)) { 
									add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
								}
							} 
							else {
								add-member -inputobject $Raw -MemberType NoteProperty -name "$DSM7ObjectMember.$I.$DSM7ObjectMemberListsMember" -Value $DSM7ObjectMemberLists.$DSM7ObjectMemberListsMember[$I]
							}
						}
					}
				}
				else {
					add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember

				}
			}
			else {
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember
			}
		} 
	}
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData|get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}
	if ($DSM7Object.PropGroupList) {
		foreach ($PropGroup in $DSM7Object.PropGroupList) {
			$Groupname = $PropGroup.Tag
			foreach ($Prop in $PropGroup.PropertyList) {
				$TypedValue = $Prop.TypedValue
				if ($Prop.Type -eq "CatalogLink" -and $TypedValue -and $LDAP) {
					add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag).Name" -Value (Get-DSM7ObjectObject -ID $TypedValue -ObjectGroupType "Catalog" ).Name
				}
				add-member -inputobject $Raw -MemberType NoteProperty -name "$Groupname.$($Prop.Tag)" -Value $Prop.TypedValue
			}
		}
	} 

	return $Raw
}

function Convert-DSM7AssociationSchemaListtoPSObjects {
	[CmdletBinding()] 
	param ( 
		$DSM7Objects
	)
	$DSM7ObjectMembers = ($DSM7Objects|Get-Member -MemberType Properties).Name

	foreach ($DSM7Object in $DSM7Objects) {
		$DSM7Object = Convert-DSM7AssociationSchemaListtoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers
		$DSM7ObjectList += @($DSM7Object)
	}
	return $DSM7ObjectList
}
###############################################################################
# DSM7 Funktionen - Objekte
###############################################################################
function Get-DSM7ObjectList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Objekten zur�ck. 
	.DESCRIPTION
		Gibt eine Liste von Objekten zur�ck. 
	.EXAMPLE
		Get-DSM7ObjectList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
	.EXAMPLE
		Get-DSM7ObjectList -LDAProot "<LDAP://rootCatalog>" -Filter "(&(Name=Windows 10 \(x64\))(PatchCa
tegoryObject.RequiredLicense=DSM7_LUMENSION_PATCH))" -Attributes "PatchCategoryObject.RequiredLicense"

	.NOTES
		Nur benutzen wenn man die Objektstruktur genau kennt! Es kann sonst zu langen Anwortzeiten oder Fehlern kommen!
		Alternativen:
		Get-DSM7SoftwareList
		Get-DSM7ComputerList
	.LINK
		Get-DSM7ObjectList
	.LINK
		Get-DSM7Object
	.LINK
		Get-DSM7Objects
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Attributes,
		[system.string]$Filter,
		[system.string]$LDAPPath = "", 
		[system.string]$LDAProot = "<LDAP://rootDSE>", 
		[int]$ParentContID,
		[switch]$GenTypeData = $false,
		[switch]$recursive = $false
	)
	if (Confirm-Connect) {
		try {
			if ($LDAPPath -or $ParentContID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				$Filternew = "(&(ParentContID=$ParentContID)$Filter)"
			}
			else {
				$Filternew = $Filter
			}
			if ($GenTypeData){
				if ($Attributes) {
					$Attributes = $Attributes + "," + $DSM7GenTypeData
				}
				else {
					$Attributes = $DSM7GenTypeData
				}
			}
			$Webrequest = Get-DSM7RequestHeader -action "GetObjectList"
			$Webrequest.LdapQuery = "$LDAProot;$Filternew;BasePropGroupTag,Description,ParentContID,UniqueId,$Attributes;subtree" 
			$Webrequest.OrderBy = "Name" 
			$Webrequest.MaxResults = -1 
			$Webresult = $($DSM7WebService.GetObjectList($Webrequest)).ObjectList 
			if ($recursive -and $ParentContID) {
				foreach ($WebresultRaw in $Webresult) {
					if ($WebresultRaw.SchemaTag -eq "Domain" -or $WebresultRaw.SchemaTag -eq "OU" -or $WebresultRaw.SchemaTag -eq "SwFolder" -or $WebresultRaw.SchemaTag -eq "CitrixFarm" -or $WebresultRaw.SchemaTag -eq "CitrixZone" -or $WebresultRaw.SchemaTag -eq "SwLibrary") {
						$Webresultsub = Get-DSM7ObjectList -Attributes $Attributes -Filter $Filter -ParentContID $WebresultRaw.ID -recursive 
						if ($Webresultsub) {
							$Webresult += $Webresultsub
						}
					}
				}
			}
			if ($Webresult.count -gt 0) {
				$Webresult = Convert-DSM7ObjectListtoPSObject($Webresult) 
				Write-Log 0 "($Filter$LDAPPath) erfolgreich." $MyInvocation.MyCommand
				return $Webresult
			}
			else {
				Write-Log 1 "($Filter$LDAPPath) nicht gefunden!!!" $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7ObjectList
function Get-DSM7ObjectObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID, 
		[system.string]$ObjectGroupType = "Object"
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetObject"
		$Webrequest.ObjectId = $ID
		$Webrequest.RequestedObjectGroupType = $ObjectGroupType
		$Webresult = $DSM7WebService.GetObject($Webrequest).RetrievedObject
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
if ($Dev) {Export-ModuleMember -Function Get-DSM7ObjectObject}
function Get-DSM7Object {
	<#
	.SYNOPSIS
		Ermittelt DSM Objekt.
	.DESCRIPTION
		Ermittelt DSM Objekt.
	.EXAMPLE
		Get-DSM7Objekt -ID 123456
	.NOTES
	.LINK
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID, 
		[system.string]$ObjectGroupType = "Object"
	)
	if (Confirm-Connect) {
		$return = Get-DSM7ObjectObject -ID $ID -ObjectGroupType $ObjectGroupType
		if ($return) {
			$return = Convert-DSM7ObjecttoPSObject($return)
			Write-Log 0 "ID ($ID) und Objectgruppe ($ObjectGroupType) erfolgreich." $MyInvocation.MyCommand
			return $return
		}
		else {
			Write-Log 2 "ID ($ID) und Objectgruppe ($ObjectGroupType) nicht erfolgreich!" $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7Object
function Get-DSM7ObjectsObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		$IDs, 
		[system.string]$ObjectGroupType = "Object"
	)
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetObjects"
		$Webrequest.ObjectIds = $IDs
		$Webrequest.RequestedObjectGroupType = $ObjectGroupType
		$Webresult = $DSM7WebService.GetObjects($Webrequest).ObjectList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7Objects {
	<#
	.SYNOPSIS
		Gibt eine Liste von Objekten zur�ck. 
	.DESCRIPTION
		Gibt eine Liste von Objekten zur�ck. Nur benutzen wenn man die Objektstruktur genau kennt!!!
	.EXAMPLE
		Get-DSM7Objects -IDs (1,2,3)
	.NOTES
	.LINK
		Get-DSM7ObjectList
	.LINK
		Get-DSM7Object
	.LINK
		Get-DSM7Objects
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[System.Array]$IDs, 
		[system.string]$ObjectGroupType = "Object"
	)
	$result = Get-DSM7ObjectsObject -IDs $IDs -ObjectGroupType $ObjectGroupType
	if ($result) {
		return Convert-DSM7ObjectListtoPSObject($result)
	}
	else {
		return $false
	}
}
Export-ModuleMember -Function Get-DSM7Objects
function Update-DSM7Object {
	[CmdletBinding()] 
	param ( 
		$Object,
		[string[]]$Values
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdateObject"
		$WebrequestState = Get-DSM7RequestHeader -action "UpdateStateInfoOfObject"
		if (!$DSM7PropGroupDefList){
			$global:DSM7PropGroupDefList = Convert-ArrayToHash -myArray (Get-DSM7PropGroupDefListObject) -myKey "Tag" 

		}
		$groupkey = @{}
		$valueskey = @{}
		foreach ($Value in $Values) {
			$ValueName = $Value.split("=",2)[0]
			$ValueValue = $Value.split("=",2)[1]
			if ($ValueName.contains(".")) {
				$PropGroup = $ValueName.split(".")[0]
				$PropName = $ValueName.split(".")[1]
				$Valueskey[$PropName] = $ValueValue
				$groupkey[$PropGroup] += $Valueskey
				$valueskey = @{}
			}
			else {
				if (($ValueValue).contains(":String") -or ($ValueValue).contains(":Option")) {
					$Object.$ValueName = $ValueValue.split(":")[0]
				}
				else {
					$Object.$ValueName = $ValueValue
				}
			}
		}
		$StateInfo = $false
		$PropGroupList = @()
		$PropGroupListStateInfo = @()
		foreach ($Groupname in $groupkey.keys) {
			$PropertyList = @()
			foreach ($Valuename in $groupkey.$groupname.keys) {
				if (($groupkey.$groupname.$Valuename).contains(":String") -or ($groupkey.$groupname.$Valuename).contains(":Option") ) {
					$Value = $groupkey.$groupname.$Valuename.split(":")[0]
				}
				else {
					$Value = $groupkey.$groupname.$Valuename
				}
				Write-Log 0 "�ndere $Groupname.$Valuename = $Value" $MyInvocation.MyCommand
				$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
				$PropertyListObject.Tag = $Valuename
				$PropertyListObject.Type = ($DSM7PropGroupDefList.$groupname.PropertyDefList|where Tag -EQ $Valuename).propertytype
				$PropertyListObject.TypedValue = $Value
				$PropertyList += $PropertyListObject
			}
			$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
			$PropGroupListObject.Tag = $Groupname
			$PropGroupListObject.PropertyList = $PropertyList
			$PropGroupList += $PropGroupListObject
			if ($DSM7PropGroupDefList.$Groupname.PropGroupInfoType -eq "StateInfo") {
				$StateInfo = $true
				$PropGroupListStateInfo += $PropGroupListObject
			}
		}
		$Webrequest.ObjectToUpdate = $Object

		$Webrequest.ObjectToUpdate.PropGroupList = $PropGroupList
		$Object = $DSM7WebService.UpdateObject($Webrequest).UpdatedObject
		if ($StateInfo) {
			$WebrequestState.ObjectToUpdate = $Object
			$WebrequestState.ObjectToUpdate.PropGroupList = $PropGroupListStateInfo
			$Object = $DSM7WebService.UpdateStateInfoOfObject($WebrequestState).UpdatedObject
		}
		Write-Log 0 "($($Object.Name)) erfolgreich." $MyInvocation.MyCommand
		return $Object 
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7LDAPPath {
	<#
	.SYNOPSIS
		Gibt ein den LDAP Path zur�ck. 
	.DESCRIPTION
		Gibt ein den LDAP Path zur�ck. 
	.EXAMPLE
		Get-DSM7LDAPPath -ParentContID 1234
	.NOTES
	.LINK
		Get-DSM7ObjectList
	.LINK
		Get-DSM7Object
	.LINK
		Get-DSM7Objects
	#>
	[CmdletBinding()] 
	param ( 
		[int]$ParentContID = 0
	)
	[system.string]$LDAPPath = ""
	while ($ParentContID -ne 0) { 

		$Container = Get-DSM7OrgTreeContainerObject -ID $ParentContID
		$ParentContID = $Container.ParentContID
		$LDAPPath = "/" + $Container.Name + $LDAPPath
	} 
	return $LDAPPath.TrimStart("/")
}
Export-ModuleMember -Function Get-DSM7LDAPPath
function Get-DSM7LDAPPathID {
	[CmdletBinding()] 
	param ( [system.string]$LDAPPath, [int]$ParentContID)
	try {
		if ($LDAPPath.Contains("/")) {
			foreach ($ParentCont in $LDAPPath.split("/")) {

				if ($ParentContID -eq 0) {
					$Filter = "(&(Name:IgnoreCase=$ParentCont)$DSM7Structure)"
				}
				else {
					$Filter = "(&(Name:IgnoreCase=$ParentCont)(ParentContID=$ParentContID)$DSM7Structure)"
				}
				$result = Get-DSM7ObjectList -Filter $Filter
				if ($result) {
					$ParentCont = $result.Name
					$ParentContID = $result.ID
				}
				else {
					$ParentContID = 0
				}
			} 
		}
		else {
			$Filter = "(&(Name:IgnoreCase=$LDAPPath)$DSM7Structure)"
			$result = Get-DSM7ObjectList -Filter $Filter
			if ($result) {
				$ParentCont = $result.Name
				$ParentContID = $result.ID
			}
			else {
				$ParentContID = 0
			}
		} 
		return $ParentContID
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function New-DSM7Object {
	[CmdletBinding()] 
	param (
		[system.string]$Name,
		[system.string]$Description,
		[int]$ParentContID,
		[system.string]$SchemaTag,
		$PropGroupList,
		[system.string]$GroupType = "Object",
		[system.string]$UniqueID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreateObject"
		$Webrequest.NewObject = New-Object $DSM7Types["MdsObject"] 
		$Webrequest.NewObject.SchemaTag = $SchemaTag
		$Webrequest.NewObject.Name = $Name
		if ($DSM7Version -gt "7.4.0") {
			$Webrequest.NewObject.GenTypeData = new-object $DSM7Types["MdsGenType"]
			$CreationSource = $MyInvocation.MyCommand.Module.Name
			if ($DSM7CreationSource) {$CreationSource = $DSM7CreationSource}
			$Webrequest.NewObject.GenTypeData.CreationSource = $CreationSource
		}
		$Webrequest.NewObject.Description = $Description
		if ($SchemaTag -eq "ExternalGroup" ) {
			$Webrequest.NewObject.IdProvider = "AD"
			$Webrequest.NewObject.UniqueID = $UniqueID
		} 
		$Webrequest.NewObject.PropGroupList = $PropGroupList
		$Webrequest.NewObject.ParentContID = $ParentContID
		$Webrequest.NewObject.GroupType = $GroupType
		$Webresult = $DSM7WebService.CreateObject($Webrequest).CreatedObject
		Write-Log 0 "($Name) erfolgreich." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Remove-DSM7Object {
	[CmdletBinding()] 
	param (
		$Object
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeleteObject"
		$Webrequest.ObjectToDelete = $Object
		$Webresult = $DSM7WebService.DeleteObject($Webrequest).DeleteObjectResult 
		Write-Log 0 "L�schen Objekt $($Object.Name) ($($Object.ID)) erfolgreich." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Move-DSM7Object {
	[CmdletBinding()] 
	param (
		$Object,
		$ParentContID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "MoveObject"
		$Webrequest.ObjectToMove = $Object
		$Webrequest.NewParentOrgTreeContainer = Get-DSM7OrgTreeContainerObject -ID $ParentContID
		$Webresult = $DSM7WebService.MoveObject($Webrequest).MovedObject
		Write-Log 0 "MovedObject $($Object.Name) ($($Object.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
###############################################################################
# DSM7 Funktionen - Association
###############################################################################
function Get-DSM7AssociationListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$SchemaTag,
		[system.string]$SourceObjectID = "*",
		[system.string]$TargetObjectID = "*",
		[system.string]$TargetSchemaTag = "*"
	)
	if (Confirm-Connect) {
		try {
			$IDs = @()
			$ObjectIDs = @()
			$Filter = "(&(SchemaTag=$SchemaTag)(TargetObjectID=$TargetObjectID)(SourceObjectID=$SourceObjectID)(TargetSchemaTag=$TargetSchemaTag))"
			$Webrequest = Get-DSM7RequestHeader -action "GetAssociationList"
			$Webrequest.LdapQuery = "<LDAP://rootDSE>;$Filter;;subtree" 
			$Webrequest.MaxResults = -1 
			$Webresult = $($DSM7WebService.GetAssociationList($Webrequest)).AssociationList 
			if ($Webresult.count -gt 0) {
				foreach ($DSM7Object in $Webresult) {
					$IDs += $DSM7Object.ID
				}
				$IDs = $($IDs|sort -Unique)
				$Webresult = Get-DSM7AssociationsObject -IDs $IDs -SchemaTag $SchemaTag 
				return $Webresult
			}
			else {
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
function Get-DSM7AssociationList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Association zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Association zur�ck.
	.EXAMPLE
		Get-DSM7AssociationList -SchemaTag "ComputerAssociatedUser"
	.NOTES
	.LINK
		Get-DSM7AssociationList
	.LINK
		Get-DSM7AssociationschemaList
	.LINK
		New-DSM7Association
	#>

	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$SchemaTag,
		[system.string]$SourceObjectID = "*",
		[system.string]$TargetObjectID = "*",
		[system.string]$TargetSchemaTag = "*",
		[switch]$resolvedName = $false
	)
	if (Confirm-Connect) {
		if (!$DSM7AssociationSchemaList) {
			$global:DSM7AssociationSchemaList = Get-DSM7AssociationschemaList|select -ExpandProperty Tag
		}
		if ($DSM7AssociationSchemaList.Contains($SchemaTag)) {
			$result = Get-DSM7AssociationListObject -SchemaTag $SchemaTag -SourceObjectID $SourceObjectID -TargetObjectID $TargetObjectID -TargetSchemaTag $TargetSchemaTag
			if ($result) {
				$result = Convert-DSM7AssociationListtoPSObject -ObjectList $result -resolvedName:$resolvedName
				Write-Log 0 "Liste von $SchemaTag erfolgreich." $MyInvocation.MyCommand
				return $result
			}
		}
		else {
			Write-Log 1 "$SchemaTag nicht vorhanden!!! Bite folgende verwenden ($DSM7AssociationSchemaList)." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7AssociationList
function Get-DSM7AssociationschemaListObject {
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetAssociationSchemaList"
		$Webrequest.SchemaTags = @()
		$Webresult = $DSM7WebService.GetAssociationSchemaList($Webrequest).SchemaList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7AssociationschemaList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Association Schemas zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Association Schemas zur�ck.
	.EXAMPLE
		Get-DSM7AssociationList 
	.NOTES
	.LINK
		Get-DSM7AssociationList
	.LINK
		Get-DSM7AssociationschemaList
	.LINK
		New-DSM7Association
	#>
	[CmdletBinding()] 
	param ( 
	)
	if (Confirm-Connect) {
		$result = Get-DSM7AssociationschemaListObject
		if ($result) {
			$result = Convert-DSM7AssociationSchemaListtoPSObjects -DSM7Objects $result
			Write-Log 0 " Liste von Association Schemas erfolgreich." $MyInvocation.MyCommand 
		}
		else {
			Write-Log 1 " Liste von Association Schemas konte nicht ermitteltwerden!" $MyInvocation.MyCommand 

		}
		return $result
	}

}
Export-ModuleMember -Function Get-DSM7AssociationschemaList
function Get-DSM7AssociationObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID, 
		[Parameter(Position=1, Mandatory=$true)]
		[system.string]$SchemaTag
	)
	if (Confirm-Connect) {
		try {
			$Webrequest = Get-DSM7RequestHeader -action "GetAssociation"
			$Webrequest.AssociationId = $ID
			$Webrequest.SchemaTag = $SchemaTag
			$Webresult = $DSM7WebService.GetAssociation($Webrequest).RetrievedAssociation
			return $Webresult
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Get-DSM7AssociationsObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		$IDs ,
		[Parameter(Position=1, Mandatory=$true)]
		[system.string]$SchemaTag
	)
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetAssociations"
		$Webrequest.AssociationIds = $IDs
		$Webrequest.SchemaTag = $SchemaTag
		$Webresult = $DSM7WebService.GetAssociations($Webrequest).AssociationList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function New-DSM7AssociationObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$SchemaTag,
		[Parameter(Position=1, Mandatory=$true)]
		[Int]$SourceObjectID,
		[Parameter(Position=2, Mandatory=$true)]
		[Int]$TargetObjectID,
		[Parameter(Position=3, Mandatory=$true)]
		[system.string]$TargetSchemaTag
	) 
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreateAssociation"
		$Webrequest.NewAssociation = New-Object $DSM7Types["MdsAssociation"]
		$Webrequest.NewAssociation.SchemaTag = $SchemaTag
		$Webrequest.NewAssociation.SourceObjectID = $SourceObjectID
		$Webrequest.NewAssociation.TargetObjectID = $TargetObjectID
		$Webrequest.NewAssociation.TargetSchemaTag = $TargetSchemaTag
		$Webresult = $DSM7WebService.CreateAssociation($Webrequest).CreatedAssociation
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function New-DSM7Association {
	<#
	.SYNOPSIS
		Neue Association wird erstellt.
	.DESCRIPTION
		Neue Association wird erstellt.
	.EXAMPLE
		New-DSM7Association -SchemaTag "Schema" -SourceObjectID 1234 -TargetSchemaTag "Schema" -TargetObjectID 1234 
	.NOTES
	.LINK
		Get-DSM7AssociationList
	.LINK
		Get-DSM7AssociationschemaList
	.LINK
		New-DSM7Association
	#>

	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$SchemaTag,
		[Parameter(Position=1, Mandatory=$true)]
		[system.Int32]$SourceObjectID,
		[Parameter(Position=2, Mandatory=$true)]
		[system.string]$TargetSchemaTag,
		[Parameter(Position=3, Mandatory=$true)]
		[System.Int32]$TargetObjectID
	)
	if (Confirm-Connect) {
		if (!$DSM7AssociationSchemaList) {
			$global:DSM7AssociationSchemaList = Get-DSM7AssociationsObjectchemaList|select -ExpandProperty Tag
		}
		if ($DSM7AssociationSchemaList.Contains($SchemaTag) -and $SourceObjectID -gt 0 -and $TargetObjectID -0 -and $TargetSchemaTag) {
			$result = New-DSM7AssociationObject -SchemaTag $SchemaTag -SourceObjectID $SourceObjectID -TargetObjectID $TargetObjectID -TargetSchemaTag $TargetSchemaTag
			if ($result) {
				$result = Convert-DSM7AssociationtoPSObject($result)
				Write-Log 0 "Neue Association von $SchemaTag erfolgreich." $MyInvocation.MyCommand
				return $result
			}
		}
		else {
			Write-Log 1 "$SchemaTag nicht vorhanden!!! Bite folgende verwenden ($DSM7AssociationSchemaList)." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function New-DSM7Association
function New-DSM7AssociationListObject {
	[CmdletBinding()] 
	param (
		[PSObject[]]$Objects
	) 
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreateAssociationList  AssociationListToCreate"
		$ObjectMdsAssociations = @()
		foreach ($Object in $Objects) {
			$ObjectMdsAssociation = New-Object $DSM7Types["MdsAssociation"]
			$ObjectMdsAssociation.SchemaTag = $Object.SchemaTag
			$ObjectMdsAssociation.SourceObjectID = $Object.SourceObjectID
			$ObjectMdsAssociation.TargetObjectID = $Object.TargetObjectID
			$ObjectMdsAssociation.TargetSchemaTag = $Object.TargetSchemaTag
			$ObjectMdsAssociations += $ObjectMdsAssociation
		}
		$Webrequest.AssociationListToCreate= $ObjectMdsAssociations
		$Webresult = $DSM7WebService.CreateAssociationList($Webrequest).CreatedListOfAssociations
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7AssociationObject {
	[CmdletBinding()] 
	param (
		$Object
	) 
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeleteAssociation"
		$Webrequest.AssociationToDelete = $Object
		$Webresult = $DSM7WebService.DeleteAssociation($Webrequest)
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
###############################################################################
# DSM7 Funktionen - NameList
###############################################################################
function Get-DSM7DisplayNameListsObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetDisplayNameLists"
		$Webrequest.DisplayNameIds = $IDs
		$Webresult = $DSM7WebService.GetDisplayNameLists($Webrequest).DisplayNames
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7DisplayNameLists {
	<#
	.SYNOPSIS
		Gibt DisplayNameList zur�ck.
	.DESCRIPTION
		Gibt DisplayNameList zur�ck.
	.EXAMPLE
		Get-DSM7GetDisplayNameLists -IDs 1,2,3,4,5 
	.NOTES
	.LINK
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		$IDs
	)
	if (Confirm-Connect) {
		try {
			$result = Get-DSM7DisplayNameListsObject
			if ($result) {
				Write-Log 0 "($IDs) erfolgreich." $MyInvocation.MyCommand
				return $Webresult
			}
			else {
				Write-Log 1 "($IDs) nicht gefunden!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7DisplayNameLists
###############################################################################
# DSM7 Funktionen - Computer
###############################################################################
function Get-DSM7ComputerList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Computern zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Computern zur�ck.
	.EXAMPLE
		Get-DSM7ComputerList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Attributes,
		[system.string]$Filter,
		[system.string]$LDAPPath = "",
		[int]$ParentContID,
		[switch]$GenTypeData = $false,
		[switch]$recursive = $false
	)
	if (Confirm-Connect) {
		if ($LDAPPath) {
			$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
		}
		if ($recursive) {
			if ($ParentContID -gt 0) {
				$result = @()
				$resultComputer = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=Computer)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
				if ($resultComputer) {
					$result += $resultComputer
				} 
				$resultContainer = Get-DSM7ObjectList -Filter $DSM7Container -ParentContID $ParentContID -recursive
				foreach ($Container in $resultContainer) {
					$FilterContainer = "(&(ParentContID=$($Container.ID))(SchemaTag=Computer)$filter)"
					$resultComputer = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer 
					if ($resultComputer) {
						$result += $resultComputer
					}
				} 
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=Computer)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
		}
		else {
			if ($ParentContID -gt 0) {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=Computer)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=Computer)$Filter)" -GenTypeData:$GenTypeData
			}
		}
		if ($result) {
			return $result
		}
		else {
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ComputerList
function Get-DSM7Computer {
	<#
	.SYNOPSIS
		Gibt das Computerobjekt zur�ck.
	.DESCRIPTION
		Gibt das Computerobjekt zur�ck.
	.EXAMPLE
		Get-DSM7Computer -Name "%Computername%" 
		Get-DSM7Computer -ID 1234
		Get-DSM7Computer -Name "%Computername%" -LDAPPath "Managed Users & Computers/OU"
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[int]$ID,
		[system.string]$LDAPPath,
		[switch]$LDAP = $false
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$Name)(Schematag=Computer)" -LDAPPath $LDAPPath
					if ($search.Count -lt 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "($Name) nicht eindeutig bitte LDAPPath benutzen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$result = Get-DSM7ObjectObject -ID $ID
					if ($result) {
						$result = Convert-DSM7ObjecttoPSObject($result) -LDAP:$LDAP
						Write-Log 0 "($($result.Name)) erfolgreich." $MyInvocation.MyCommand
						return $result
					}
					else {
						Write-Log 1 "Computer nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "Computer nicht gefunden!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7Computer
function Update-DSM7Computer {
	<#
	.SYNOPSIS
		�ndert das Computerobjekt.
	.DESCRIPTION
		�ndert das Computerobjekt.
	.EXAMPLE
		Update-DSM7Computer -Name "%Computername%" -Values @("Computer.AssetTag=Test")
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[int]$ID,
		[system.string]$LDAPPath,
		[string[]]$Values,
		[switch]$LDAP = $false
	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "�nderung kann nicht erfolgen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Computer = Get-DSM7ObjectObject -ID $ID
					$result = Update-DSM7Object -Object $Computer -Values $Values
					if ($result) { 
						$result = Convert-DSM7ObjecttoPSObject($result) -LDAP:$LDAP
						Write-Log 0 "($($Computer.Name)) erfolgreich." $MyInvocation.MyCommand
						return $result
					}
					else {
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Update-DSM7Computer

function Reset-DSM7ComputerInstallationOrder {
	[CmdletBinding()] 
	param ( [int]$ID)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ResetInstallationOrderOfNode"
		$Webrequest.NodeId = $ID
		$Webresult = $DSM7WebService.ResetInstallationOrderOfNode($Webrequest).ResetInstallationOrderOfNodeResult
		Write-Log 0 "Computer ($ID) neue Installationreihenfolge berechnet." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Install-DSM7ReinstallComputer {
	[CmdletBinding()] 
	param ( 
		$Computer ,
		[switch]$StartReinstallImmediately,
		[switch]$WakeUp,
		[DateTime]$WakeUpTime,
		[switch]$UpdatePolicyInstancesToPolicyStatus
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ReinstallComputer"
		$Webrequest.Computer = $Computer
		$Webrequest.Options = New-Object $DSM7Types["ReinstallComputerOptions"]
		$Webrequest.Options.StartReinstallImmediately = $StartReinstallImmediately
		if ($WakeUp) {
			$Webrequest.Options.WakeUpForExecutionOptions = New-Object $DSM7Types["WakeUpForExecutionOptions"]
			$Webrequest.Options.WakeUpForExecutionOptions.WakeUp = $WakeUp
			$Webrequest.Options.WakeUpForExecutionOptions.ActivationStartDate = $WakeUpTime
		}
		$Webrequest.Options.UpdatePolicyInstancesToPolicyStatus = $UpdatePolicyInstancesToPolicyStatus
		$Webresult = $DSM7WebService.ReinstallComputer($Webrequest).ReinstallComputerResult
		Write-Log 0 "Computer auf Reinstall gesetzt." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Install-DSM7Computer {
	<#
	.SYNOPSIS
		Installiert den Computer neu.
	.DESCRIPTION
		Installiert den Computer neu.
	.EXAMPLE
		Install-DSM7Computer -Name "%Computername%" -UpgradePolicyInstances -RecalculateInstallationOrder -UpdatePolicyInstancesActive
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.int32]$ID,
		[switch]$RecalculateInstallationOrder,
		[switch]$UpgradePolicyInstances,
		[switch]$UpdatePolicyInstancesActive
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7Computer -Name $Name
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Installation kann nicht erfolgen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					if (!($DSM7Version -gt "7.3.0")) {
						$result = Update-DSM7Computer -ID $ID -Values @("Computer.OperationMode=2")
					}
					else {
						$result = Update-DSM7Computer -ID $ID -Values @("Computer.OperationMode=0")

					}
					if ($RecalculateInstallationOrder) {
						$result = Reset-DSM7ComputerInstallationOrder -ID $ID
					}
					if ($UpgradePolicyInstances) {
						$result = Upgrade-DSM7PolicyInstancesByNodeObject -NodeId $ID
					} 
					if ($UpdatePolicyInstancesActive) {
						$result = Update-DSM7PolicyInstancesActive -ID $ID
					}
					if ($DSM7Version -gt "7.3.0") {
						if (Install-DSM7ReinstallComputer -Computer $(Get-DSM7ObjectObject -ID $ID) -StartReinstallImmediately -UpdatePolicyInstancesToPolicyStatus) {
							Write-Log 0 "Computer ($ID) auf Neuinstallation gesetzt." $MyInvocation.MyCommand
							return $true
						}
					} 
					else {
						if (Update-DSM7Computer -ID $ID -Values @("Computer.OperationMode=1")) {
							Write-Log 0 "Computer ($ID) auf Neuinstallation gesetzt." $MyInvocation.MyCommand
							return $true
						}
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}
		} 
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Install-DSM7Computer 
function New-DSM7Computer {
	<#
	.SYNOPSIS
		Legt ein neues Computerobjekt an.
	.DESCRIPTION
		Legt ein neues Computerobjekt an.
	.EXAMPLE
		New-DSM7Computer -Name "%Computername%" -LDAPPath "Managed Users & Computers/OU1/OU2" -InitialMACAddress "012345678912" -Values @("Computer.ComputerType=Server","Description=Test123")
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param (
		[system.string]$Name,
		[system.string]$LDAPPath,
		[int]$ParentContID,
		[string[]]$Values,
		[system.string]$InitialMACAddress
	)
	if (Confirm-Connect) {
		try {
			$result = Get-DSM7ComputerList -Filter "(BasicInventory.InitialMACAddress:IgnoreCase=$InitialMACAddress)"
			if (!$result) {
				$SchemaTag = "Computer"
				if ($ParentContID -eq 0) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				$result = New-DSM7Object -Name $Name -ParentContID $ParentContID -SchemaTag $SchemaTag
				$Values += "BasicInventory.InitialMACAddress="+$InitialMACAddress
				$result = Update-DSM7Object -Object $result -Values $Values
				if ($result) { 
					$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
					Write-Log 0 "($Name) erfolgreich in OU ($($result.LDAPPath))." $MyInvocation.MyCommand
					return $result
				}
				else {
					return $false
				}
			}
			else {
				Write-Log 1 "Computer mit MAC ($InitialMACAddress) existiert schon!" $MyInvocation.MyCommand
				return $false
			}
		} 
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function New-DSM7Computer 
function Remove-DSM7Computer {
	<#
	.SYNOPSIS
		L�scht ein Computerobjekt.
	.DESCRIPTION
		L�scht ein Computerobjekt.
	.EXAMPLE
		 Remove-DSM7Computer -Name "%Computername%"
	.EXAMPLE
		 Remove-DSM7Computer -InitialMACAddress "012345678912"
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param (
		[system.string]$Name = "*",
		[int]$ID,
		[system.string]$LDAPPath, 
		[system.string]$InitialMACAddress = "*"
	)
	if (Confirm-Connect) {
		try {
			if ($Name -ne "*" -or $InitialMACAddress -ne "*" -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7ComputerList -Filter "(&(BasicInventory.InitialMACAddress:IgnoreCase=$InitialMACAddress)(Name:IgnoreCase=$Name))" -LDAPPath $LDAPPath
					if ($search.Count -lt 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "L�schen kann nicht erfolgen! Bitte LDAPPath benutzen." $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Computer = Get-DSM7ObjectObject -ID $ID
					$result = Remove-DSM7Object -Object $Computer 
					Write-Log 0 "Computer ($($Computer.Name)) gel�scht." $MyInvocation.MyCommand
					return $true
				}
				else {
					Write-Log 1 "Computer nicht gefunden!!!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7Computer 
function Move-DSM7Computer {
	<#
	.SYNOPSIS
		Verschiebt ein Computerobjekt.
	.DESCRIPTION
		Verschiebt ein Computerobjekt.
	.EXAMPLE
		Move-DSM7Computer -Name "%Computername%" -toLDAPPath "Managed Users & Computers/OU1/OU2"
	.NOTES
	.LINK
		Get-DSM7ComputerList
	.LINK
		Get-DSM7Computer
	.LINK
		Update-DSM7Computer
	.LINK
		Install-DSM7Computer
	.LINK
		New-DSM7Computer
	.LINK
		Remove-DSM7Computer
	.LINK
		Move-DSM7Computer
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$toLDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[Int]$toLDAPPathID
	)
	if (Confirm-Connect) {
		try {
			if (($Name -or $ID -gt 0) -and ($toLDAPPath -or $toLDAPPathID -gt 0) ) {
				if ($ID -eq 0) {
					$search = Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Computer kann nicht nach ($toLDAPPath) verschoben werden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					if ($toLDAPPathID -gt 0) {
						$ParentContID = $toLDAPPathID
					}
					else {
						$ParentContID = Get-DSM7LDAPPathID -LDAPPath $toLDAPPath
					} 
					$Object = Get-DSM7ObjectObject -ID $ID
					if ($Object) {
						if ($Object.ParentContID -eq $ParentContID) {
							Write-Log 1 "Computer ($Name) befindet sich schon in ($($Object.ParentContID)." $MyInvocation.MyCommand
							return $false
						}
						else {
							$result = Move-DSM7Object -Object $Object -ParentContID $ParentContID
							if ($result) { 
								$result = Convert-DSM7ObjecttoPSObject($result)
								Write-Log 0 "Computer ($($result.Name)) erfolgreich nach ($($result.ParentContID)) verschoben." $MyInvocation.MyCommand
								return $true
							}
							else {
								return $false
							}
						}
					}
					else {
						Write-Log 1 "Computer kann nicht nach ($toLDAPPath$toLDAPPathID) verschoben werden." $MyInvocation.MyCommand
					}
				} 
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Move-DSM7Computer 
###############################################################################
# DSM7 Funktionen - OrgObjekte
function Get-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		[int]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetOrgTreeContainer"
		$Webrequest.OrgTreeContainerId = $ID
		$Webresult = $DSM7WebService.GetOrgTreeContainer($Webrequest).RetrievedOrgTreeContainer
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		Gibt ein Containerobjekt zur�ck.
	.DESCRIPTION
		Gibt ein Containerobjekt zur�ck.
	.EXAMPLE
		Get-DSM7OrgTreeContainer -LDAPPATH "Global Software Library"
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[system.string]$LDAPPath,
		[int]$ID
	)
	if (Confirm-Connect) {
		try {
			if ($ID -eq 0) {
				$ID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
			}
			$result = Get-DSM7OrgTreeContainerObject -ID $ID
			if ($result) {
				Write-Log 0 "($LDAPPath) -> ($ID) erfolgreich." $MyInvocation.MyCommand
				$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
				return $result
			}
			else {
				Write-Log 1 "Konnte kein Object finden!" $MyInvocation.MyCommand
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7OrgTreeContainer 
function Get-DSM7OrgTreeContainersObject {
	[CmdletBinding()] 
	param (
		[System.Array]$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetOrgTreeContainers"
		$Webrequest.OrgTreeContainerIds = $IDs
		$Webresult = $DSM7WebService.GetOrgTreeContainers($Webrequest).OrgTreeContainerList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7OrgTreeContainers {
	<#
	.SYNOPSIS
		Gibt ein Containerobjekt zur�ck.
	.DESCRIPTION
		Gibt ein Containerobjekt zur�ck.
	.EXAMPLE
		Get-DSM7OrgTreeContainers -IDs (xxx,yyy)
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[System.Array]$IDs
	)
	if (Confirm-Connect) {
		try {
			$result = Get-DSM7OrgTreeContainersObject -IDs $IDs
			if ($result) {
				Write-Log 0 "($IDs) erfolgreich." $MyInvocation.MyCommand
				$result = Convert-DSM7ObjectListtoPSObject($result) 
				return $result
			}
			else {
				Write-Log 1 "Konnte kein Object finden!" $MyInvocation.MyCommand
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7OrgTreeContainers 

function New-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$SchemaTag = "OU",
		[Parameter(Position=3, Mandatory=$true)]
		[system.string]$ParentContID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreateOrgTreeContainer"
		$Webrequest.NewOrgTreeContainer = New-Object $DSM7Types["MdsOrgTreeContainer"]
		$Webrequest.NewOrgTreeContainer.Name = $Name
		$Webrequest.NewOrgTreeContainer.SchemaTag = $SchemaTag
		$Webrequest.NewOrgTreeContainer.Description = $Description
		$Webrequest.NewOrgTreeContainer.ParentContID = $ParentContID
		if ($DSM7Version -gt "7.4.0") {
			$Webrequest.NewOrgTreeContainer.GenTypeData = new-object $DSM7Types["MdsGenType"]
			$CreationSource = $MyInvocation.MyCommand.Module.Name
			if ($DSM7CreationSource) {$CreationSource = $DSM7CreationSource}
			$Webrequest.NewOrgTreeContainer.GenTypeData.CreationSource = $CreationSource
		}
		$Webresult = $DSM7WebService.CreateOrgTreeContainer($Webrequest).CreatedOrgTreeContainer
		Write-Log 0 "($Name) ($($Webresult.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult

	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function New-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		Erstellt ein Containerobjekt.
	.DESCRIPTION
		Erstellt ein Containerobjekt.
	.EXAMPLE
		New-DSM7OrgTreeContainer -Name "OU2" -LDAPPATH "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true, HelpMessage = "Name der OU")]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[ValidateSet("OU","Domain","CitrixFarm","CitrixZone","SwFolder")]
		[system.string]$SchemaTag = "OU",
		[Parameter(Position=3, Mandatory=$true)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
			$result = New-DSM7OrgTreeContainerObject -Name $Name -Description $Description -SchemaTag $SchemaTag -ParentContID $ParentContID
			if ($result) {
				Write-Log 0 "($Name) ($LDAPPath) erfolgreich erstellt." $MyInvocation.MyCommand
				$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
				return $result
			}
			else {
				Write-Log 1 "Kein Objekt erzeugt!" $MyInvocation.MyCommand
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function New-DSM7OrgTreeContainer

function Move-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		$Object,
		[system.string]$ParentContID
	)
	try {
		$ParentContObject = Get-DSM7OrgTreeContainerObject -ID $ParentContID
		$Webrequest = Get-DSM7RequestHeader -action "MoveOrgTreeContainer"
		$Webrequest.OrgTreeContainerToMove = $Object
		$Webrequest.NewParentOrgTreeContainer = $ParentContObject
		$Webresult = $DSM7WebService.MoveOrgTreeContainer($Webrequest).MovedOrgTreeContainer 
		Write-Log 0 "($Name) ($($Webresult.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult

	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Move-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		Verschiebt ein Containerobjekt.
	.DESCRIPTION
		Verschiebt ein Containerobjekt.
	.EXAMPLE
		Move-DSM7OrgTreeContainer -Name "OU2" -toLDAPPath "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$true)]
		[system.string]$toLDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Structure)" -LDAPPath $LDAPPath
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Container nicht gefunden, kann nicht nach ($toLDAPPath) verschoben werden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7OrgTreeContainerObject -ID $ID
					if ($Object) {
						$ParentContID = Get-DSM7LDAPPathID -LDAPPath $toLDAPPath
						if ($ParentContID) {
							$result = Move-DSM7OrgTreeContainerObject -Object $Object -ParentContID $ParentContID
							if ($result) {
								Write-Log 0 "($($Object.Name)) ($toLDAPPath) erfolgreich verschoben." $MyInvocation.MyCommand
								$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
								return $result
							}
							else {
								Write-Log 1 "($($Object.Name)) ($toLDAPPath) konnte nicht ausgef�hrt werden." $MyInvocation.MyCommand
								return $false
							}
						}
						else {
							Write-Log 1 "Ziel Container ($LDAPPATH) nicht vorhanden." $MyInvocation.MyCommand
							return $false
						}
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Move-DSM7OrgTreeContainer
function Update-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		$Object
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdateOrgTreeContainer"
		$Webrequest.OrgTreeContainerToUpdate = $Object
		$Webresult = $DSM7WebService.UpdateOrgTreeContainer($Webrequest).UpdatedOrgTreeContainer
		Write-Log 0 "($Name) ($($Webresult.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult

	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Update-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		�ndert ein Containerobjekt.
	.DESCRIPTION
		�ndert ein Containerobjekt.
	.EXAMPLE
		Update-DSM7OrgTreeContainer -Name "OU2"  -Description "OU" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Structure)" -LDAPPath $LDAPPath
					if ($search.Count -lt 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Container nicht gefunden, kann nicht ge�ndert werden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7OrgTreeContainerObject -ID $ID
					if ($Object) {
						if ($Description) {
							$Object.Description = $Description
						}
						$result = Update-DSM7OrgTreeContainerObject -Object $Object 
						if ($result) {
							Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich ge�ndert." $MyInvocation.MyCommand
							$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
							return $result
						}
						else {
							Write-Log 1 "($($Object.Name)) ($LDAPPath) konnte nicht ausgef�hrt werden." $MyInvocation.MyCommand
							return $false
						}
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Update-DSM7OrgTreeContainer

function Remove-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		$Object
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeleteOrgTreeContainer"
		$Webrequest.OrgTreeContainerToDelete = $Object
		$Webresult = $DSM7WebService.DeleteOrgTreeContainer($Webrequest).DeleteOrgTreeContainerResult 
		Write-Log 0 "($Name) ($($Object.ID)) erfolgreich." $MyInvocation.MyCommand
		return $true

	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		L�scht ein Containerobjekt.
	.DESCRIPTION
		L�scht ein Containerobjekt.
	.EXAMPLE
		Remove-DSM7OrgTreeContainer -Name "OU2" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7OrgTreeContainer
	.LINK
		New-DSM7OrgTreeContainer
	.LINK
		Move-DSM7OrgTreeContainer
	.LINK
		Remove-DSM7OrgTreeContainer
	.LINK
		Update-DSM7OrgTreeContainer
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -eq 0) {
					$search = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Structure)" -LDAPPath $LDAPPath
					if ($search -and $search.Count -le 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Container nicht gefunden, kann nicht gel�scht werden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7OrgTreeContainerObject -ID $ID
					if ($Object) {
						$result = Remove-DSM7OrgTreeContainerObject -Object $Object
						if ($result) {
							Write-Log 0 "($Name) ($LDAPPath) erfolgreich gel�scht." $MyInvocation.MyCommand
							$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
							return $result
						}
						else {
							Write-Log 1 "($Name) ($LDAPPath) konnte nicht ausgef�hrt werden." $MyInvocation.MyCommand
							return $false
						}
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7OrgTreeContainer
###############################################################################
# DSM7 Funktionen - Groups
function Get-DSM7Group {
	<#
	.SYNOPSIS
		Gibt ein Gruppenobjekt zur�ck.
	.DESCRIPTION
		Gibt ein Gruppenobjekt zur�ck.
	.EXAMPLE
		Get-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Get-DSM7Group -Name "Gruppe" -ParentDynGroup "Gruppe"
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Add-DSM7ComputerToGroup
	.LINK
		Remove-DSM7ComputerFromGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ParentDynGroupID,
		[Parameter(Position=6, Mandatory=$false)]
		[system.string]$ADSID
	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0 -or $ADSID) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					if ($ParentDynGroup) {
						if ($ParentDynGroup) {
							$ParentDynGroupID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$ParentDynGroup)(Schematag=DynamicGroup))" -ParentContID $ParentContID).ID
						}
						if ($ParentDynGroupObject.Count -le 2) {
							$Filter = "(&(Name:IgnoreCase=$Name)(Schematag=DynamicGroup)(DynamicGroupProps.ParentDynGroupId=$ParentDynGroupID))"
						}
						else {
							$Filter = "(&(Name:IgnoreCase=$Name)(Schematag=DynamicGroup))"
						}
					}
					else {
						$Filter = "(&(Name:IgnoreCase=$Name)(|(Schematag=Group)(Schematag=DynamicGroup)(Schematag=ExternalGroup)))"
					}
					if ($ADSID) {
						$Filter = "(Uniqueid=$ADSID)"
					}
					$search = Get-DSM7ObjectList -Filter $Filter -ParentContID $ParentContID
					if ($search -and $search.Count -le 1) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Gruppe nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7ObjectObject -ID $ID
					if ($Object) {
						$result = Convert-DSM7ObjectListtoPSObject($Object)
						Write-Log 0 "($($Object.Name)) erfolgreich." $MyInvocation.MyCommand
						return $result
					}
					else {
						Write-Log 1 "($ID) nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7Group
function New-DSM7Group {
	<#
	.SYNOPSIS
		Erstellt ein Gruppenobjekt.
	.DESCRIPTION
		Erstellt ein Gruppenobjekt.
	.EXAMPLE
		New-DSM7Group -Name "Gruppe" -SchemaTag "DynamicGroup" -LDAPPath "Managed Users & Computers/OU1" -DynamicGroupFilter "(Name=Test)"
	.EXAMPLE
		New-DSM7Group -Name "Gruppe" -SchemaTag "ExternalGroup" -LDAPPath "Managed Users & Computers/Server managed/OU1" -ADSID "S-1-5-21-xxxx"
	.EXAMPLE
		New-DSM7Group -Name "Gruppe" -Typ "User" -LDAPPath "Managed Users & Computers/OU1" 
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[ValidateSet("Group","DynamicGroup","ExternalGroup")]
		[system.string]$SchemaTag = "Group",
		[Parameter(Position=3, Mandatory=$false)]
		[ValidateSet("Computer","User")]
		[system.string]$Typ = "Computer",
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=6, Mandatory=$false)]
		[int]$ParentDynGroupID,
		[Parameter(Position=7, Mandatory=$false)]
		[system.string]$DynamicGroupFilter,
		[Parameter(Position=7, Mandatory=$false)]
		[system.string]$ADSID

	) 
	if (Confirm-Connect) {
		try {
			$CreateGroup = $false
			if ($LDAPPath) {
				$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
			} 
			if ($ParentContID -gt 0) {
				$PropGroupList = @()
				switch ($SchemaTag) {
					"DynamicGroup" {
						if ($DynamicGroupFilter) {$CreateGroup = $true}
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "Option"
						$PropertyListObject.TypedValue = $Typ
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "Group"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "Filter"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = $DynamicGroupFilter
						$PropertyList += $PropertyListObject
						if ($ParentDynGroup -or $ParentDynGroupID) {
							if ($ParentDynGroup) {
								$search = Get-DSM7Group -Name $ParentDynGroup -LDAPPath $LDAPPath 
								if ($search.Count -lt 2) {
									$ParentDynGroupID = $search.ID
								}
								else {
									$CreateGroup = $false
									Write-Log 2 "�bergeordnete Gruppe nicht eindeutig, bitte ID benutzen!!!" $MyInvocation.MyCommand 
								}
							}
							if ($ParentDynGroupID -gt 0) {
								$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfNullableOfInt32"]
								$PropertyListObject.Tag = "ParentDynGroupId"
								$PropertyListObject.Type = "HierarchicalObjectLink"
								$PropertyListObject.TypedValue = $ParentDynGroupID
								$PropertyList += $PropertyListObject
							}
						}
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "DynamicGroupProps"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					} 
					"ExternalGroup" {
						if ($ADSID) {$CreateGroup = $true}
					} 
					"Group" {
						$CreateGroup = $true
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "Option"
						$PropertyListObject.TypedValue = $Typ
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "Group"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					} 
					default {}
				}
				if ($CreateGroup) {
					$Object = New-DSM7Object -Name $Name -ParentContID $ParentContID -PropGroupList $PropGroupList -SchemaTag $SchemaTag -UniqueID $ADSID
					if ($Object) {
						Write-Log 0 "Gruppe ($Name) wurde erstellt." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Gruppe konnte nicht erstellt werden!!!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "Gruppen kann nicht erstellt werden!!!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "LDAPPath nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function New-DSM7Group
function Update-DSM7Group {
	<#
	.SYNOPSIS
		�ndert ein Gruppenobjekt.
	.DESCRIPTION
		�ndert ein Gruppenobjekt.
	.EXAMPLE
		Update-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1" -DynamicGroupFilter "(Name=Test)"
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=5, Mandatory=$false)]
		[int]$ParentDynGroupID,
		[Parameter(Position=6, Mandatory=$false)]
		[system.string]$DynamicGroupFilter,
		[Parameter(Position=7, Mandatory=$false)]
		[system.string]$ADSID,
		[Parameter(Position=8, Mandatory=$false)]
		[system.string]$NewName

	) 
	if (Confirm-Connect) {
		try {
			$Values = @()
			if ($Name -or $ID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					$Group = Get-DSM7Group -Name $Name -ParentContID $ParentContID -ParentDynGroup $ParentDynGroup
					if ($Group) {
						$ID = $Group.ID
					} 
				}
				$Group = Get-DSM7ObjectObject -ID $ID
				if ($Group) {
					switch ($Group.SchemaTag) {
						"DynamicGroup" {
							if ($DynamicGroupFilter) {
								$Values += "DynamicGroupProps.Filter="+$DynamicGroupFilter
							} 
						} 
						"ExternalGroup" {
							if ($ADSID) {
								$Group.UniqueID = $ADSID
							}
						} 
						"Group" {
						} 
						default {}
					}
					if ($Description) {
						$Group.Description = $Description
					}
					if ($NewName) {
						$Group.Name = $NewName
					}
					$Object = Update-DSM7Object -Object $Group -Values $Values
					if ($Object) {
						Write-Log 0 "Gruppe ($($Object.Name)) wurde ge�ndert." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Gruppe konnte nicht ge�ndert werden!!!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "LDAPPath nicht angegeben!!!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Update-DSM7Group
function Move-DSM7Group {
	<#
	.SYNOPSIS
		Verschiebt ein Gruppenobjekt.
	.DESCRIPTION
		Verschiebt ein Gruppenobjekt.
	.EXAMPLE
		Move-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1" -toLDAPPath "Managed Users & Computers/OU2"
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=2, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$toLDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$toParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=5, Mandatory=$false)]
		[int]$ParentDynGroupID
	) 
	if (Confirm-Connect) {
		try {
			$Values = @()
			if ($Name -or $ID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($toLDAPPath) {
					$toParentContID = Get-DSM7LDAPPathID -LDAPPath $toLDAPPath
				} 
				if ($ParentDynGroup) {
					$ParentDynGroupID = Get-DSM7Group -Name $ParentDynGroup
				} 

				if ($ID -eq 0) {
					$Group = Get-DSM7Group -Name $Name -ParentContID $ParentContID -ParentDynGroup $ParentDynGroup -ParentDynGroupID $ParentDynGroupID 
					if ($Group) {
						$ID = $Group.ID
					} 
				}
				$Group = Get-DSM7ObjectObject -ID $ID
				if ($Group) {
					if ($Group.ParentContID -ne $toParentContID) {
						$result = Move-DSM7Object -Object $Group -ParentContID $toParentContID
						if ($ParentDynGroupID) {
							$result = Update-DSM7Group -ID $Group.ID -ParentDynGroupID $ParentDynGroupID
						}
						if ($result) {
							Write-Log 0 "Gruppe verschoben nach $toParentContID." $MyInvocation.MyCommand 
							return $true
						}
						else {
							Write-Log 1 "Gruppe nicht verschoben, ein Fehler aufgetreten!" $MyInvocation.MyCommand 
							return $false
						}
					}
					else {
						Write-Log 1 "Gruppe nicht verschoben, befindet sich schon an dieser Stelle." $MyInvocation.MyCommand 

					}
				}
			} 
			else {
				Write-Log 1 "Name oder ID fehlt!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Move-DSM7Group
function Remove-DSM7Group {
	<#
	.SYNOPSIS
		L�scht ein Gruppenobjekt.
	.DESCRIPTION
		L�scht ein Gruppenobjekt.
	.EXAMPLE
		Remove-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Remove-DSM7Group -Name "Gruppe" -ParentDynGroup "Gruppe"
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Add-DSM7ComputerToGroup
	.LINK
		Remove-DSM7ComputerFromGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ParentDynGroupID,
		[Parameter(Position=6, Mandatory=$false)]
		[system.string]$ADSID
	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0 -or $ADSID) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					if ($ParentDynGroup) {
						if ($ParentDynGroup) {
							$ParentDynGroupID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$ParentDynGroup)(Schematag=DynamicGroup))" -ParentContID $ParentContID).ID
						}
						if ($ParentDynGroupObject.Count -le 2) {
							$Filter = "(&(Name:IgnoreCase=$Name)(Schematag=DynamicGroup)(DynamicGroupProps.ParentDynGroupId=$ParentDynGroupID))"
						}
						else {
							$Filter = "(&(Name:IgnoreCase=$Name)(Schematag=DynamicGroup))"
						}
					}
					else {
						$Filter = "(&(Name:IgnoreCase=$Name)(|(Schematag=Group)(Schematag=DynamicGroup)(Schematag=ExternalGroup)))"
					}
					if ($ADSID) {
						$Filter = "(Uniqueid=$ADSID)"
					}
					$search = Get-DSM7ObjectList -Filter $Filter -ParentContID $ParentContID
					if ($search -and $search.Count -le 1) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Gruppe nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7ObjectObject -ID $ID
					if ($Object) {
						$result = Remove-DSM7Object -Object $Object
						Write-Log 0 "($($Object.Name)) erfolgreich gel�scht." $MyInvocation.MyCommand
						return $result
					}
					else {
						Write-Log 1 "($ID) nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Remove-DSM7Group
###############################################################################
# DSM7 Funktionen - Members of Groups
function Get-DSM7ComputerGroupMembers {
	<#
	.SYNOPSIS
		Ermittelt Mitglieder einer Computergruppe.
	.DESCRIPTION
		Ermittelt Mitglieder einer Computergruppe.
	.EXAMPLE
		Get-DSM7ComputerGroupMembers -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		veraltet
	.LINK
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				$Group = Get-DSM7Group -Name $Name -LDAPPath $LDAPPath
				$ID = $Group.ID
			} 
			if ($ID) {
				if ($DSM7Version -gt "7.2.2") {
					$result = Get-DSM7GroupMembers -ID $ID
					Write-Log 1 "Bitte Funktion Get-DSM7ComputerGroupMembers nicht mehr benutzen, wird ersetzt durch die Funktion Get-DSM7GroupMembers. Achtung - Objekt des Ergebnis hat andere Eigenschaften!!!" $MyInvocation.MyCommand
				}
				else {
					$result = Get-DSM7AssociationList -SchemaTag "GroupMembers" -SourceObjectID $ID -resolvedName
				}
				if ($result) {
					Write-Log 0 "($($Group.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					Write-Log 1 "($($Group.Name)) ($LDAPPath) hat kein Mitglieder!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "($Name$ID) ($LDAPPath) nicht gefunden!" $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ComputerGroupMembers
function Get-DSM7ComputerInGroups {
	<#
	.SYNOPSIS
		Ermittelt die Computergruppen eines Computers.
	.DESCRIPTION
		Ermittelt die Computergruppen eines Computers.
	.EXAMPLE
		Get-DSM7ComputerInGroups -Name "Computer" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		veraltet
	.LINK
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				$Object = Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath
			}
			else {
				$Object = Get-DSM7Computer -ID $ID
			}
			if ($Object) {
				if ($DSM7Version -gt "7.2.2") {
					$result = Get-DSM7ListOfMemberships -ID $Object.ID -MembershipTypes "All"
					Write-Log 1 "Bitte Funktion Get-DSM7ComputerInGroups nicht mehr benutzen, wird ersetzt durch die Funktion Get-DSM7ListOfMemberships.  Achtung - Objekt des Ergebnis hat andere Eigenschaften!!!" $MyInvocation.MyCommand
				}
				else {
					$result = Get-DSM7AssociationList -SchemaTag "GroupMembers" -TargetObjectID $Object.ID -resolvedName
				}
			}
			if ($result) {
				Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
				return $result
			}
			else {
				Write-Log 1 "($($Object.Name) ($LDAPPath) ist in keiner Gruppe!." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "($Name$ID) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ComputerInGroups
function Get-DSM7ComputerInGroup {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$true)]
		[system.string]$GroupName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$GroupLDAPPath
	)
	if (Confirm-Connect) {

		$Computer = Get-DSM7Computer -Name $Name
		$Group = Get-DSM7Group -Name $GroupName -LDAPPath $GroupLDAPPath

		if ($Computer -and $Group) {
			$result = Get-DSM7AssociationListObject -SchemaTag "GroupMembers" -SourceObjectID $Group.ID -TargetObjectID $Computer.ID -TargetSchemaTag $Computer.SchemaTag
			if ($result) {
				$result = Get-DSM7AssociationObject -ID $result.ID -SchemaTag $result.SchemaTag
				Write-Log 0 "($Name) - ($GroupName) - ($GroupLDAPPath) erfolgreich." $MyInvocation.MyCommand
				return $result
			}
			else {
				Write-Log 1 "($Name) ($LDAPPath) ist nicht Mitglied in $GroupName!" $MyInvocation.MyCommand

				return $false
			}
		}
		else {
			Write-Log 1 "($Name) - ($GroupName) - ($GroupLDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
			return $false
		}
	}
}
function Get-DSM7ExternalGroupMembers {
	<#
	.SYNOPSIS
		Ermittelt Mitglieder einer Externalgruppe.
	.DESCRIPTION
		Ermittelt Mitglieder einer Externalgruppe.
	.EXAMPLE
		Get-DSM7ExternalGroupMembers -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		veraltet
	.LINK
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[ValidateSet("User", "Computer")]
		[system.string]$TargetSchemaTag
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				$Group = Get-DSM7Group -Name $Name -LDAPPath $LDAPPath
				$ID = $Group.ID
			} 
			if ($ID) {
				if ($DSM7Version -gt "7.2.2") {
					$result = Get-DSM7GroupMembers -ID $ID 
					Write-Log 1 "Bitte Funktion Get-DSM7ExternalGroupMembers nicht mehr benutzen, wird ersetzt durch die Funktion Get-DSM7GroupMembers.  Achtung - Objekt des Ergebnis hat andere Eigenschaften!!!" $MyInvocation.MyCommand
				}
				else {
					$result = Get-DSM7AssociationList -SchemaTag "ExternalGroupMembers" -SourceObjectID $ID -TargetSchemaTag $TargetSchemaTag -resolvedName
				}
				if ($result) {
					Write-Log 0 "($($Group.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					return $false
				}
			}
			else {
				Write-Log 1 "($Name$ID) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ExternalGroupMembers
function Get-DSM7GroupMembersObject {
	[CmdletBinding()] 
	param (
		$Group,
		$Filter = "",
		$Properties = "Name"

	)
	try {
		if ($DSM7Version -gt "7.3.3") {
			$Webrequest = Get-DSM7RequestHeader -action "GetGroupMembers"
			$Webrequest.GroupId = $Group.ID
			$Webrequest.FilterCriteria = $Filter
			$Webrequest.PropertiesToRetrieve = $Properties
			$Webresult = $DSM7WebService.GetGroupMembers($Webrequest).Members
			Write-Log 0 "$($Webresult.ID) erfolgreich erstellt." $MyInvocation.MyCommand
			return $Webresult
		}
		else {
			$Webrequest = Get-DSM7RequestHeader -action "GetGroupMembers"
			$Webrequest.Group = $Group
			$Webrequest.FilterCriteria = $Filter
			$Webrequest.PropertiesToRetrieve = $Properties
			$Webresult = $DSM7WebService.GetGroupMembers($Webrequest).Members
			Write-Log 0 "$($Webresult.ID) erfolgreich erstellt." $MyInvocation.MyCommand
			return $Webresult
		}
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7GroupMembers {
	<#
	.SYNOPSIS
		Ermittelt Mitglieder einer Gruppe.
	.DESCRIPTION
		Ermittelt Mitglieder einer Gruppe.
	.EXAMPLE
		Get-DSM7GroupMembers -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Get-DSM7GroupMembers -Name "Gruppe" -Filter "Name=Computername"
	.NOTES
		neue Funktion ab der Version 7.2.3
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$Filter
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				if ($ParentContID){
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				}
				$searchFilter = "(&(Name:IgnoreCase=$Name)(|(BasePropGroupTag=SwCategory)(BasePropGroupTag=Group)))"
				$search = Get-DSM7ObjectList -Filter $searchFilter -ParentContID $ParentContID
				if ($search.count -gt 1) {
					Write-Log 1 "Name nicht eindeutig bitte LDAP Path angeben!!!" $MyInvocation.MyCommand
				}
				else {
					$ID = $search.ID
				}
			} 
			if ($ID) {
				$Group = Get-DSM7ObjectObject -ID $ID
				if ($DSM7Version -gt "7.2.2") {
					$result = Get-DSM7GroupMembersObject -Group $Group -Filter $Filter
					if ($result) {
						$result = Convert-DSM7ObjectListtoPSObject ($result)
					}
				}
				else {
					$result = Get-DSM7AssociationList -SchemaTag "$($Group.SchemaTag)Members" -SourceObjectID $ID -resolvedName
				}
				if ($result) {
					Write-Log 0 "$($Group.Name) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					Write-Log 1 "Gruppe/Filter nicht gefunden!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "($Name$ID) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7GroupMembers
function Get-DSM7ListOfMembershipsObject {
	[CmdletBinding()] 
	param (
		$object,
		$MembershipTypes 

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetListOfMemberships"
		$Webrequest.Object = $object
		$Webrequest.MembershipTypes = $MembershipTypes
		$Webresult = $DSM7WebService.GetListOfMemberships($Webrequest).ListOfMemberships
		Write-Log 0 "$($Webresult.ID) erfolgreich erstellt." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7ListOfMemberships {
	<#
	.SYNOPSIS
		Ermittelt die Gruppen eines Objektes.
	.DESCRIPTION
		Ermittelt die Gruppen eines Objektes.
	.EXAMPLE
		Get-DSM7ListOfMemberships -Name "Objektes" -MembershipTypes "AllStaticGroups" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		neue Funktion ab der Version 7.2.3
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[ValidateSet("None","Containers","HierarchicalObjects","DynamicGroups","StaticGroups","ExternalGroups","AllStaticGroups","AllGroups","All")]
		[system.string]$MembershipTypes = "All",
		[system.string]$Schematag = "*"

	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				$Objectfind = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$Name)(Schematag=$Schematag)" -LDAPPath $LDAPPath
				if ($Objectfind.count -gt 1) {
					Write-Log 0 "Fehler bei der Ermittlung des Objekts!!!" $MyInvocation.MyCommand
					return $false
				}
				else {
					$ID = $Objectfind.id
				}
			}
			$Object = Get-DSM7ObjectObject -ID $ID
			if ($Object) {
				if ($DSM7Version -gt "7.2.2") {
					$result = Get-DSM7ListOfMembershipsObject -object $Object -MembershipTypes $MembershipTypes
					if ($result) {
						$result = Convert-DSM7ObjectListtoPSObject ($result)
					}

				}
				else {
					$result = Get-DSM7AssociationList -SchemaTag "GroupMembers" -TargetObjectID $Object.ID 
				}
				if ($result) {
					Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					retrun $false
				}
			}
			else {
				Write-Log 1 "($($Object.Name)) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Name($Name) oder ID($ID) nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ListOfMemberships
function Update-DSM7MembershipInGroupsObject {

	[CmdletBinding()] 
	param (
		$Object,
		$AddGroupobjects, 
		$RemoveGroupobjects

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ChangeMembershipInGroups"
		$Webrequest.Member = $Object
		$Webrequest.GroupsToAddMemberTo = $AddGroupobjects
		$Webrequest.GroupsToRemoveMemberFrom = $RemoveGroupobjects
		$Webresult = $DSM7WebService.ChangeMembershipInGroups($Webrequest)
		Write-Log 0 "Objektmitgliedschaften erfolgreich ge�ndert." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7MembershipInGroups {
	<#
	.SYNOPSIS
		�ndert eine oder mehrere Gruppen eines Objektes.
	.DESCRIPTION
		�ndert eine oder mehrere Gruppen eines Objektes.
	.EXAMPLE
		Update-DSM7MembershipInGroups -Name "Objektes" -AddObjectNames "Gruppe1,Gruppe2" -RemoveObjectNames "Gruppe1,Gruppe2" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		neue Funktion ab der Version 7.2.3
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		$AddGroupIDs,
		$AddGroupNames,
		$RemoveGroupIDs,
		$RemoveGroupNames
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($AddGroupIDs -or $AddGroupNames -or $RemoveGroupIDs -or $RemoveGroupNames) {
				if ($ID -le 1) {
					$Objectfind = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$Name)" -LDAPPath $LDAPPath
					if ($Objectfind.count -gt 1) {
						Write-Log 0 "Fehler bei der Ermittlung des Objekts!!!" $MyInvocation.MyCommand
						return $false
					}
					else {
						$ID = $Objectfind.id
					}
				}
				$Object = Get-DSM7ObjectObject -ID $ID
				if ($Object) {
					if ($DSM7Version -gt "7.2.2") {
						if ($AddGroupNames -and !$AddGroupIDs) {
							foreach ($AddGroupName in $AddGroupNames) {
								$filter = "$filter(Name:IgnoreCase=$AddGroupName)"
							}
							$filter = "(&(|$filter)(|(SchemaTag=Group)(SchemaTag=SwCategory)(SchemaTag=PatchMgmtRuleFilter)))"
							$AddGroupList = Get-DSM7ObjectList -Filter $filter
							if ($AddGroupList) {
								$AddGroupIDs = $AddGroupList| select -ExpandProperty ID
							}
						}
						if ($AddGroupIDs) {
							$AddGroupobjects = Get-DSM7ObjectsObject -IDs $AddGroupIDs
						}
						if ($RemoveGroupNames -and !$RemoveGroupIDs) {
							foreach ($RemoveGroupName in $RemoveGroupNames) {
								$filter = "$filter(Name:IgnoreCase=$RemoveGroupName)"
							}
							$filter = "(&(|$filter)(|(SchemaTag=Group)(SchemaTag=SwCategory)(SchemaTag=PatchMgmtRuleFilter)))"
							$RemoveGroupList = Get-DSM7ObjectList -Filter $filter
							if ($RemoveGroupList) {
								$RemoveGroupIDs = $RemoveGroupList| select -ExpandProperty ID
							}
						}
						if ($RemoveGroupIDs) {
							$RemoveGroupobjects = Get-DSM7ObjectsObject -IDs $RemoveGroupIDs
						}
						if ($RemoveGroupobjects -or $AddGroupobjects) {
							$result = Update-DSM7MembershipInGroupsObject -Object $Object -AddGroupobjects $AddGroupobjects -RemoveGroupobjects $RemoveGroupobjects
							if ($result) {
								$AddGroupNames = $AddGroupobjects| select -ExpandProperty Name
								$RemoveGroupNames = $RemoveGroupobjects| select -ExpandProperty Name
								Write-Log 0 "Objekt: $($Object.Name) - Gruppe(n) hinzugef�gt: ($AddGroupNames) und Gruppe(n) entfernt: ($RemoveGroupNames)" $MyInvocation.MyCommand
								return $true
							}
							else {
								Write-Log 1 "Objekt: $($Object.Name) - Gruppe(n) nicht hinzugefuegt!!!" $MyInvocation.MyCommand
								return $false
							}

						}
						else {
							Write-Log 1 "Objekt: $($Object.Name) - Gruppe(n) nicht gefunden!!!" $MyInvocation.MyCommand
							return $false
						}

					}
					else {
						Write-Log 1 "Diese Funktion ben�tigt 7.2.2 oder h�her!!!" $MyInvocation.MyCommand
						return $false
					}
					Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					Write-Log 1 "($($Object.Name)) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
					return $false
				}
			}
		}
		else {
			Write-Log 1 "Keine Gruppe angegeben!!!" $MyInvocation.MyCommand 
		}
		else {
			Write-Log 1 "Name($Name) oder ID($ID) nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Update-DSM7MembershipInGroups
function Update-DSM7MemberListOfGroupObject {

	[CmdletBinding()] 
	param (
		$Group,
		$AddObjectobjects, 
		$RemoveObjectobjects

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ChangeMemberListOfGroup"
		$Webrequest.Group = $Group
		$Webrequest.MembersToAdd = $AddObjectobjects
		$Webrequest.MembersToRemove = $RemoveObjectobjects
		$Webresult = $DSM7WebService.ChangeMemberListOfGroup($Webrequest)
		Write-Log 0 "Gruppenmitgliedschaften erfolgreich ge�ndert." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7MemberListOfGroup {
	<#
	.SYNOPSIS
		�ndert eine oder mehrere Objekte zu einer Gruppe.
	.DESCRIPTION
		�ndert eine oder mehrere Objekte zu einer Gruppe.
	.EXAMPLE
		Update-DSM7MembershipInGroups -Name "Gruppe" -AddObjectNames "Computername1,Computername2" -RemoveObjectNames "Computername1,Computername2" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
		neue Funktion ab der Version 7.2.3
	.LINK
		Get-DSM7Group
	.LINK
		New-DSM7Group
	.LINK
		Move-DSM7Group
	.LINK
		Update-DSM7Group
	.LINK
		Remove-DSM7Group
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		$AddObjectIDs,
		$AddObjectNames,
		$RemoveObjectIDs,
		$RemoveObjectNames
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($AddObjectIDs -or $AddObjectNames -or $RemoveObjectIDs -or $RemoveObjectNames) {
				if ($ID -le 1) {
					$Objectfind = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)(|(SchemaTag=Group)(SchemaTag=SwCategory)(SchemaTag=PatchMgmtRuleFilter)))" -LDAPPath $LDAPPath
					if ($Objectfind.count -gt 1) {
						Write-Log 0 "Fehler bei der Ermittlung des Objekts!!!" $MyInvocation.MyCommand
						return $false
					}
					else {
						$ID = $Objectfind.id
					}
				}
				$Object = Get-DSM7ObjectObject -ID $ID
				if ($Object) {
					if ($DSM7Version -gt "7.2.2") {
						if ($AddObjectNames -and !$AddObjectIDs) {
							foreach ($AddObjectName in $AddObjectNames) {
								$filter = "$filter(Name:IgnoreCase=$AddObjectName)"
							}
							$filter = "(|$filter)"
							$AddObjectList = Get-DSM7ObjectList -Filter $filter
							if ($AddObjectList) {
								$AddObjectIDs = $AddObjectList| select -ExpandProperty ID
							}
						}
						if ($AddObjectIDs) {
							$AddObjectobjects = Get-DSM7ObjectsObject -IDs $AddObjectIDs
						}
						if ($RemoveObjectNames -and !$RemoveObjectIDs) {
							foreach ($RemoveObjectName in $RemoveObjectNames) {
								$filter = "$filter(Name:IgnoreCase=$RemoveObjectName)"
							}
							$filter = "(|$filter)"
							$RemoveObjectIDs = Get-DSM7ObjectList -Filter $filter| select -ExpandProperty ID
						}
						if ($RemoveObjectIDs) {
							$RemoveObjectobjects = Get-DSM7ObjectsObject -IDs $RemoveObjectIDs
						}
						if ($RemoveObjectobjects -or $AddObjectobjects) {
							$result = Update-DSM7MemberListOfGroupObject -Group $Object -AddObjectobjects $AddObjectobjects -RemoveObjectobjects $RemoveObjectobjects
							if ($result) {
								$AddObjectNames = $AddObjectobjects| select -ExpandProperty Name
								$RemoveObjectNames = $RemoveObjectobjects| select -ExpandProperty Name
								Write-Log 0 "Gruppe: $($Object.Name) Objekt(e) hinzugef�gt: ($AddObjectNames) und Objekt(e) entfernt: ($RemoveObjectNames)" $MyInvocation.MyCommand
								return $true
							}
							else {
								Write-Log 1 "Gruppe: $($Object.Name) Objekt(e) nicht hinzugef�gt: ($AddObjectNames) und Objekt(e) ($RemoveObjectNames)!!!" $MyInvocation.MyCommand
								return $false
							}

						}
						else {
							Write-Log 1 "Gruppe: $($Object.Name) Objekt(e) nicht gefunden: ($AddObjectNames) und Objekt(e)($RemoveObjectNames)!!!" $MyInvocation.MyCommand

						}

					}
					else {
						Write-Log 1 "Diese Funktion ben�tigt 7.2.3 oder h�her!!!" $MyInvocation.MyCommand
						return $false
					}
					Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					return $result
				}
				else {
					Write-Log 1 "($($Object.Name)) ($LDAPPath) nicht erfolgreich." $MyInvocation.MyCommand
					return $false
				}
			}
		}
		else {
			Write-Log 1 "Keine Gruppe angegeben!!!" $MyInvocation.MyCommand 
		}
		else {
			Write-Log 1 "Name($Name) oder ID($ID) nicht angegeben!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Update-DSM7MemberListOfGroup



function Add-DSM7ComputerToGroup {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$GroupName,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$GroupLDAPPath
	)
	if (Confirm-Connect) {
		$Computer = Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath
		$Group = Get-DSM7Group -Name $GroupName -LDAPPath $GroupLDAPPath
		if ($Computer -and $Group) {
			if ($DSM7Version -gt "7.2.2") {
				Write-Log 1 "Bitte Funktion Add-DSM7ComputerToGroup nicht mehr benutzen, wird ersetzt durch die Funktion Update-DSM7MembershipInGroups." $MyInvocation.MyCommand
				$result = Update-DSM7MembershipInGroups -ID $Computer.ID -AddGroupIDs $Group.ID
			}
			else {
				$result = New-DSM7Association -SchemaTag "GroupMembers" -SourceObjectID $Group.ID -TargetObjectID $Computer.ID -TargetSchemaTag $Computer.SchemaTag
			}
			if ($result) {
				Write-Log 0 "($Name) zu Gruppe ($GroupName) erfolgreich hinzugef�gt." $MyInvocation.MyCommand
				$result = Convert-DSM7AssociationtoPSObject($result)
				return $result
			}
			else {
				Write-Log 1 "($Name) ist schon in Gruppe ($GroupName)!" $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "($Name) nicht zu ($GroupName) hinzugef�gt." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Add-DSM7ComputerToGroup
function Remove-DSM7ComputerFromGroup {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[int]$GroupID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$GroupName,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$GroupLDAPPath
	)
	if (Confirm-Connect) {
		$FindObject = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$Name)" -LDAPPath $LDAPPath
		$Group = Get-DSM7Group -Name $GroupName -LDAPPath $GroupLDAPPath

		if ($Group) {
			if ($DSM7Version -gt "7.2.2") {
				Write-Log 1 "Bitte Funktion Remove-DSM7ComputerFromGroup nicht mehr benutzen, wird ersetzt durch die Funktion Update-DSM7MembershipInGroups." $MyInvocation.MyCommand
				$result = Update-DSM7MembershipInGroups -ID $FindObject.ID -RemoveGroupIDs $Group.ID
			}
			else {
				$Object = Get-DSM7AssociationListObject -SchemaTag "GroupMembers" -SourceObjectID $Group.ID -TargetObjectID $FindObject.ID -TargetSchemaTag $FindObject.SchemaTag
				$result = Remove-DSM7AssociationObject -Object $Object
			}
			if ($result) {
				Write-Log 0 "($Name) zu Gruppe ($GroupName) erfolgreich entfernt." $MyInvocation.MyCommand
				return $true
			}
			else {
				Write-Log 1 "($Name) konte nicht enfernt werden aus ($GroupName)!" $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "($Name) oder ($GroupName) nicht bekannt." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Remove-DSM7ComputerFromGroup
###############################################################################
# DSM7 Funktionen - Policy
function Get-DSM7Policy {
	<#
	.SYNOPSIS
		List ein Policy Object aus.
	.DESCRIPTION
		List ein Policy Object aus.
	.EXAMPLE
		Get-DSM7Policy -ID 123456 -resolvedName
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[int]$ID,
		[switch]$resolvedName = $false

	)
	if (Confirm-Connect) {
		$result = Convert-DSM7PolicytoPSObject(Get-DSM7PolicyObject -ID $ID) -resolvedName:$resolvedName
		if ($result) {
			Write-Log 0 "($ID) erfolgreich." $MyInvocation.MyCommand
		}
		else {
			Write-Log 2 "keine Policy gefunden mit ID($ID)!" $MyInvocation.MyCommand
		}
		return $result
	}
}
Export-ModuleMember -Function Get-DSM7Policy
function Get-DSM7PolicyObject {
	[CmdletBinding()] 
	param (
		[int]$ID
	)
	if (Confirm-Connect) {
		try {
			$Webrequest = Get-DSM7RequestHeader -action "GetPolicy"
			$Webrequest.PolicyId = $ID
			$Webresult = $DSM7WebService.GetPolicy($Webrequest).RetrievedPolicy
			return $Webresult
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Update-DSM7PolicyObject {
	[CmdletBinding()] 
	param (
		$Policy,
		$InstallationParametersOfSwSetComponents
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdatePolicy"
		if ($DSM7Version -gt "7.3.0") {
			$Webrequest.PolicyToUpdate = New-Object $DSM7Types["PolicyToManage"]
			$Webrequest.PolicyToUpdate.Policy = $Policy
			$Webrequest.PolicyToUpdate.InstallationParametersOfSwSetComponents = $InstallationParametersOfSwSetComponents
		}
		else {
			$Webrequest.PolicyToUpdate = $Policy
			$Webrequest.InstallationParametersOfSwSetComponents = $InstallationParametersOfSwSetComponents
		}
		$Webresult = $DSM7WebService.UpdatePolicy($Webrequest).UpdatedPolicy
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7Policy {
	<#
	.SYNOPSIS
		�ndert ein Policy Object aus.
	.DESCRIPTION
		�ndert ein Policy Object aus.
	.EXAMPLE
		Update-DSM7Policy -ID xxx -PolicyRestrictionList (yyy,zzz) -PolicyRestrictionType Include -IsActiv
	.EXAMPLE
		Update-DSM7Policy -SwUniqueID "{A42DB21A-D859-4789-BD1C-FC5B5C61EA27}" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
	.EXAMPLE
		Update-DSM7Policy -SwName "Software" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$SwName,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$SwUniqueID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position=6, Mandatory=$false)]
		[switch]$IsActiv = $false,
		[Parameter(Position=7, Mandatory=$false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position=8, Mandatory=$false)]
		[system.string]$Parameter,
		[ValidateSet("Include","Exclude","None")]
		[Parameter(Position=9, Mandatory=$false)]
		[system.string]$PolicyRestrictionType,
		[Parameter(Position=10, Mandatory=$false)]
		[system.array]$PolicyRestrictionList
	)
	if (Confirm-Connect) {
		try {
			if (!$ID) {
				$NoPolicy = $false
				if ($SwName) {
					$AssignedObject = Get-DSM7Software -Name $SwName -LDAPPath $SwLDAPPath
				}
				if ($SwUniqueID) {
					$AssignedObject = Get-DSM7Software -UniqueID $SwUniqueID -LDAPPath $SwLDAPPath
				}
				$TargetObject = Get-DSM7ObjectObject -ID (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
				if ($TargetObject -and $AssignedObject) {
					Write-Log 0 "($($AssignedObject.Name)) und ($TargetName) gefunden." $MyInvocation.MyCommand
					$Policys = Convert-DSM7PolicyListtoPSObject(Get-DSM7PolicyListByAssignedSoftwareObject -ID $AssignedObject.ID)|Select-Object ID -ExpandProperty TargetObjectList|where {$_.TargetObjectID -eq $TargetObject.ID}
					if ($Policys.count -gt 1) {
						Write-Log 1 "Mehere Policys($($Policys.count)) gefunden!!! Bitte ID benutzen." $MyInvocation.MyCommand
					}
					else{ 
						$ID = $Policys.ID
					}
				} 
			}
			if ($ID) {
				$Policy = Get-DSM7PolicyObject -ID $ID
				if (!$AssignedObject) {
					$AssignedObject = Get-DSM7Software -ID $policy.AssignedObjectID
				}
				if ($Policy) {
					if ($Policy.IsActive -and $ActivationStartDate) {
						$Policy.IsActive = $false
						$Policy = Update-DSM7PolicyObject -Policy $Policy -InstallationParametersOfSwSetComponents $Policy.SwInstallationParameters
					}
					if ($ActivationStartDate) {
						Write-Log 0 "Start Datum ist:($ActivationStartDate)" $MyInvocation.MyCommand
						if ($ActivationStartDate) {
							$StartDate = $(Get-Date($ActivationStartDate)) 

						}
						else {
							$StartDate = $(Get-Date) 
						}
						$StartDate = $StartDate + [System.TimeZoneInfo]::Local.BaseUtcOffset
						if ([System.TimeZoneInfo]::Local.IsDaylightSavingTime($StartDate)) {
							$StartDate = $StartDate + 36000000000
						}
						$Policy.ActivationStartDate = $StartDate
					}
					$Policy.IsActive = $IsActiv
					if (($PolicyRestrictionList -and $PolicyRestrictionType) -or $PolicyRestrictionType -eq "None") {
						switch ($PolicyRestrictionType) {
							"None" {
								$Policy.PolicyRestrictionList = @()
								$Policy.PolicyRestrictionType = 0
							}
							"Include" {
								$Policy.PolicyRestrictionList = $PolicyRestrictionList
								$Policy.PolicyRestrictionType = 1
							}
							"Exclude" {
								$Policy.PolicyRestrictionList = $PolicyRestrictionList
								$Policy.PolicyRestrictionType = 2
							}
						}
					}

					$Policy = Update-DSM7PolicyObject -Policy $Policy -InstallationParametersOfSwSetComponents $Policy.SwInstallationParameters
					if ($Policy) {
						Write-Log 0 "$($AssignedObject.Name) auf ($($TargetObject.Name)) erfolgreich ge�ndert." $MyInvocation.MyCommand
						return $true
					}
					else {
						return $false
					}
				} 
			}
			else {
				Write-Log 1 "($SwName$SwUniqueID) und/oder ($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Update-DSM7Policy

function Add-DSM7TargetToPolicyObject {
	[CmdletBinding()] 
	param (
		$Policy,
		$PolicyTarget
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "AddTargetToPolicy"
		$Webrequest.Policy = $Policy
		$Webrequest.TargetToAdd = $PolicyTarget
		$Webresult = $DSM7WebService.AddTargetToPolicy($Webrequest).UpdatedPolicy
		Write-Log 0 "$($PolicyTarget.ID) erfolgreich hinzugef�gt." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Remove-DSM7TargetFromPolicyObject {
	[CmdletBinding()] 
	param (
		$Policy,
		$PolicyTarget,
		[switch]$ForceRemove = $false
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "RemoveTargetFromPolicy"
		$Webrequest.Policy = $Policy
		$Webrequest.TargetToRemove = $PolicyTarget
		$Webrequest.ForceRemove = $ForceRemove
		$Webresult = $DSM7WebService.RemoveTargetFromPolicy($Webrequest).UpdatedPolicy
		Write-Log 0 "$($PolicyTarget.ID) erfolgreich entfernt." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Get-DSM7PolicyList {
	<#
	.SYNOPSIS
		Listet Policy(s) Object auf.
	.DESCRIPTION
		Listet Policy(s) Object auf.
	.EXAMPLE
		Get-DSM7PolicyList -Filter "(AssignedObjectId=1234)" -Attributes "AssignedObjectId"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Attributes,
		[system.string]$Filter,
		[switch]$recursive = $false
	)
	if (Confirm-Connect) {
		try {
			$Webrequest = Get-DSM7RequestHeader -action "GetPolicyList"
			$Webrequest.LdapQuery = "<LDAP://rootDSE>;$Filter;$Attributes;subtree" 
			$Webrequest.MaxResults = -1 
			$Webresult = $($DSM7WebService.GetPolicyList($Webrequest)).PolicyList
			if ($Webresult.count -gt 0) {
				$Webresult = Convert-DSM7PolicyListtoPSObject($Webresult) 
				Write-Log 0 "($Filter) erfolgreich." $MyInvocation.MyCommand
				return $Webresult
			}
			else {
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7PolicyList


function Move-DSM7PolicyToTarget {
	<#
	.SYNOPSIS
		�ndert ein Policy Object aus.
	.DESCRIPTION
		�ndert ein Policy Object aus.
	.EXAMPLE
		Move-DSM7PolicyToTarget -ID xxx -TargetName "Ziel"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[switch]$ForceRemove = $false

	)
	if (Confirm-Connect) {
		try {
			if ($TargetID -eq 0) {
				$TargetID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
			}
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			} 
			if ($TargetObject) {
				Write-Log 0 "($($AssignedObject.Name)) und ($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
				$Policy = Get-DSM7PolicyObject -ID $ID
				$result = Add-DSM7TargetToPolicyObject -Policy $Policy -PolicyTarget $TargetObject 
				$Policy = Get-DSM7PolicyObject -ID $ID
				if ($Policy.TargetObjectList.Count -le 1 -and $Policy.TargetObjectList[0].TargetObjectID -ne $TargetObject.ID) {
					$result = Remove-DSM7PolicyObject -Policy $Policy -ForceDelete
				}
				else {
					foreach ($Target in $Policy.TargetObjectList) {
						$RemoveObject = Get-DSM7ObjectObject -ID $Target.TargetObjectID
						if ($RemoveObject.ID -ne $TargetObject.ID ) {
							$RemovePolicy = Get-DSM7PolicyObject -ID $ID
							$result = Remove-DSM7TargetFromPolicyObject -Policy $RemovePolicy -PolicyTarget $RemoveObject -ForceRemove:$ForceRemove
						}
					}
				}
				if ($result){
					Write-Log 0 "Policy erfolgreich nach ($TargetName) verschoben." $MyInvocation.MyCommand
					return $true
				}
				else {
					Write-Log 1 "Alte Ziele nicht entfernt." $MyInvocation.MyCommand
					return $false 
				}
			}
			else {
				Write-Log 1 "($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Move-DSM7PolicyToTarget
function Remove-DSM7PolicyFromTarget {
	<#
	.SYNOPSIS
		�ndert ein Policy Object aus.
	.DESCRIPTION
		�ndert ein Policy Object aus.
	.EXAMPLE
		Remove-DSM7PolicyFromTarget -ID xxx -TargetName "Ziel"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Remove-DSM7PolicyFromTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[switch]$ForceRemove = $false

	)
	if (Confirm-Connect) {
		try {
			if ($TargetID -eq 0) {
				$TargetID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
			}
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			} 
			if ($TargetObject) {
				Write-Log 0 "($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
				$Policy = Get-DSM7PolicyObject -ID $ID
				if ($Policy.TargetObjectList.Count -le 1 -and $Policy.TargetObjectList[0].TargetObjectID -ne $TargetObject.ID) {
					$result = Remove-DSM7PolicyObject -Policy $Policy -ForceDelete
				}
				else {
					$RemoveObject = Get-DSM7ObjectObject -ID $Target.TargetObjectID
					$RemovePolicy = Get-DSM7PolicyObject -ID $ID
					$result = Remove-DSM7TargetFromPolicyObject -Policy $RemovePolicy -PolicyTarget $RemoveObject -ForceRemove:$ForceRemove

				}
				if ($result){
					Write-Log 0 "Policy erfolgreich von ($($TargetObject.Name)) entfernt." $MyInvocation.MyCommand
					return $true
				}
				else {
					Write-Log 1 "Alte Ziele nicht entfernt." $MyInvocation.MyCommand
					return $false 
				}
			}
			else {
				Write-Log 1 "($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7PolicyFromTarget
function Add-DSM7PolicyToTarget {
	<#
	.SYNOPSIS
		F�gt eine Policy einem Object zu.
	.DESCRIPTION
		F�gt eine Policy einem Object zu.
	.EXAMPLE
		Add-DSM7PolicyToTarget -ID 1234 -TargetName "Ziel" -TargetLDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Add-DSM7PolicyToTarget -ID 1234 -TargetID 1234
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[int]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$TargetLDAPPath

	)
	if (Confirm-Connect) {
		try {
			if ($TargetID -eq 0) {
				$TargetID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
			}
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			} 
			if ($TargetObject) {
				$Policy = Get-DSM7PolicyObject -ID $ID
				Write-Log 0 "($ID) und ($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
				$result = Add-DSM7TargetToPolicyObject -Policy $Policy -PolicyTarget $TargetObject 
				if ($result){
					Write-Log 0 "Policy Ziel ($TargetName) hinzugef�gt." $MyInvocation.MyCommand
					return $true
				}
				else {
					Write-Log 1 "Fehler!!!" $MyInvocation.MyCommand
					return $false 
				}
			}
			else {
				Write-Log 1 "($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Add-DSM7PolicyToTarget

function New-DSM7Policy {
	<#
	.SYNOPSIS
		Erstellt eine neue Policy.
	.DESCRIPTION
		Erstellt eine neue Policy.
	.EXAMPLE
		New-DSM7Policy -SwName "Microsoft Windows Update Agent (x64)" -TargetName "Ziel" -IsActiv
	.EXAMPLE

	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$SwName,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$SwUniqueID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position=6, Mandatory=$false)]
		[switch]$IsActiv = $false,
		[Parameter(Position=7, Mandatory=$false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position=8, Mandatory=$false)]
		[switch]$IsUserPolicyCurrentComputer = $false,
		[Parameter(Position=9, Mandatory=$false)]
		[switch]$IsUserPolicyAllassociatedComputer = $false,
		[Parameter(Position=10, Mandatory=$false)]
		[switch]$JobPolicy = $false

	)
	if (Confirm-Connect) {
		try {
			$NoPolicy = $false
			if ($SwName) {
				$AssignedObject = Get-DSM7Software -Name $SwName -LDAPPath $SwLDAPPath
			}
			if ($SwUniqueID) {
				$AssignedObject = Get-DSM7Software -UniqueID $SwUniqueID -LDAPPath $SwLDAPPath
			}
			if ($TargetID -eq 0) {
				$Target = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath)
			}
			if ($Target) {
				if ($Target.BasePropGroupTag -eq "OrgTreeContainer") {
					$TargetObject = Get-DSM7OrgTreeContainer -ID $Target.ID 
				}
				else {
					$TargetID = $Target.ID 
				}
			}
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			} 
			if ($ActivationStartDate) {
				$StartDate = $(Get-Date($ActivationStartDate)) 

			}
			else {
				$StartDate = $(Get-Date) 
			}
			$StartDate = $StartDate + [System.TimeZoneInfo]::Local.BaseUtcOffset
			if ([System.TimeZoneInfo]::Local.IsDaylightSavingTime($StartDate)) {
				$StartDate = $StartDate + 36000000000
			}
			if ($AssignedObject -and $TargetObject) {
				switch ($AssignedObject.Schematag) {
					"MSWUV6Package" {$SchemaTag = "PatchPolicy"}
					"LPRPatchPackage" {$SchemaTag = "PatchPolicy"}
					"PnpPackage" {$SchemaTag = "PnpPolicy"}
					default {$SchemaTag = "SwPolicy"}
				}
				switch ($AssignedObject."Software.ReleaseStatus") {
					0 {$StagingMode = "InstallationTest"}
					1 {$StagingMode = "Standard"}
					2 {$NoPolicy = $true}
					default {$StagingMode = "Standard"}
				}
				if ($JobPolicy) {
					{						$SchemaTag = "JobPolicy"}
				}
				if ($NoPolicy) {
					Write-Log 1 "Es kann keine Policy erstellt werden Paket ist zurueckgezogen!!!" $MyInvocation.MyCommand
				}
				else {
					Write-Log 0 "($($AssignedObject.Name)) und ($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
					$Policy = New-Object $DSM7Types["MdsPolicy"]
					$Policy.SchemaTag = $SchemaTag
					$Policy.AssignedObjectID = $AssignedObject.ID
					$Policy.Name = ""
					$Policy.Description = ""
					$Policy.IsActive = $IsActiv
					if ($DSM7Version -gt "7.3.2") {
						$Policy.TargetSelectionMode = 0
						if ($IsUserPolicyCurrentComputer -or $IsUserPolicy) {
							$Policy.TargetSelectionMode = 1
						}
						if ($IsUserPolicyAllassociatedComputer) {
							$Policy.TargetSelectionMode = 2
						}
					}
					else {
						$Policy.IsUserPolicy = $IsUserPolicy
					}
					$Policy.ActivationStartDate = $StartDate
					$PolicyTarget = New-Object $DSM7Types["MdsPolicyTarget"]
					$PolicyTarget.TargetObjectID = $TargetObject.ID
					$PolicyTarget.TargetSchemaTag = $TargetObject.SchemaTag

					$result = New-DSM7PolicyObject -NewPolicy $Policy -PolicyTarget $PolicyTarget
					$result = Convert-DSM7PolicytoPSObject ($result) -resolvedName
					if ($result) {
						Write-Log 0 "Neue Policy ($($result.ID)) mit Ziel ($($TargetObject.Name)) erstellt." $MyInvocation.MyCommand
					}
					else {
						Write-Log 1 "Keine neue Policy ($($result.ID)) mit Ziel ($($TargetObject.Name)) erstellt!!!" $MyInvocation.MyCommand
					}
					return $result
				}
			}
			else {
				Write-Log 1 "($SwName$SwUniqueID) und/oder ($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function New-DSM7Policy

function Copy-DSM7Policy {
	<#
	.SYNOPSIS
		�ndert ein Policy Object aus.
	.DESCRIPTION
		�ndert ein Policy Object aus.
	.EXAMPLE
		Copy-DSM7Policy -ID 1234 -TargetID 1234
	.EXAMPLE
		Copy-DSM7Policy -ID 1234 -TargetName "Name" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$true)]
		[system.Int32]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position=4, Mandatory=$false)]
		[system.array]$SwSetComponentPolicyIDs,
		[Parameter(Position=4, Mandatory=$false)]
		[switch]$IsActiv = $false,
		[Parameter(Position=5, Mandatory=$false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position=6, Mandatory=$false)]
		[switch]$IsUserPolicyCurrentComputer = $false,
		[Parameter(Position=7, Mandatory=$false)]
		[switch]$IsUserPolicyAllassociatedComputer = $false,
		[Parameter(Position=8, Mandatory=$false)]
		[switch]$JobPolicy = $false

	)
	if (Confirm-Connect) {
		try {
			$NoPolicy = $false
			if ($TargetID -eq 0) {
				$Targetid = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
			} 
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			}
			if ($ActivationStartDate) {
				$StartDate = $(Get-Date($ActivationStartDate)) 

			}
			else {
				$StartDate = $(Get-Date) 
			}
			$StartDate = $StartDate + [System.TimeZoneInfo]::Local.BaseUtcOffset
			if ([System.TimeZoneInfo]::Local.IsDaylightSavingTime($StartDate)) {
				$StartDate = $StartDate + 36000000000
			}
			if ($TargetObject) {
				if ($SwSetComponentPolicyIDs) {
				$SwInstallationParameters=@{}
				$i=0
				foreach ($SwSetComponentPolicyID in $SwSetComponentPolicyIDs) {
					$SwSetComponentPolicy = Get-DSM7PolicyObject -ID $SwSetComponentPolicyID	
					$SwInstallationParameters[$($SwSetComponentPolicy.AssignedObjectID)]=$SwSetComponentPolicy.SwInstallationParameters
					
				}
					
				}
				$Policy = Get-DSM7PolicyObject -ID $ID
				$Policy.IsActive = $IsActiv
				if ($DSM7Version -gt "7.3.2") {
					$Policy.TargetSelectionMode = 0
					if ($IsUserPolicyCurrentComputer) {
						$Policy.TargetSelectionMode = 1
					}
					if ($IsUserPolicyAllassociatedComputer) {
						$Policy.TargetSelectionMode = 2
					}
				}
				else {
					$Policy.IsUserPolicy = $IsUserPolicy
				}
				$Policy.ActivationStartDate = $StartDate
				$PolicyTarget = New-Object $DSM7Types["MdsPolicyTarget"]
				$PolicyTarget.TargetObjectID = $TargetObject.ID
				$PolicyTarget.TargetSchemaTag = $TargetObject.SchemaTag

				$result = New-DSM7PolicyObject -NewPolicy $Policy -PolicyTarget $PolicyTarget -InstallationParametersOfSwSetComponents $SwInstallationParameters
				if ($result) {
					$result = Convert-DSM7PolicytoPSObject ($result)
					Write-Log 0 "Neue Policy ($($result.ID)) mit Ziel ($($TargetObject.Name)) erstellt." $MyInvocation.MyCommand

					return $result
				}
				else {
					Write-Log 1 "Keine neue Policy erstellt!!!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "Kein Ziel gefunden!!!" $MyInvocation.MyCommand

			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Copy-DSM7Policy


function New-DSM7PolicyObject {
	[CmdletBinding()] 
	param (
		$NewPolicy,
		$PolicyTarget,
		$InstallationParametersOfSwSetComponents
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreatePolicy"
		if ($DSM7Version -gt "7.3.0") {
			$Webrequest.PolicyToCreate = New-Object $DSM7Types["PolicyToManage"]
			$Webrequest.PolicyToCreate.Policy = $NewPolicy
			$Webrequest.PolicyToCreate.Policy.TargetObjectList = $PolicyTarget
			if ($InstallationParametersOfSwSetComponents) {
			$i=0
				foreach ($key in $InstallationParametersOfSwSetComponents.Keys) {
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents+= New-Object $DSM7Types["SwSetComponentInstallationParameters"]
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents[$i].SwInstallationParameters = $InstallationParametersOfSwSetComponents[$key]
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents[$i].SwSetComponentObjectId = $key
					$i++
				}				 
			}			
			if ($DSM7Version -gt "7.4.0") {
				$Webrequest.PolicyToCreate.Policy.GenTypeData = new-object $DSM7Types["MdsGenType"]
				$CreationSource = $MyInvocation.MyCommand.Module.Name
				if ($DSM7CreationSource) {$CreationSource = $DSM7CreationSource}
				$Webrequest.PolicyToCreate.Policy.GenTypeData.CreationSource = $CreationSource
			}
		}
		else {
			$Webrequest.NewPolicy = $NewPolicy
			$Webrequest.NewPolicy.TargetObjectList = $PolicyTarget
			$Webrequest.InstallationParametersOfSwSetComponents = $InstallationParametersOfSwSetComponents
		}
		$Webresult = $DSM7WebService.CreatePolicy($Webrequest).CreatedPolicy
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Remove-DSM7PolicyObject {
	[CmdletBinding()] 
	param (
		$Policy,
		[switch]$ForceDelete = $false,
		[switch]$DeleteAssociatedPolicies = $true
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeletePolicy"
		$Webrequest.PolicyToDelete = $Policy
		if ($DSM7Version -gt "7.3.0") {
			$Webrequest.Options = New-Object $DSM7Types["DeletePolicyOptions"]
			$Webrequest.Options.ForceDelete = $ForceDelete
		}
		else {
			$Webrequest.ForceDelete = $ForceDelete
			$Webrequest.DeleteAssociatedPolicies = $DeleteAssociatedPolicies
		}
		$Webresult = $DSM7WebService.DeletePolicy($Webrequest).DeletePolicyResult
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Remove-DSM7Policy {
	<#
	.SYNOPSIS
		L�scht die Policy.
	.DESCRIPTION
		L�scht die Policy.
	.EXAMPLE
		Remove-DSM7Policy -ID 12345
	.EXAMPLE
		Remove-DSM7Policy -SwName "TestSoftware" -TargetName "Computername" -ForceDelete -DeleteAssociatedPolicies
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$ID,
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$SwName,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$SwUniqueID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.int32]$TargetID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$TargetName,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$TargetLDAPPath,
		[switch]$ForceDelete = $false,
		[switch]$DeleteAssociatedPolicies = $true

	)
	if (Confirm-Connect) {
		try {
			$NoPolicy = $false
			if ($SwName) {
				$AssignedObject = Get-DSM7Software -Name $SwName -LDAPPath $SwLDAPPath
			}
			if ($SwUniqueID) {
				$AssignedObject = Get-DSM7Software -UniqueID $SwUniqueID -LDAPPath $SwLDAPPath
			}
			if ($TargetID -eq 0) {
				$TargetID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$TargetName)$DSM7Targets)" -LDAPPath $TargetLDAPPath).ID
			}
			if ($TargetID -gt 0) {
				$TargetObject = Get-DSM7ObjectObject -ID $TargetID
			} 
			if (($TargetObject -and $AssignedObject) -or $ID) {
				if (!$ID) {
					$Policys = Convert-DSM7PolicyListtoPSObject(Get-DSM7PolicyListByAssignedSoftwareObject -ID $AssignedObject.ID)|Select-Object ID -ExpandProperty TargetObjectList|where {$_.TargetObjectID -eq $TargetObject.ID}
					if ($Policys.count -gt 1) {
						Write-Log 1 "Mehere Policys($($Policys.count)) gefunden!!! Bitte ID benutzen." $MyInvocation.MyCommand
					}
					else{ 
						$ID = $Policys.ID
					}
				}
				if ($ID) {
					$result = Get-DSM7PolicyObject -ID $ID
					if ($result) {
						$result = Remove-DSM7PolicyObject -Policy $result -ForceDelete:$ForceDelete -DeleteAssociatedPolicies:$DeleteAssociatedPolicies
						Write-Log 0 "$($AssignedObject.Name) auf ($($TargetObject.Name)) erfolgreich gel�scht." $MyInvocation.MyCommand
						return $true
					} 
				}
				else {
					Write-Log 1 "Keine Policy gefunden nicht gefunden." $MyInvocation.MyCommand
				}
			}
			else {
				Write-Log 1 "($SwName$SwUniqueID) und/oder ($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7Policy


function Get-DSM7PolicyListByAssignedSoftwareObject {
	[CmdletBinding()] 
	param ( [int]$ID)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyListByAssignedObject"
		$Webrequest.AssignedObjectId = $ID
		$Webrequest.ConsiderAllObjectRevisions = $true
		$Webresult = $DSM7WebService.GetPolicyListByAssignedObject($Webrequest).PolicyList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7PolicyListByAssignedSoftware {
	<#
	.SYNOPSIS
		Ermittelt die Policys einer Software.
	.DESCRIPTION
		Ermittelt die Policys einer Software.
	.EXAMPLE
		Get-DSM7PolicyListByAssignedSoftware -ID 1234
	.EXAMPLE
		Get-DSM7PolicyListByAssignedSoftware -Name "Software" -$LDAPPath "Global Software Library/SWF1"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Get-DSM7Policy
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($ID) {
				$Software = Get-DSM7Software -ID $ID
			}
			else {
				$Software = Get-DSM7Software -Name $Name -LDAPPath $LDAPPath
			}
			if ($Software.count -gt 1) {
				Write-Log 1 "($Name) -> ($LDAPPath) nicht eindeutig." $MyInvocation.MyCommand
				return $false
			}
			else {
				$result = Get-DSM7PolicyListByAssignedSoftwareObject -ID $Software.ID
				if ($result) {
					Write-Log 0 "$($Software.Name) erfolgreich." $MyInvocation.MyCommand
					$result = Convert-DSM7PolicyListtoPSObject($result) -resolvedName
					return $result
				}
				else {
					Write-Log 1 "Konnte kein Object finden!" $MyInvocation.MyCommand
					return $false
				}
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7PolicyListByAssignedSoftware

function Get-DSM7PolicyListByTargetObject {
	[CmdletBinding()] 
	param ( [int]$ID)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyListByTarget"
		$Webrequest.TargetId = $ID
		$Webresult = $DSM7WebService.GetPolicyListByTarget($Webrequest).PolicyList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7PolicyListByTarget {
	<#
	.SYNOPSIS
		Ermittelt die Policys eines Ziels.
	.DESCRIPTION
		Ermittelt die Policys eines Ziels.
	.EXAMPLE
		Get-DSM7PolicyListByTarget -Name "Group" -LDAPPath "Managed Users & Computers/OU1"
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[switch]$resolvedName
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($ID -le 1) {
					$Object = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Targets)" -LDAPPath $LDAPPath
				}
				else {
					$Object = Get-DSM7ObjectObject -ID $ID
				}
				if ($Object -and $Object.count -lt 2) {
					$result = Get-DSM7PolicyListByTargetObject -ID $Object.ID
					if ($result) {
						$result = Convert-DSM7PolicyListtoPSObject($result) -resolvedName
						foreach ($Policy in $result) {
							if ($Policy.SchemaTag -ne "SwSetComponentPolicies") {
								$SwPolicy += @($Policy)
							}
						}
						Write-Log 0 "($($Object.Name)) -> erfolgreich." $MyInvocation.MyCommand
						return $SwPolicy
					}
					else {
						Write-Log 1 "Konnte kein Objekte finden!" $MyInvocation.MyCommand
						return $false
					}
				}
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7PolicyListByTarget

function Copy-DSM7PolicyListNewTarget {
	<#
	.SYNOPSIS
		Kopiert die Policys eines Ziels und/oder erweiter eine Referens Ziel zu einer neuen Ziel.
	.DESCRIPTION
		Kopiert die Policys eines Ziels und/oder erweiter eine Referens Ziel zu einer neuen Ziel.
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -NewName "Name" -NewLDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -NewName "Name" -NewLDAPPath "Managed Users & Computers/OU1" -ExtentionName "Name" -ExtentionLDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -ID 1234 -NewID 1234
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -ID 1234 -NewID 1234 -ExtentionID 1234
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Copy-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$ID,
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$NewID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$NewName,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$NewLDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ExtentionID,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ExtentionName,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ExtentionLDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($ID -le 1) {
				$SourceObject = Get-DSM7ObjectObject -ID (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Targets)" -LDAPPath $LDAPPath).ID
			}
			else {
				$SourceObject = Get-DSM7ObjectObject -ID $ID
			}
			if ($SourceObject.count -gt 1) {
				Write-Log 1 "($Name) -> ($LDAPPath) nicht eindeutig." $MyInvocation.MyCommand
				return $false
			}
			else {
				[Array]$SourcePolicy = Get-DSM7PolicyListByTarget -ID $SourceObject.ID
				if ($SourcePolicy) {
					Write-Log 0 "($Name) -> ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					if ($NewLDAPPath) {
						$ParentContID = Get-DSM7LDAPPathID -LDAPPath $NewLDAPPath
					}
					else {
						$ParentContID = $SourceObject.ParentContID
					}
					if ($NewID -le 1) {
						$TargetObject = Get-DSM7ObjectObject -ID (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$NewName)$DSM7Targets)" -LDAPPath $NewLDAPPath).ID
						if (!$TargetObject) {
							$TargetObject = New-DSM7Object -Name $NewName -ParentContID $ParentContID -SchemaTag $SourceObject.SchemaTag -GroupType $SourceObject.GroupType -PropGroupList $SourceObject.PropGroupList
							Write-Log 0 "($NewName) -> ($LDAPPath) erfolgreich erstellt." $MyInvocation.MyCommand
						}
					} 
					else {
						$TargetObject = Get-DSM7ObjectObject -ID $NewID
					}
					if ($TargetObject.count -gt 1) {
						Write-Log 1 "Ziel $NewName nicht erstellt/oder nicht eindeutig!" $MyInvocation.MyCommand
						return $false
					}
					else {
						Write-Log 0 "($($TargetObject.Name)) -> erfolgreich ermittelt." $MyInvocation.MyCommand
						$PolicylistTarget = Get-DSM7PolicyListByTarget -ID $TargetObject.ID
						$I = 0
						$K = $SourcePolicy.Count
						if ($ExtentionID -or $ExtentionName) {
							if ($ExtentionID -le 1) {
								$PolicylistExtention = Get-DSM7PolicyListByTarget -Name $ExtentionName -LDAPPath $ExtentionLDAPPath
							}
							else {
								$PolicylistExtention = Get-DSM7PolicyListByTarget -ID $ExtentionID
							}
						}
						foreach ($Policy in $SourcePolicy) {
							$PolicyTarget = New-Object $DSM7Types["MdsPolicyTarget"]
							$PolicyTarget.TargetObjectID = $TargetObject.ID
							$PolicyTarget.TargetSchemaTag = $TargetObject.SchemaTag
							if ($Policy.SchemaTag -eq "SwSetComponentPolicy" -and $Policy.SchemaTag -ne "JobPolicy") {
								$K--
							}
							else {
								$IDTarget = $($PolicylistTarget|where {$_.AssignedObjectUniqueID -eq $($Policy.AssignedObjectUniqueID)}).ID 
								if ($IDTarget -gt 0) {
									Write-Log 0 "Paket ($($Policy.AssignedObjectName)) ist schon zugewiesen." $MyInvocation.MyCommand
									$K--
								}
								else {
									$ID = $($PolicylistExtention|where {$_.AssignedObjectUniqueID -eq $($Policy.AssignedObjectUniqueID)}).ID 
									if ($ID -gt 0) {
										$result = Add-DSM7PolicyToTarget -ID $ID -TargetName $NewName 

									}
									else {
										$result = Copy-DSM7Policy -ID $Policy.ID -TargetName $NewName -IsActiv:$Policy.IsActive
									}
									if (!$result) {
										Write-Log 1 "Fehler beim Paket ($($Policy.AssignedObjectName))!" $MyInvocation.MyCommand
									} 
									else {
										$I++
										Write-Log 0 "Paket ($($Policy.AssignedObjectName)) erfolgreich zugewiesen." $MyInvocation.MyCommand
									}

								}
							}
						}
						if ($I -eq $K) {
							Write-Log 0 "Alle Policys erstellt! $I Policy(s) erstellt." $MyInvocation.MyCommand
							return $true
						}
						else {
							Write-Log 1 "Nicht alle Policys erstellt! $I von $($SourcePolicy.Count) erstellt." $MyInvocation.MyCommand
							return $false
						}
					}
				}
				else {
					Write-Log 1 "Konnte kein Object finden!" $MyInvocation.MyCommand
					return $false
				}
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Copy-DSM7PolicyListNewTarget

function Get-DSM7PolicyStatisticsByTargetObject {
	[CmdletBinding()] 
	param ( 
		[system.string]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyStatisticsByTarget"
		$Webrequest.TargetId = $ID
		$Webresult = $DSM7WebService.GetPolicyStatisticsByTarget($Webrequest)
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatisticsByTarget {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Software zur�ck.
	.DESCRIPTION
		Gibt eine Statistik von einer Software zur�ck.
	.EXAMPLE
		Get-DSM7PolicyStatisticsByTarget -Name "Software" -LDAPPath "Global Software Library/SwFolder1/SwFolder2" 
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Copy-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.int32]$ID,
		[system.string]$LDAPPath = ""
	)
	if (Confirm-Connect) {
		if ($ID -or $Name) {
			if ($ID -eq 0) {
				$ID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Targets)" -LDAPPath $LDAPPath).ID
			}
			$result = Get-DSM7PolicyStatisticsByTargetObject -ID $ID
			return $result
		}
	}
}
Export-ModuleMember -Function Get-DSM7PolicyStatisticsByTarget

function Get-DSM7PolicyStatisticsObject {
	[CmdletBinding()] 
	param ( 
		$Object
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyStatistics"
		$Webrequest.Policy = $Object
		$Webresult = $DSM7WebService.GetPolicyStatistics($Webrequest).Histogram
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatistics {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Policy zur�ck.
	.DESCRIPTION
		Gibt eine Statistik von einer Policy zur�ck.
	.EXAMPLE
		Get-DSM7PolicyStatistics -ID 123456
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Copy-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$ID
	)
	if (Confirm-Connect) {
		if ($ID) {
			$result = Get-DSM7PolicyStatisticsObject -Object $(Get-DSM7PolicyObject -ID $ID)
			return Convert-DSM7StatiscstoPSObject($result)
		}
	}
}
Export-ModuleMember -Function Get-DSM7PolicyStatistics

function Get-DSM7PolicyStatisticsByPoliciesObject {
	[CmdletBinding()] 
	param ( 
		[system.array]$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyStatisticsByPolicies"
		$Webrequest.PolicyIds = $IDs
		$Webresult = $DSM7WebService.GetPolicyStatisticsByPolicies($Webrequest).HistogramsByPolicyIds
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatisticsByPolicies {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Software zur�ck.
	.DESCRIPTION
		Gibt eine Statistik von einer Software zur�ck.
	.EXAMPLE
		Get-DSM7PolicyStatisticsByTarget -Name "Software" -LDAPPath "Global Software Library/SwFolder1/SwFolder2" 
	.NOTES
	.LINK
		Get-DSM7PolicyList
	.LINK
		Remove-DSM7Policy
	.LINK
		New-DSM7Policy
	.LINK
		Copy-DSM7Policy
	.LINK
		Add-DSM7PolicyToTarget
	.LINK
		Move-DSM7PolicyToTarget
	.LINK
		Update-DSM7Policy
	.LINK
		Get-DSM7PolicyListByTarget
	.LINK
		Get-DSM7PolicyListByAssignedSoftware
	.LINK
		Copy-DSM7PolicyListNewTarget
	.LINK
		Get-DSM7PolicyStatisticsByTarget
	.LINK
		Get-DSM7PolicyStatistics
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.array]$IDs
	)
	if (Confirm-Connect) {
		$result = Get-DSM7PolicyStatisticsByPoliciesObject -ID $ID
		return $result
	}
}
Export-ModuleMember -Function Get-DSM7PolicyStatisticsByPolicies


###############################################################################
# DSM7 Funktionen - Computer <-> ComputerMissingPatch
function Get-DSM7ComputerMissingPatch {
	<#
	.SYNOPSIS
		Gibt die festgestellten Sicherheitsl�cken zur�ck.
	.DESCRIPTION
		Gibt die festgestellten Sicherheitsl�cken zur�ck.
	.EXAMPLE
		Get-DSM7ComputerMissingPatch -Name "Computername"
	.NOTES
	.LINK
		Get-DSM7ComputerMissingPatch
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[int32]$ID,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Name
	)
	if (Confirm-Connect) {
		try {
			if ($ID -lt 1) {
				$ID = $(Get-DSM7Computer -Name $Name).ID
			}
			else {
				$Name = $(Get-DSM7Computer -ID $ID).Name }
			if ($ID) {
				$result = Get-DSM7AssociationList -SchemaTag "ComputerMissingPatch" -SourceObjectID $ID
				if ($result) {
					Write-Log 0 "($Name) erfolgreich." $MyInvocation.MyCommand
					$IDs = @()
					foreach ($Patch in $result) {
						if ($Patch."ComputerMissingPatch.Status" -eq 0) {
							$IDs += $Patch.TargetObjectID
						}
					} 
					$result = Get-DSM7SoftwarebyIDs -IDs $IDs
					return $result
				}
				else {
					Write-Log 1 "($Name) keine Sicherheitsl�cken vorhanden!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "($Name$ID) nicht erfolgreich!" $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7ComputerMissingPatch
###############################################################################
# DSM7 Funktionen - Policy Instance 
function Get-DSM7PolicyInstanceCountByPolicyObject {
	[CmdletBinding()] 
	param ( 
		[system.string]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstanceCountByPolicy"
		$Webrequest.PolicyId = $ID
		$Webrequest.FilterCriteria = New-Object $DSM7Types["PolicyInstanceFilterCriteria"] 
		$Webrequest.FilterCriteria.ComplianceState = "Compliant" 
		$Webresult = $DSM7WebService.GetPolicyInstanceCountByPolicy($Webrequest).NumberOfResults
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyInstanceCountByPolicy {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Policy zur�ck.
	.DESCRIPTION
		Gibt eine Statistik von einer Policy zur�ck.
	.EXAMPLE
		Get-DSM7PolicyInstanceCountByPolicy -Name "Policy" 
	.NOTES
	.LINK
		Get-DSM7PolicyInstanceCountByPolicy
	.LINK
		Get-DSM7PolicyInstanceListByNode
	.LINK
		Update-DSM7PolicyInstance
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.string]$ID,
		[system.string]$LDAPPath = ""
	)
	if (Confirm-Connect) {
		if ($ID -or $Name) {
			$result = Get-DSM7PolicyInstanceCountByPolicyObject -ID $ID
			return $result
		}
	}
}
Export-ModuleMember -Function Get-DSM7PolicyInstanceCountByPolicy
function Get-DSM7PolicyInstanceListByNodeObject {
	[CmdletBinding()] 
	param ( 
		[system.string]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstanceListByNode"
		$Webrequest.NodeID = $ID
		$Webresult = $DSM7WebService.GetPolicyInstanceListByNode($Webrequest).PolicyInstanceList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyInstanceListByNode {
	<#
	.SYNOPSIS
		Gibt eine Liste PolicyInstances von Objekten zur�ck.
	.DESCRIPTION
		Gibt eine Liste PolicyInstances von Objekten zur�ck.
	.EXAMPLE
		Get-DSM7PolicyInstanceListByNode -Name "%Computername%" 
	.NOTES
	.LINK
		Get-DSM7PolicyInstanceCountByPolicy
	.LINK
		Get-DSM7PolicyInstanceListByNode
	.LINK
		Update-DSM7PolicyInstance
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.string]$ID,
		[system.string]$LDAPPath = "",
		[switch]$resolvedName = $false
	)
	if (Confirm-Connect) {
		if ($ID -or $Name) {
			if ($Name) {
				$ID = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name))" -LDAPPath $LDAPPath).ID
			}
			$result = Get-DSM7PolicyInstanceListByNodeObject -ID $ID
			if ($result) {
				Write-Log 0 "PolicyInstances am Object $ID!" $MyInvocation.MyCommand 

				$result = Convert-DSM7PolicyInstanceListtoPSObject -resolvedName:$resolvedName $result 
				return $result
			}
			else {
				Write-Log 1 "Keine PolicyInstances vorhanden am Object $ID!" $MyInvocation.MyCommand 
				return $false
			}
		}
	}
}
Export-ModuleMember -Function Get-DSM7PolicyInstanceListByNode
function Update-DSM7PolicyInstanceListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$PolicyInstanceList
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdatePolicyInstanceList"
		$Webrequest.PolicyInstanceListToUpdate = $PolicyInstanceList
		$Webresult = $DSM7WebService.UpdatePolicyInstanceList($Webrequest).UpdatedPolicyInstanceList
		$policyInstanceIDs = $PolicyInstanceList| select -ExpandProperty PolicyID
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PolicyInstancesObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstances"
		$Webrequest.PolicyInstanceIds = $IDs
		$Webresult = $DSM7WebService.GetPolicyInstances($Webrequest).PolicyInstanceList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7PolicyInstanceListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$Policy,
		[Parameter(Position=1, Mandatory=$true)]
		$PolicyInstance
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeletePolicyInstance"
		$Webrequest.Policy = $Policy
		$Webrequest.PolicyInstanceToDelete = $PolicyInstance
		$Webresult = $DSM7WebService.DeletePolicyInstance($Webrequest)
		$policyInstanceID = $PolicyInstance.ID
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Update-DSM7PolicyInstances {
	<#
	.SYNOPSIS
		�ndert eine PolicyInstances.
	.DESCRIPTION
		�ndert eine PolicyInstances.
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 123456,65141 -active 
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 123456,65141 -reinstall
	.NOTES
	.LINK
		Get-DSM7PolicyInstanceCountByPolicy
	.LINK
		Get-DSM7PolicyInstanceListByNode
	.LINK
		Update-DSM7PolicyInstances
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$IDs,
		[switch]$active,
		[switch]$reinstall
	)
	if (Confirm-Connect) {
		$PolicyInstanceList = Get-DSM7PolicyInstancesObject -IDs $IDs
		if ($PolicyInstanceList) {
			foreach ($PolicyInstance in $PolicyInstanceList) {
				if ($active) {
					$PolicyInstance.IsActive = $active
					Write-Log 0 "Policy Instance aktiviert ID ($($PolicyInstance.ID))" $MyInvocation.MyCommand 
				}
				if ($reinstall) {
					if ($DSM7Version -gt "7.3.0") {
						$PolicyInstance.ReinstallRequestNumber++ 
					}
					else {
						if ($PolicyInstance.ExecutionMode -eq 0) {
							$PolicyInstance.ExecutionMode = 4
						}
						if ($PolicyInstance.ExecutionMode -eq 4) {
							$PolicyInstance.ServerRolloutState = 3
						}
					}
					Write-Log 0 "Policy Instance reinstall ID ($($PolicyInstance.ID))" $MyInvocation.MyCommand 
				} 

			} 
			$result = Update-DSM7PolicyInstanceListObject $PolicyInstanceList
			if ($result) {
				$result = $true
			}
			else {
				$result = $false
			}

			return $result
		}
		else {
			Write-Log 1 "Keine Policy Instance gefunden!!!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Update-DSM7PolicyInstances
function Remove-DSM7PolicyInstance {
	<#
	.SYNOPSIS
		L�scht eine PolicyInstance.
	.DESCRIPTION
		L�scht eine PolicyInstance.
	.EXAMPLE
		Remove-DSM7PolicyInstance -ID 123456
	.NOTES
	.LINK
		Get-DSM7PolicyInstanceCountByPolicy
	.LINK
		Get-DSM7PolicyInstanceListByNode
	.LINK
		Update-DSM7PolicyInstances
	.LINK
		Remove-DSM7PolicyInstance
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$ID
	)
	if (Confirm-Connect) {
		$PolicyInstance = Get-DSM7PolicyInstancesObject -IDs $ID
		$Policy = Get-DSM7PolicyObject -ID $PolicyInstance.PolicyID

		$result = Remove-DSM7PolicyInstanceListObject -Policy $Policy -PolicyInstance $PolicyInstance 
		if ($result) {
			Write-Log 0 "Alle Policyinstancen gel�scht." $MyInvocation.MyCommand
			$result = $true
		}
		else {
			Write-Log 1 "Fehler beim Policyinstancen gel�schen!" $MyInvocation.MyCommand
			$result = $false
		}
		return $result
	}
}
Export-ModuleMember -Function Remove-DSM7PolicyInstance
function Update-DSM7PolicyInstancesActive {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$ID
	)
	$policyInstancelist = Get-DSM7PolicyInstanceListByNode -ID $ID -resolvedName 
	$policyInstanceIDs = $policyInstancelist| where {$_.IsActive -eq $false}|select -ExpandProperty ID
	if ($policyInstanceIDs) {
		foreach ($ID in $policyInstanceIDs) {
			$PolicyName = $($policyInstancelist| where {$_.ID -eq $($ID)}).AssignedObjectName
			Write-Log 0 "$PolicyName - soll aktiviert werden." $MyInvocation.MyCommand
		}
		$result = Update-DSM7PolicyInstances -IDs $policyInstanceIDs -active
		if ($result) { 
			Write-Log 0 "Alle inaktiven Policyinstancen aktiviert." $MyInvocation.MyCommand
		}
	}
	else {
		Write-Log 1 "Keine inaktiven Policyinstancen gefunden." $MyInvocation.MyCommand
	}
}
function Upgrade-DSM7PolicyInstancesByNodeObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$NodeId
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpgradePolicyInstancesByNode"
		$Webrequest.NodeId = $NodeId
		$Webresult = $DSM7WebService.UpgradePolicyInstancesByNode($Webrequest).UpdatedPolicyInstanceList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7SwInstallationConfigurationsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[Array]$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetSwInstallationConfigurations"
		$Webrequest.InstallationConfigurationIds = $IDs
		$Webresult = $DSM7WebService.GetSwInstallationConfigurations($Webrequest).InstallationConfigurations
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
Export-ModuleMember -Function  Get-DSM7SwInstallationConfigurationsObject
###############################################################################
# DSM7 Funktionen - Software 
function Get-DSM7SoftwarebyIDs {
	<#
	.SYNOPSIS
		Gibt ein Software Objekte zur�ck.
	.DESCRIPTION
		Gibt ein Software Objekte zur�ck.
	.EXAMPLE
		Get-DSM7SoftwarebyIDs -IDs 12345,123456
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$IDs
	)
	if (Confirm-Connect) {
		try {
			$SoftwareList = Get-DSM7ObjectsObject -IDs $IDs
			if ($SoftwareList) {
				Write-Log 0 "(...) erfolgreich." $MyInvocation.MyCommand
				$SoftwareList = Convert-DSM7ObjectListtoPSObject($SoftwareList) 

				return $SoftwareList

			}
			else {
				Write-Log 1 "(...) nicht erfolgreich." $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7SoftwarebyIDs
function Get-DSM7Software {
	<#
	.SYNOPSIS
		Gibt ein Software Objekt zur�ck.
	.DESCRIPTION
		Gibt ein Software Objekt zur�ck.
	.EXAMPLE
		Get-DSM7Software -Name "Software" -LDAPPath ""Global Software Library/SWF1"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.string]$ID,
		[system.string]$UniqueID,
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			if ($Name) {
				$Name = Convert-StringtoLDAPString($Name)
				$SoftwareList = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)(Software.IsLastRevision=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
				$SoftwareListID = $SoftwareList.ID
			}
			if ($UniqueID) {
				$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
				$SoftwareListID = $SoftwareList.ID
			}
			if ($ID) {
				$SoftwareListID = $ID
			}
			if ($SoftwareListID -lt 1) {
				Write-Log 1 "($Name) nicht eindeutig. Bitte LDAPPath nutzen!" $MyInvocation.MyCommand
				return $false
			}
			else {
				$Software = Get-DSM7ObjectObject -ID $SoftwareListID
				$Software = Convert-Dsm7ObjecttoPSObject($Software)
				if ($Software) {
					Write-Log 0 "($($Software.Name)) erfolgreich." $MyInvocation.MyCommand
					return $Software
				}
				else {
					Write-Log 1 "($($Software.Name)) nicht erfolgreich." $MyInvocation.MyCommand
					return $false
				}
			} 
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7Software
function Update-DSM7Software {
	<#
	.SYNOPSIS
		�ndert das Softwareobjekt.
	.DESCRIPTION
		�ndert das Softwareobjekt.
	.EXAMPLE
		Update-DSM7Software -Name "Software" -Values @("Name=neuerName")
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.string]$UniqueID,
		[int]$ID,
		[system.string]$LDAPPath,
		[string[]]$Values,
		[switch]$LDAP = $false
	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0 -or $UniqueID) {
				if ($ID -eq 0 -and !$UniqueID) {
					$search = Get-DSM7Software -Name $Name -LDAPPath $LDAPPath
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "�nderung kann nicht erfolgen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($UniqueID) {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
					$ID = $SoftwareList.ID
				}
				if ($ID -gt 0) {
					$Software = Get-DSM7ObjectObject -ID $ID 
					$result = Update-DSM7Object -Object $Software -Values $Values
					if ($result) { 
						$result = Convert-DSM7ObjecttoPSObject($result) -LDAP:$LDAP
						Write-Log 0 "($($Software.Name)) erfolgreich." $MyInvocation.MyCommand
						return $result
					}
					else {
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Update-DSM7Software

function Get-DSM7SoftwareList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Software zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Software zur�ck.
	.EXAMPLE
		Get-DSM7SoftwareList -LDAPPath "Global Software Library/SwFolder1/SwFolder2" -recursive
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Attributes,
		[system.string]$Filter,
		[system.string]$LDAPPath = "",
		[int]$ParentContID,
		[switch]$GenTypeData = $false,
		[switch]$recursive = $false
	)
	if (Confirm-Connect) {
		if ($LDAPPath) {
			$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
		}
		if ($recursive) {
			if ($ParentContID -gt 0) {
				$result = @()
				$resultSoftware = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=Software)$filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
				if ($resultSoftware) {
					$result += $resultSoftware
				} 

				$resultContainer = Get-DSM7ObjectList -Filter $DSM7StructureSoftware -ParentContID $ParentContID -recursive 
				if ($resultContainer) {
					foreach ($Container in $resultContainer) {
						$FilterContainer = "(&(ParentContID=$($Container.ID))(BasePropGroupTag=Software)$filter)"
						$resultSoftware = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer -GenTypeData:$GenTypeData
						if ($resultSoftware) {
							$result += $resultSoftware
						} 
					}
				}
				else {
					$FilterContainer = "(&(ParentContID=$ParentContID)(BasePropGroupTag=Software)$filter)"
					$result = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer 
				} 
			}
			else {
				Write-Log 1 "($LDAPPath) nicht gefunden!" $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			if ($ParentContID -gt 0) {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=Software)$filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}


			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=Software)$filter)" -GenTypeData:$GenTypeData
			}
		} 
		if ($result) {
			return $result
		}
		else {
			return $false
		}
	}
} 
Export-ModuleMember -Function Get-DSM7SoftwareList

function Get-DSM7SoftwareCategoryList {
	<#
	.SYNOPSIS
		Gibt Softwarekategorien zur�ck.
	.DESCRIPTION
		Gibt Softwarekategorien zur�ck.
	.EXAMPLE
		Get-DSM7SoftwareCategoryList -LDAPPath "Global Software Library/Patch Library" -recursive
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Attributes,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Filter,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath = "",
		[Parameter(Position=3, Mandatory=$false)]
		[int]$ParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[switch]$GenTypeData = $false,
		[Parameter(Position=5, Mandatory=$false)]
		[switch]$recursive = $false
	)
	if (Confirm-Connect) {
		if ($LDAPPath) {
			$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
		}
		if ($Attributes) {
			$Attributes = $Attributes + ",SwCategory.TargetCategory"
		}
		else {
			$Attributes = "SwCategory.TargetCategory"
		}
		if ($recursive) {
			if ($ParentContID -gt 0) {
				$result = @()
				$resultCategory = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=SwCategory)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
				if ($resultCategory) {
					$result += $resultCategory
				} 
				$resultContainer = Get-DSM7ObjectList -Filter $DSM7Container -ParentContID $ParentContID -recursive
				foreach ($Container in $resultContainer) {
					$FilterContainer = "(&(ParentContID=$($Container.ID))(BasePropGroupTag=SwCategory)$filter)"
					$resultCategory = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer -GenTypeData:$GenTypeData
					if ($resultCategory) {
						$result += $resultCategory
					}
				} 
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=SwCategory)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
		}
		else {
			if ($ParentContID -gt 0) {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=SwCategory)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(BasePropGroupTag=SwCategory)$Filter)" -GenTypeData:$GenTypeData
			}
		}
		if ($result) {
			return $result
		}
		else {
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7SoftwareCategoryList
function Get-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		Gibt ein Softwarekategorie zur�ck.
	.DESCRIPTION
		Gibt ein Softwarekategorie zur�ck.
	.EXAMPLE
		Get-DSM7SoftwareCategory -ID 1234
	.EXAMPLE
		Get-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=4, Mandatory=$false)]
		[switch]$resolvedName = $false,
		[switch]$LDAP = $false

	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					$Name = Convert-StringtoLDAPString $Name
					$Filter = "(&(Name:IgnoreCase=$Name)(BasePropGroupTag=SWCategory))"
					$search = Get-DSM7ObjectList -Filter $Filter -ParentContID $ParentContID
					if ($search -and $search.Count -le 1) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Softwarekategorie nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7ObjectObject -ID $ID
					if ($Object) {
						$result = Convert-DSM7ObjecttoPSObject($Object) -LDAP:$LDAP
						Write-Log 0 "($($Object.Name)) erfolgreich." $MyInvocation.MyCommand
						if ($resolvedName) {
							foreach ($line in $result.'DynamicSwCategoryProps.Filter'.split(")")) {
								$lineIn = $line.TrimStart("(").TrimStart("|").TrimStart("&").TrimStart("(")
								$linepara = $lineIn.split("=")
								if ($linepara[0].contains("ContainedIn") -or $linepara[0].contains("ListOfIntContains") -or $linepara[0].contains("WhereResultIsSource")) {
									[system.Array]$IDs += $linepara[1].split(",") 
								}
							}
							add-member -inputobject $result -MemberType NoteProperty -name 'DynamicSwCategoryProps.FilterName' -Value $result.'DynamicSwCategoryProps.Filter'
							if ($IDs){
								$NameIDs = get-dsm7objects -IDs $IDs -ObjectGroupType "Catalog"

								foreach ($NameID in $NameIDs) {
									$StringName = Convert-StringtoLDAPString $NameID.Name
									$regex = [Regex]$NameID.ID
									$result.'DynamicSwCategoryProps.FilterName' = $regex.Replace($result.'DynamicSwCategoryProps.FilterName',$StringName,1)
								}
							}

						}

						return $result
					}
					else {
						Write-Log 1 "($ID) nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7SoftwareCategory
function New-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		Erstellt eine Softwarekategorie.
	.DESCRIPTION
		Erstellt eine Softwarekategorie.
	.EXAMPLE
		New-DSM7SoftwareCategory -Name "Softwarekategorie" -Typ "User" -LDAPPath "Global Software Library/Application Library"
	.EXAMPLE
		New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "DynamicSwCategory" -LDAPPath "Global Software Library/Application Library" -Filter "(Name=Test)"
	.EXAMPLE  
		New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "PatchMgmtRuleFilter"
	.EXAMPLE  
		New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "DynamicPatchMgmtRuleFilter" -Filter "(Name=Test)"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[ValidateSet("SwCategory","PatchMgmtRuleFilter","DynamicSwCategory","DynamicPatchMgmtRuleFilter")]
		[system.string]$SchemaTag = "SwCategory",
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position=7, Mandatory=$false)]
		[system.string]$Filter,
		[Parameter(Position=8, Mandatory=$false)]
		[switch]$resolvedName = $false,
		[switch]$PatchLink

	) 
	if (Confirm-Connect) {
		try {
			$CreateGroup = $false
			if ($PatchLink) {
				$PatchMgmtRuleFilterTyp = "LPRPatchPackage"
				$PatchMgmtLicense = "DSM7_LUMENSION_PATCH"
			}
			else {
				$PatchMgmtRuleFilterTyp = "VMWPPatchPackage"
				$PatchMgmtLicense = "DSM7_ADV_PATCH"
			}

			if ($LDAPPath) {
				$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
			}
			if ($SchemaTag -eq "DynamicPatchMgmtRuleFilter" -or $SchemaTag -eq "DynamicSwCategory") {
				if ($resolvedName) {
					$FilterLine = Convert-LDAPStringToReplaceString $Filter
					foreach ($line in $FilterLine.split(")")) {
						$lineIn = $line.TrimStart("(").TrimStart("|").TrimStart("&").TrimStart("(")
						$linepara = $lineIn.split("=")
						if ($linepara[0].contains("ContainedIn") -or $linepara[0].contains("ListOfIntContains")) {
							if ($linepara[0].contains('PatchPackage.Products')) {$PatchSchema = "PatchProduct"}
							if ($linepara[0].contains('PatchPackage.ProductFamily')) {$PatchSchema = "PatchProductFamily"}

							foreach ($LineName in $linepara[1].split(",")){
								$LineName = Convert-ReplaceStringToLDAPString $LineName
								[System.Array]$FilterName = Get-DSM7ObjectList -LDAProot "<LDAP://rootCatalog>" -Filter "(&(Name=$LineName)(PatchCategoryObject.RequiredLicense=$PatchMgmtLicense)(SchemaTag=$PatchSchema)(BasePropGroupTag=PatchCategoryObject))" -Attributes "PatchCategoryObject.RequiredLicense"
								if ($FilterName -and $FilterName.count -eq 1) {
									$LineName = $LineName.replace("\","\\\")
									$regex = [Regex]$LineName
									$Filter = $regex.Replace($Filter,$FilterName.ID,1)
								}
								else {
									Write-Log 1 "Konnte Filter ($Filter) nicht aufl�sen!!!" $MyInvocation.MyCommand 
									return $false
								}
							}
						}
					}

					Write-Log 0 "Neuer Filter ist ($Filter)." $MyInvocation.MyCommand 

				}
			}
			if ($SchemaTag -eq "DynamicPatchMgmtRuleFilter" -or $SchemaTag -eq "PatchMgmtRuleFilter") {
				$ParentContID = Get-DSM7LDAPPathID -LDAPPath "Global Software Library/Patch Library"
			}
			if ($ParentContID -gt 0) {
				$PropGroupList = @()
				switch ($SchemaTag) {
					"DynamicSwCategory" {
						if ($Filter) {$CreateGroup = $true}
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "Filter"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = $Filter
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "DynamicSwCategoryProps"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = "Software"
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "SwCategory"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					} 
					"DynamicPatchMgmtRuleFilter" {

						if ($Filter) {$CreateGroup = $true}
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "Filter"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = $Filter
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "DynamicSwCategoryProps"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = $PatchMgmtRuleFilterTyp
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "SwCategory"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					} 
					"SwCategory" {
						$CreateGroup = $true
						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = "Software"
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "SwCategory"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					} 
					"PatchMgmtRuleFilter" {

						$PropertyList = @()
						$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
						$PropertyListObject.Tag = "TargetCategory"
						$PropertyListObject.Type = "String"
						$PropertyListObject.TypedValue = $PatchMgmtRuleFilterTyp
						$PropertyList += $PropertyListObject
						$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
						$PropGroupListObject.Tag = "SwCategory"
						$PropGroupListObject.PropertyList = $PropertyList
						$PropGroupList += $PropGroupListObject
					}
					default {}
				}
				if ($CreateGroup) {
					$Object = New-DSM7Object -Name $Name -ParentContID $ParentContID -PropGroupList $PropGroupList -SchemaTag $SchemaTag
					if ($Object) {
						Write-Log 0 "Kategorie ($Name) wurde erstellt." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Kategorie konnte nicht erstellt werden!!!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "Gruppen kann nicht erstellt werden!!!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "LDAPPath nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function New-DSM7SoftwareCategory
function Update-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		�ndert eine Softwarekategorie.
	.DESCRIPTION
		�ndert eine Softwarekategorie.
	.EXAMPLE
		Update-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library" -Filter "(Name=Test)"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$Description,
		[Parameter(Position=2, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=4, Mandatory=$false)]
		[system.string]$ParentContID,
		[Parameter(Position=5, Mandatory=$false)]
		[system.string]$Filter,
		[Parameter(Position=6, Mandatory=$false)]
		[switch]$resolvedName = $false,
		[Parameter(Position=7, Mandatory=$false)]
		[system.string]$NewName
	) 
	if (Confirm-Connect) {
		try {
			$Values = @()
			if ($Name -or $ID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					$Category = Get-DSM7SoftwareCategory -Name $Name -ParentContID $ParentContID
					if ($Category) {
						$ID = $Category.ID
					} 
				}
				$Category = Get-DSM7ObjectObject -ID $ID
				if ($Category.PatchMgmtRuleFilterTyp -eq "LPRPatchPackage" ) {
					$PatchMgmtLicense = "DSM7_LUMENSION_PATCH"
				}
				else {
					$PatchMgmtLicense = "DSM7_ADV_PATCH"
				}

				if ($Category.SchemaTag -eq "DynamicPatchMgmtRuleFilter" -or $Category.SchemaTag -eq "DynamicSwCategory") {
					if ($resolvedName -and $Filter) {
						$FilterLine = Convert-LDAPStringToReplaceString $Filter
						foreach ($line in $FilterLine.split(")")) {
							$lineIn = $line.TrimStart("(").TrimStart("|").TrimStart("&").TrimStart("(")
							$linepara = $lineIn.split("=")
							if ($linepara[0].contains("ContainedIn") -or $linepara[0].contains("ListOfIntContains")) {
								if ($linepara[0].contains('PatchPackage.Products')) {$PatchSchema = "PatchProduct"}
								if ($linepara[0].contains('PatchPackage.ProductFamily')) {$PatchSchema = "PatchProductFamily"}

								foreach ($LineName in $linepara[1].split(",")){
									$LineName = Convert-ReplaceStringToLDAPString $LineName
									[System.Array]$FilterName = Get-DSM7ObjectList -LDAProot "<LDAP://rootCatalog>" -Filter "(&(Name=$LineName)(PatchCategoryObject.RequiredLicense=$PatchMgmtLicense)(SchemaTag=$PatchSchema)(BasePropGroupTag=PatchCategoryObject))" -Attributes "PatchCategoryObject.RequiredLicense"
									if ($FilterName -and $FilterName.count -eq 1) {
										$LineName = $LineName.replace("\","\\\")
										$regex = [Regex]$LineName
										$Filter = $regex.Replace($Filter,$FilterName.ID,1) 
									}
									else {
										Write-Log 1 "Konnte Filter ($Filter) nicht aufl�sen!!!" $MyInvocation.MyCommand 
										return $false
									}
								}
							}
						}

						Write-Log 0 "Neuer Filter ist ($Filter)." $MyInvocation.MyCommand 

					}
				}

				if ($Category) {
					switch ($Category.SchemaTag) {
						"DynamicSwCategory" {
							if ($Filter) {
								$Values += "DynamicSwCategoryProps.Filter="+$Filter
							} 
						}
						"DynamicPatchMgmtRuleFilter" {
							if ($Filter) {
								$Values += "DynamicSwCategoryProps.Filter="+$Filter
							} 
						}
						default {}
					}
					if ($Description) {
						$Category.Description = $Description
					}
					if ($NewName) {
						$Category.Name = $NewName
					}
					$Object = Update-DSM7Object -Object $Category -Values $Values
					if ($Object) {
						Write-Log 0 "Softwarekategorie ($($Object.Name)) wurde ge�ndert." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Softwarekategorie konnte nicht ge�ndert werden!!!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "LDAPPath nicht angegeben!!!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Update-DSM7SoftwareCategory
function Remove-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		L�scht eine Softwarekategorie.
	.DESCRIPTION
		L�scht eine Softwarekategorie.
	.EXAMPLE
		Remove-DSM7SoftwareCategory -ID 1234
	.EXAMPLE
		Remove-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwarebyIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Get-DSM7SoftwareCategoryList
	.LINK
		Get-DSM7SoftwareCategory
	.LINK
		New-DSM7SoftwareCategory
	.LINK
		Update-DSM7SoftwareCategory
	.LINK
		Remove-DSM7SoftwareCategory
	.LINK
		Get-DSM7GroupMembers
	.LINK
		Get-DSM7ListOfMemberships
	.LINK
		Update-DSM7MembershipInGroups
	.LINK
		Update-DSM7MemberListOfGroup
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[int]$ID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$ParentContID
	) 
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				if ($LDAPPath) {
					$ParentContID = Get-DSM7LDAPPathID -LDAPPath $LDAPPath
				} 
				if ($ID -eq 0) {
					$Filter = "(&(Name:IgnoreCase=$Name)(BasePropGroupTag=SWCategory))"
					$search = Get-DSM7ObjectList -Filter $Filter -ParentContID $ParentContID
					if ($search -and $search.Count -le 1) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Softwarekategorie nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7ObjectObject -ID $ID
					if ($Object) {
						$result = Remove-DSM7Object -Object $Object
						Write-Log 0 "($($Object.Name)) erfolgreich gel�scht." $MyInvocation.MyCommand
						return $result
					}
					else {
						Write-Log 1 "($ID) nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Remove-DSM7SoftwareCategory

function Get-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$UniqueID
	)
	try {
		$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))"
		$SoftwareListID = $SoftwareList.ID
		$Software = Get-DSM7ObjectObject -ID $SoftwareListID
		$Webrequest = Get-DSM7RequestHeader -action "GetSwInstallationParamDefinitions"
		$Webrequest.ObjectToQuery = $Software
		$Webresult = $DSM7WebService.GetSwInstallationParamDefinitions($Webrequest).InstallationParameterDefinitions
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Add-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$UniqueID,
		[Parameter(Position=1, Mandatory=$true)]
		$Name,
		[Parameter(Position=1, Mandatory=$false)]
		$Values,
		[Parameter(Position=2, Mandatory=$true)]
		$InstallationParamType = "String" ,
		[Parameter(Position=2, Mandatory=$false)]
		$LocigalCategory

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "AddSwInstallationParamDefinition"
		$Webrequest.SwInstallationParamDefinitionToAdd = New-Object $DSM7Types["MdsSWInstallationParamDef"]
		$Webrequest.SwInstallationParamDefinitionToAdd.UniqueID = $UniqueID
		$Webrequest.SwInstallationParamDefinitionToAdd.Tag = $Name
		$Webrequest.SwInstallationParamDefinitionToAdd.InstallationParamType = $InstallationParamType
		$Webrequest.SwInstallationParamDefinitionToAdd.IdProvider = "enteo"
		$Webrequest.SwInstallationParamDefinitionToAdd.SoftwareRevision = 1
		$DisplayNameList = @()
		$DisplayName = New-Object $DSM7Types["MdsDisplayName"]
		$DisplayName.CultureCode ="de"
		$DisplayName.Representation ="Test456"
		$DisplayNameList += $DisplayName 
		$Webrequest.SwInstallationParamDefinitionToAdd.DisplayNameList = $DisplayNameList
		$LocigalCategory = @()
		$DisplayName = New-Object $DSM7Types["MdsDisplayName"]
		$DisplayName.CultureCode ="de"
		$DisplayName.Representation ="Test456"
		$LocigalCategory += $DisplayName 
		$Webrequest.SwInstallationParamDefinitionToAdd.LocigalCategory = $LocigalCategory
		$PredefinedValues = @()
		$PredefinedValue = New-Object $DSM7Types["MdsSWIPPredefinedValue"]
		$PredefinedValue.PredefinedValue ="Test"
		$PredefinedValueDisplayNameList = @()
		$PredefinedValueDisplayName = New-Object $DSM7Types["MdsDisplayName"]
		$PredefinedValueDisplayName.CultureCode ="de"
		$PredefinedValueDisplayName.Representation ="Test456"
		$PredefinedValueDisplayNameList += $PredefinedValueDisplayName 
		$PredefinedValue.DisplayNameList = $PredefinedValueDisplayNameList
		$PredefinedValues += $PredefinedValue
		$Webrequest.SwInstallationParamDefinitionToAdd.PredefinedValueList = $PredefinedValues
		$Webresult = $DSM7WebService.AddSwInstallationParamDefinition($Webrequest).AddedSwInstallationParamDefinition
		Write-Log 0 "($NodeId) erfolgreich." $MyInvocation.MyCommand

		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$Object

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeleteSwInstallationParamDefinition"
		$Webrequest.SwInstallationParamDefinitionToDelete = $Object
		$Webresult = $DSM7WebService.DeleteSwInstallationParamDefinition($Webrequest)

		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
###############################################################################
# DSM7 Funktionen - Variablen 
function Get-DSM7ResolveVariablesForTargetObject {
	[CmdletBinding()] 
	param ( 
		[int]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ResolveVariablesForTarget"
		$Webrequest.TargetObjectId = $ID
		$Webresult = $DSM7WebService.ResolveVariablesForTarget($Webrequest).ResolvedVariableValues
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7ResolveVariablesForTarget {
	<#
	.SYNOPSIS
		Gibt eine Liste von Variablen eines Objektes zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Variablen eines Objektes zur�ck.
	.EXAMPLE
		Get-DSM7ResolveVariablesForTarget -TargetID 123
		Get-DSM7ResolveVariablesForTarget -TargetName %Computer%
	.NOTES
	.LINK
		Get-DSM7VariableGroups
	.LINK
		Get-DSM7ResolveVariablesForTarget
	.LINK
		Set-DSM7VariablesOnTarget
	.LINK
		Remove-DSM7VariablesOnTarget
	#>
	[CmdletBinding()] 
	param ( 
		[int]$TargetID,
		[system.string]$TargetName,
		[system.string]$LDAPPath
	)
	if (Confirm-Connect) {
		try {
			if (!$TargetID) {
				$search = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$TargetName)" -LDAPPath $LDAPPath
				if ($search.count -gt 1) {
					Write-Log 1 "($TargetName) nicht eindeutig. Bitte LDAPPath nutzen!" $MyInvocation.MyCommand
					return $false
				}
				else {
					$TargetID = $search.ID
				}
			}
			if ($TargetID) {
				$Variables = Get-DSM7ResolveVariablesForTargetObject -ID $TargetID
				$Variables = Convert-DSM7VariabletoPSObjects -DSM7Objects $Variables
				Write-Log 0 "Variablen f�r Ziel ID ($TargetID) ermittelt." $MyInvocation.MyCommand
				return $Variables
			} 
			else {
				Write-Log 1 "($TargetName/$TargetID) nicht gefunden!" $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7ResolveVariablesForTarget
function Get-DSM7VariableGroupsObject {
	[CmdletBinding()] 
	param ( 
		$Names
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetVariableGroups"
		$Webrequest.VariableGroupTags = $Names
		$Webresult = $DSM7WebService.GetVariableGroups($Webrequest).VariableGroups
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7VariableGroups {
	<#
	.SYNOPSIS
		Gibt eine Liste von Variablen Gruppen und deren Variablen zur�ck.
	.DESCRIPTION
		Gibt eine Liste von Variablen Gruppen und deren Variablen zur�ck.
	.EXAMPLE
		Get-DSM7VariableGroups Groups
	.NOTES
	.LINK
		Get-DSM7VariableGroups
	.LINK
		Get-DSM7ResolveVariablesForTarget
	.LINK
		Set-DSM7VariablesOnTarget
	.LINK
		Remove-DSM7VariablesOnTarget
	#>
	[CmdletBinding()] 
	param ( 
		$Names
	)
	if (Confirm-Connect) {
		try {
			$VariableGroups = Get-DSM7VariableGroupsObject -Names $Names
			$VariableGroups = Convert-DSM7VariableGrouptoPSObject $VariableGroups
			Write-Log 0 "($Names) erfolgreich." $MyInvocation.MyCommand
			return $VariableGroups

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7VariableGroups
function Set-DSM7VariablesOnTargetObject {
	[CmdletBinding()] 
	param ( 
		$TargetID,
		$VariableSets
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "SetVariablesOnTarget"
		$Webrequest.TargetObjectId = $TargetID
		$Webrequest.Assignments = $VariableSets
		$Webresult = $DSM7WebService.SetVariablesOnTarget($Webrequest)
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Set-DSM7VariablesOnTarget {
	<#
	.SYNOPSIS
		Setzt eine Liste von Variablen eines Objektes.
	.DESCRIPTION
		Setzt eine Liste von Variablen eines Objektes.
	.EXAMPLE
		Get-DSM7ResolveVariablesForTarget -TargetID 123
		Get-DSM7ResolveVariablesForTarget -TargetName %Computer%
	.NOTES
	.LINK
		Get-DSM7VariableGroups
	.LINK
		Get-DSM7ResolveVariablesForTarget
	.LINK
		Set-DSM7VariablesOnTarget
	.LINK
		Remove-DSM7VariablesOnTarget
	#>
	[CmdletBinding()] 
	param ( 
		[int]$TargetID,
		[system.string]$TargetName,
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$true)]
		[system.array]$Variables
	)
	if (Confirm-Connect) {
		try {
			if (!$TargetID) {
				$search = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$TargetName)" -LDAPPath $LDAPPath
				$TargetID = $search.ID
				if ($search.count -gt 1) {
					Write-Log 1 "($TargetName) nicht eindeutig. Bitte LDAPPath nutzen!" $MyInvocation.MyCommand
					return $false
				}
			}
			if ($TargetID) {
				$VariableGroups = Get-DSM7VariableGroups
				foreach ($Variable in $Variables) {
					$VariableNameGroup = $Variable.split("=",2)[0]
					$VariableValue = $Variable.split("=",2)[1]
					$VariableGroup = $VariableNameGroup.split(".")[0]
					$VariableName = $VariableNameGroup.split(".")[1]
					$VariableID = $($VariableGroups|where {$_.Tag -eq $VariableName -and $_.GroupTag -eq $VariableGroup}).ID
					if ($VariableID) {

						$VariableSet = New-Object $DSM7Types["MdsVariableValueAssignment"]

						$VariableSet.VariableId = $VariableID
						$VariableSet.Value=$VariableValue
						$VariableSets += @($VariableSet)
						$VariableSetsName += @("$VariableGroup.$VariableName=$VariableValue")
					}
					else {
						Write-Log 1 "Name ($VariableName) in Gruppe ($VariableGroup) nicht gefunden!" $MyInvocation.MyCommand
					}
				}
				if ($VariableSets) {
					$result = Set-DSM7VariablesOnTargetObject -TargetID $TargetID -VariableSets $VariableSets
					if ($result) {
						Write-Log 0 "Variablen ($VariableSetsName) Ziel ($TargetID) gesetzt." $MyInvocation.MyCommand
					}
				}
				else {
					Write-Log 1 "keine Variablen gefunden!" $MyInvocation.MyCommand
					$result = $false 
				}

			}
			else {
				Write-Log 1 "kein Ziel gefunden!" $MyInvocation.MyCommand
				$result = $false 
			}
			return $result

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Set-DSM7VariablesOnTarget
function Remove-DSM7VariablesOnTargetObject {
	[CmdletBinding()] 
	param ( 
		$TargetID,
		$VariableIDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "RemoveVariablesFromTarget"
		$Webrequest.TargetObjectId = $TargetID
		$Webrequest.VariableId = $VariableIDs
		$Webresult = $DSM7WebService.RemoveVariablesFromTarget($Webrequest)
		return $true
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Remove-DSM7VariablesOnTarget {
	<#
	.SYNOPSIS
		L�sche eine Liste von Variablen an einem Objektes.
	.DESCRIPTION
		L�sche eine Liste von Variablen an eimem Objektes.
	.EXAMPLE
		Get-DSM7ResolveVariablesForTarget -TargetID 123
		Get-DSM7ResolveVariablesForTarget -TargetName %Computer%
	.NOTES
	.LINK
		Get-DSM7VariableGroups
	.LINK
		Get-DSM7ResolveVariablesForTarget
	.LINK
		Set-DSM7VariablesOnTarget
	.LINK
		Remove-DSM7VariablesOnTarget
	#>
	[CmdletBinding()] 
	param ( 
		[int]$TargetID,
		[system.string]$TargetName,
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$true)]
		[system.array]$Variables
	)
	if (Confirm-Connect) {
		try {
			if (!$TargetID) {
				$search = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$TargetName)" -LDAPPath $LDAPPath
				$TargetID = $search.ID
				if ($search.count -gt 1) {
					Write-Log 1 "($TargetName) nicht eindeutig. Bitte LDAPPath nutzen!" $MyInvocation.MyCommand
					return $false
				}
			}
			if ($TargetID) {
				$VariableGroups = Get-DSM7VariableGroups
				foreach ($Variable in $Variables) {
					$VariableGroup = $Variable.split(".")[0]
					$VariableName = $Variable.split(".")[1]
					$VariableID = $($VariableGroups|where {$_.Tag -eq $VariableName -and $_.GroupTag -eq $VariableGroup}).ID
					if ($VariableID) {
						$VariableIDs += @($VariableID)
					}
					else {
						Write-Log 1 "Name ($VariableName) in Gruppe ($VariableGroup) nicht gefunden!" $MyInvocation.MyCommand
					}
				}
				if ($VariableIDs) {
					$result = Remove-DSM7VariablesOnTargetObject -TargetID $TargetID -VariableIDs $VariableIDs
					if ($result) {
						Write-Log 0 "Variablen ($VariableIDs) Ziel ($TargetID) von entfernt!" $MyInvocation.MyCommand
					}
				}
				else {
					Write-Log 1 "keine Variablen gefunden!" $MyInvocation.MyCommand
					$result = $false 
				}

			}
			else {
				Write-Log 1 "kein Ziel gefunden!" $MyInvocation.MyCommand
				$result = $false 
			}
			return $result

		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7VariablesOnTarget
###############################################################################
# DSM7 Funktionen - Schema

function Get-DSM7ObjectSchemaListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		$Names = @()

	)
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetObjectSchemaList"
		$Webrequest.Schematags = $Names
		$Webresult = $DSM7WebService.GetObjectSchemaList($Webrequest).SchemaList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PropGroupDefListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		$Names = @()

	)
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetPropGroupDefList"
		$Webrequest.PropGroupTags = $Names
		$Webresult = $DSM7WebService.GetPropGroupDefList($Webrequest).PropGroupDefList
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Get-DSM7DisplayNameListsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$true)]
		$IDs = @()

	)
	try {
		$IDs = $IDs|Sort-Object|Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetDisplayNameLists"
		$Webrequest.DisplayNameIds = $IDs
		$Webresult = $DSM7WebService.GetDisplayNameLists($Webrequest).DisplayNames
		return $Webresult
	}
	catch [system.exception] 
	{
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
###############################################################################
# DSM7 Funktionen - Computer - Benutzer
###############################################################################
function Add-DSM7ComputerToUser {
	<#
	.SYNOPSIS
		Ordnet einem Computer einen Benutzer zu.
	.DESCRIPTION
		Ordnet einem Computer einen Benutzer zu.
	.EXAMPLE
		Add-DSM7ComputerToUser -ID x -UserID y
	.EXAMPLE
		Add-DSM7ComputerToUser -Name %Computername% -Username %Username%
	.EXAMPLE
		Add-DSM7ComputerToUser -Name %Computername% -UserUniqueID %SID%
	.NOTES
	.LINK
		Add-DSM7ComputerToUser 
	.LINK
		Remove-DSM7ComputerToUser
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.int32]$ID,
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$false)]
		[system.int32]$UserID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$UserName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$UserUniqueID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$UserLDAPPath
	)
	if (Confirm-Connect) {
		if ($DSM7Version -gt "7.3.2") {
			if (!$ID) {
				$ID = (Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath).ID
			}
			if (!$UserID) {
				if ($UserName) {
					$UserID = (Get-DSM7User -Name $UserName -LDAPPath $UserLDAPPath).ID
				}
				if ($UserUniqueID) {
					$UserID = (Get-DSM7User -UniqueID $UserUniqueID -LDAPPath $UserLDAPPath).ID
				}
			}
			if ($ID -and $UserID) {
				$result = New-DSM7AssociationObject -SchemaTag "ComputerAssociatedUser" -SourceObjectID $ID -TargetObjectID $UserID -TargetSchemaTag "User"
				if ($result) {
					Write-Log 0 "Computer ($ID) zu Benutzer ($UserID) erfolgreich hinzugef�gt." $MyInvocation.MyCommand
					$result = Convert-DSM7AssociationtoPSObject($result)
					return $result
				}
				else {
					Write-Log 1 "Computer ($ID) ist schon zu Benutzer ($UserID) zugeordnet!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "Computer ($ID) nicht zu Benutzer ($UserID) hinzugef�gt." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Funktion nicht in der Version vorhanden!" $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Add-DSM7ComputerToUser
function Remove-DSM7ComputerToUser {
	<#
	.SYNOPSIS
		Ordnet einem Computer einen Benutzer zu.
	.DESCRIPTION
		Ordnet einem Computer einen Benutzer zu.
	.EXAMPLE
		Remove-DSM7ComputerToUser -ID x -UserID y
	.EXAMPLE
		Remove-DSM7ComputerToUser -Name %Computername% -Username %Username%
	.EXAMPLE
		Remove-DSM7ComputerToUser -Name %Computername% -UserUniqueID %SID%
	.NOTES
	.LINK
		Add-DSM7ComputerToUser 
	.LINK
		Remove-DSM7ComputerToUser
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position=0, Mandatory=$false)]
		[system.int32]$ID,
		[Parameter(Position=0, Mandatory=$false)]
		[system.string]$Name,
		[Parameter(Position=1, Mandatory=$false)]
		[system.string]$LDAPPath,
		[Parameter(Position=2, Mandatory=$false)]
		[system.int32]$UserID,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$UserName,
		[Parameter(Position=2, Mandatory=$false)]
		[system.string]$UserUniqueID,
		[Parameter(Position=3, Mandatory=$false)]
		[system.string]$UserLDAPPath
	)
	if (Confirm-Connect) {
		if ($DSM7Version -gt "7.3.2") {
			if (!$ID) {
				$ID = (Get-DSM7Computer -Name $Name -LDAPPath $LDAPPath).ID
			}
			if (!$UserID) {
				if ($UserName) {
					$UserID = (Get-DSM7User -Name $UserName -LDAPPath $UserLDAPPath).ID
				}
				if ($UserUniqueID) {
					$UserID = (Get-DSM7User -UniqueID $UserUniqueID -LDAPPath $UserLDAPPath).ID
				}
			}
			if ($ID -and $UserID) {
				$Object = Get-DSM7AssociationListObject -SchemaTag "ComputerAssociatedUser" -SourceObjectID $ID -TargetObjectID $UserID -TargetSchemaTag "User"
				$result = Remove-DSM7AssociationObject -Object $Object
				if ($result) {
					Write-Log 0 "Computer ($ID) zu Benutzer ($UserID) erfolgreich entfernt." $MyInvocation.MyCommand
					return $result
				}
				else {
					Write-Log 1 "Computer ($ID) ist nicht zu Benutzer ($UserID) zugeordnet!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "Computer ($ID) nicht zu Benutzer ($UserID) entfernt." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Funktion nicht in der Version vorhanden!" $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Remove-DSM7ComputerToUser
###############################################################################
# DSM7 Funktionen - Benutzer
###############################################################################
function Get-DSM7User {
	<#
	.SYNOPSIS
		Gibt das Benutzerobjekt zur�ck.
	.DESCRIPTION
		Gibt das Benutzerobjekt zur�ck.
	.EXAMPLE
		Get-DSM7User -Name "%Benutzer%" 
	.EXAMPLE
		Get-DSM7User -ID 1234
	.EXAMPLE
		Get-DSM7User -UniqueID %SID%
	.EXAMPLE
		Get-DSM7User -Name "%Benutzer%" -LDAPPath "Managed Users & Computers/dom�ne/loc/Benutzer"
	.NOTES
	.LINK
		Get-DSM7User
	#>
	[CmdletBinding()] 
	param ( 
		[int]$ID,
		[system.string]$Name,
		[system.string]$UniqueID,
		[system.string]$LDAPPath,
		[switch]$LDAP = $false
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0 -or $UniqueID -gt 0) {
				if ($ID -eq 0 -and !$UniqueID) {
					$Name = Convert-StringtoLDAPString($Name)
					$search = Get-DSM7ObjectList -Filter "(Name:IgnoreCase=$Name)(Schematag=User)" -LDAPPath $LDAPPath
					if ($search.Count -lt 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 2 "($Name) nicht eindeutig bitte LDAPPath benutzen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($UniqueID) {
					$search = Get-DSM7ObjectList -Filter "(UniqueID:IgnoreCase=$UniqueID)(Schematag=User)" -LDAPPath $LDAPPath
					if ($search.Count -lt 2) {
						$ID = $search.ID
					}
					else {
						Write-Log 2 "($Name) nicht eindeutig bitte LDAPPath benutzen!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$result = Get-DSM7ObjectObject -ID $ID
					if ($result) {
						$result = Convert-DSM7ObjecttoPSObject($result) -LDAP:$LDAP
						Write-Log 0 "($($result.Name)) erfolgreich." $MyInvocation.MyCommand
						return $result
					}
					else {
						Write-Log 1 "Benutzer nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				else {
					Write-Log 1 "Benutzer nicht gefunden!" $MyInvocation.MyCommand 
					return $false
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}
		}
		catch [system.exception] 
		{
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7User

# SIG # Begin signature block
# MIIEMQYJKoZIhvcNAQcCoIIEIjCCBB4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUpwVtNDBPxoeSPoHrNoOaqjZz
# ++agggJAMIICPDCCAamgAwIBAgIQUW95fLQCIbVOuAnpDDc4ZTAJBgUrDgMCHQUA
# MCcxJTAjBgNVBAMTHFV3ZSBGcmFua2UgKG1zZyBzZXJ2aWNlcyBBRykwHhcNMTcw
# MjAxMTQwNjQxWhcNMzkxMjMxMjM1OTU5WjAnMSUwIwYDVQQDExxVd2UgRnJhbmtl
# IChtc2cgc2VydmljZXMgQUcpMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1
# v0Lx3FIBWwSSu8g2pB3ye4VcqWWjFj3kGaUQZ7JNJcH/uy74jhtfmQgE2NnEbh1X
# HM3gbSGyPBHsqSFLpTIqM0VTyOVJk3yB1qfIFxUguEZz87C2yZFFagXbwJHamXR7
# LtB+yjARIrbMUf69c5FFMLS93aRg9cLsGJ3dy4fEVQIDAQABo3EwbzATBgNVHSUE
# DDAKBggrBgEFBQcDAzBYBgNVHQEEUTBPgBBp+xZ1jGKZkXWWdUjyNz19oSkwJzEl
# MCMGA1UEAxMcVXdlIEZyYW5rZSAobXNnIHNlcnZpY2VzIEFHKYIQUW95fLQCIbVO
# uAnpDDc4ZTAJBgUrDgMCHQUAA4GBAGclar+QSH1mKf1gt1oNurpTiXBZbM58Pw2Z
# GRRgVc5TaPodd11hJOVYD0GE9MCVu5lA6q2I4aYfN5DWcu5LgmCqfTC1UwTlG9bG
# fx+tTVJlbejYRJ/6ETxZ5ZYSnWB8C31hT2g+0wGW16rB7ddnd4enVCEzNW6d1GDQ
# gItg/dZ0MYIBWzCCAVcCAQEwOzAnMSUwIwYDVQQDExxVd2UgRnJhbmtlIChtc2cg
# c2VydmljZXMgQUcpAhBRb3l8tAIhtU64CekMNzhlMAkGBSsOAwIaBQCgeDAYBgor
# BgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEE
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBR3
# 5UMNqT9NPjxaZ7ckz2FuCDsGyzANBgkqhkiG9w0BAQEFAASBgHOYVbah1o8qi1Rj
# z80WI6VGUPWv4iqhEGm7XaRdHb/512PWBiSVfC2nGji7ZI/9CWP3AjXoW5IDkTrQ
# 5sUaai3GV2S6zPz767HqJEZuE2tpbdHbHB24fenUBrKNa1GQCi8X8dU/dFic6CGN
# evNV0GxUhGbjqaxKTmuajXEW1L8N
# SIG # End signature block