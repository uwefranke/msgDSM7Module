<#  
.SYNOPSIS  
    msg powershell Module fuer die SOAP Schnittstelle fuer Ivanti DSM (Version 7.0 - 2020.2)  
.DESCRIPTION
 	msg powershell Module fuer die SOAP Schnittstelle fuer Ivanti DSM (Version 7.0 - 2020.2)  
.NOTES  
    File Name	: msgDSM7Module.psm1  
    Author		: Raymond von Wolff, Uwe Franke
	Version		: 1.0.4.1
    Requires	: PowerShell V5.1  
	History		: https://github.com/uwefranke/msgDSM7Module/blob/master/CHANGELOG.md
	Help		: https://github.com/uwefranke/msgDSM7Module/blob/master/docs/about_msgDSM7Module.md
.LINK  
		https://github.com/uwefranke/msgDSM7Module
.LINK
		https://www.powershellgallery.com/packages/msgDSM7Module
.LINK  
		https://www.msg-services.de
.LINK  
		https://www.ivanti.com
#>
###############################################################################
# Allgemeine Variablen
$DSM7requiredVersion = "7.0" # benoetigte DSM Version 7.0 oder hoeher
$DSM7testedVersion = "7.4.5.0" # hoechste getestet DSM Version mit diesem Modul
$DSM7Targets = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=Computer)(SchemaTag=User)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=ExternalGroup)(SchemaTag=DynamicGroup))"
$DSM7Structure = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=DynamicGroup)(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$DSM7Container = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$DSM7StructureComputer = "(|(SchemaTag=Domain)(SchemaTag=OU)(SchemaTag=CitrixFarm)(SchemaTag=CitrixZone)(SchemaTag=Group)(SchemaTag=DynamicGroup))"
$DSM7StructureSoftware = "(|(SchemaTag=SwFolder)(SchemaTag=SwLibrary)(SchemaTag=DynamicSwCategory)(SchemaTag=SwCategory))"
$global:DSM7GenTypeData = "ModifiedBy,CreatedBy,Modified,Created"
$DSM7RegPath = "HKEY_LOCAL_MACHINE\SOFTWARE\NetSupport\NetInstall"
$DSM7ExportNCP = "NcpExport.exe"
$DSM7ExportNCPXML = "NcpExport.xml"
$DSM7NCPfile = "NiCfgSrv.ncp"
###############################################################################
# Allgemeine interne Funktionen
function Get-PSCredential {
	[CmdletBinding()] 
	param ($User, $Password)
	$SecPass = convertto-securestring -asplaintext -string $Password -force
	$Creds = new-object System.Management.Automation.PSCredential -argumentlist $User, $SecPass
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
	$typs = @("Info   ", "Warning", "Error  ")
	$dt = Get-Date -format "yyyy-MM-dd HH:mm:ss"
	$strtyp = $typs[$typ]
	$global:LogMessage = "[$Name] - $message"
	$global:LogMessageTyp = $strtyp
	$LogMessageStr = "$dt - $strtyp - [$Name] - $message"
	if (!$Ochestrator) {
		if (!$DSM) {
			switch ($typ) {
				0 { Write-Host $LogMessageStr }
				1 { Write-Host $LogMessageStr -ForegroundColor Yellow }
				2 { Write-Host $LogMessageStr -ForegroundColor Red }
			}
		}
		else {
			switch ($typ) {
				0 { write-nireport $LogMessage }
				1 { write-nireport $LogMessage }
				2 { Set-NIError $LogMessage }
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.String]$Logpath, 
		[Parameter(Position = 1, Mandatory = $true)]
		[system.String]$Logname,
		[int]$CountLogFiles = 0, 
		[int]$DaysLogFilesAge = 0
	)
	$DateLogFiles = (Get-Date).AddDays(-$DaysLogFilesAge)
	Write-Log 0 "Loesche alle Datei(en), behalte die letzen $CountLogFiles,aelter $DaysLogFilesAge und enthaelt im Namen $Logname befindet sich im Path $Logpath" $MyInvocation.MyCommand
	try { 
		$filestodelete = Get-ChildItem $logpath -Recurse | Where-Object { $_.Name -like "$Logname*" } 
		if ($DaysLogFilesAge -gt 0) {
			$filestodelete = $filestodelete | Where-Object { $_.LastWriteTime -lt $DateLogFiles }
			Write-Log 0 "Loesche $($filestodelete.count) Datei(en) die aelter als $DaysLogFilesAge Tage sind." $MyInvocation.MyCommand
			$filestodelete | Remove-Item -Force -Verbose
			$filestodelete = Get-ChildItem $logpath -Recurse | Where-Object { $_.Name -like "$Logname*" } 
		}
		if ($filestodelete.Count -gt $CountLogFiles -and $CountLogFiles -gt 0) {
			$filestodelete = $filestodelete | sort LastWriteTime -Descending | select -Last ($filestodelete.Count - $CountLogFiles)
			Write-Log 0 "Loesche $($filestodelete.count) Datei(en) ueber der Anzahl $CountLogFiles." $MyInvocation.MyCommand
			$filestodelete | Remove-Item -Force -Verbose
		}
		return $true
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
Export-ModuleMember -Function Remove-Log
function Convert-ToFilename {
	param(
		$filename
	)
	$filename = $filename.Replace("/", "_")
	$filename = $filename.Replace("\", "_")
	$filename = $filename.Replace(";", "_")
	$filename = $filename.Replace(",", "_")
	return $filename
}
function Test-RegistryValue {
	param (
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]$Path,
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]$Value
	)
	try {
		Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
		Write-Log 0 "Value ($Value) found" $MyInvocation.MyCommand 
		return $true
	}
	catch {
		Write-Log 1 "Value ($Value) not found!" $MyInvocation.MyCommand 
		return $false
	}
}
function Remove-Files {
	<#
	.SYNOPSIS
		function to remove files
	.DESCRIPTION
		function to remove files
	.EXAMPLE
		Remove-Files -CountFiles 10 -DaysFilesAge 30 -Filepath "c:\Logs" -Filename "Test"
	.NOTES
	.LINK
		Remove-Files
	.LINK
		Remove-Files
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[system.String]$Filepath, 
		[Parameter(Position = 1, Mandatory = $true)]
		[system.String]$Filename,
		[int]$CountFiles = 0, 
		[int]$DaysFilesAge = 0
	)
	$DateFiles = (Get-Date).AddDays(-$DaysFilesAge)
	Write-Log 0 "Delete all file(s), keep the last $CountFiles, older then $DaysFilesAge and file name contains ($filename) in path ($Filepath)." $MyInvocation.MyCommand
	try { 
		$filestodelete = Get-ChildItem $Filepath -Recurse | Where-Object { $_.Name -like "$filename*" } 
		if ($DaysFilesAge -gt 0) {
			$filestodelete = $filestodelete | Where-Object { $_.LastWriteTime -lt $DateFiles }
			Write-Log 0 "Delete $($filestodelete.count) file(s), older then $DaysFilesAge day(s)." $MyInvocation.MyCommand
			$filestodelete | Remove-Item -Force -Verbose:$Verbose
			$filestodelete = Get-ChildItem $Filepath -Recurse | Where-Object { $_.Name -like "$filename*" } 
		}
		if ($filestodelete.Count -gt $CountFiles -and $CountFiles -gt 0) {
			$filestodelete = $filestodelete | Sort-Object LastWriteTime -Descending | select-object -Last ($filestodelete.Count - $CountFiles)
			Write-Log 0 "Delete $($filestodelete.count) file(s) more then count ($CountFiles)." $MyInvocation.MyCommand
			$filestodelete | Remove-Item -Force -Verbose:$Verbose
		}
		return $true
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function remove-XMLSpecialChar {
	param (
		$file
	)
	$temp = (Get-Content -path $file ) -join "`r"
	$temp = $temp | foreach { $_ -replace "`n|`r" }
	#	$temp = $temp -replace "[^\u0000-\u007F]+"
	$temp = $temp -replace "\x04"
	$temp = $temp -replace "\x05"
	$temp = $temp -replace "\x06"
	$temp = $temp -replace "\x1d"
	$temp = $temp -replace "<\?xml version=`"1.0`" encoding=`"UTF-8`"\?>" , "<?xml version=`"1.0`" encoding=`"UTF-8`"?>`n"
	Set-Content -path $file -Value $temp -Force
	$temp = ""
	return $true
}
function Get-RegistryValue {
	param (
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]$Path,
		[parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]$Value
	)
	try {
		$Item = (Get-ItemProperty -Path $Path | Select-Object $Value).$Value
		Write-Log 0 "Value ($Value): ($Item)" $MyInvocation.MyCommand 
		return $Item
	}
	catch {
		Write-Log 1 "cant read Value ($Value)!" $MyInvocation.MyCommand 
		return $false
	}
}
function Convert-StringtoPSRegKey {
	param (
		$KeyPath,
		[switch]$is32Bit
	)
	$KeyPath = $KeyPath -replace ("HKLM\\", "HKLM:\\")
	$KeyPath = $KeyPath -replace ("HKU\\", "HKU:\\")
	$KeyPath = $KeyPath -replace ("HKEY_LOCAL_MACHINE\\", "HKLM:\\")
	$KeyPath = $KeyPath -replace ("HKEY_USERS\\", "HKU:\\")
	if ($is32Bit -and [Environment]::Is64BitProcess -and $KeyPath -like "HKLM:\\SOFTWARE*") {
		$KeyPath = $KeyPath -replace ("HKLM:\\\\SOFTWARE", "HKLM:\\SOFTWARE\WOW6432Node")

	}
	return $KeyPath
}
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
		ueberprueft die Benutzerinformationen und ggf. Passwortabfrage
	.DESCRIPTION
		ueberprueft die Benutzerinformationen und ggf. Passwortabfrage
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
		$Password = Read-Host "Bitte Passwort fuer ($Domain\$User) eingeben" -AsSecureString 
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
		Connect-DSM7Web -WebServer "DSM7 BLS" -UseSSL -UseDefaultCredential
	.EXAMPLE
		Connect-DSM7Web -WebServer "DSM7 BLS" -Port 8080 -User "Domuene\Benutzer" -UserPW "******"
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
		[System.String]$Port,
		[switch]$UseSSL = $false,
		[switch]$UseDefaultCredential = $false,
		[System.String]$User,
		[System.String]$UserPW,
		$Credential
	)
	if ($UseSSL) {
		$Protocol = "https://"
		if (!$Port) { 
			$Port = "443"
		}
	}
	else {
		$Protocol = "http://"
		if (!$Port) { 
			$Port = "8080"
		}
	}
	$DSM7wsdlURL = $Protocol + $WebServer + ":" + $Port + "/blsAdministration/AdministrationService.asmx?WSDL" 
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
			else {
				if (!($Credential -is [PSCredential])) {
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
					Write-Log 2 "DSM Version wird nicht unterstuetzt!!!" $MyInvocation.MyCommand 
					return $false
				}
				if ($DSM7Version -gt $DSM7testedVersion) {
					Write-Log 1 "DSM Version ($DSM7Version) nicht getestet!!! Einige Funktionen koennten nicht mehr richtige Ergebnisse liefern oder gar nicht mehr funktionieren!!!" $MyInvocation.MyCommand 
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
Export-ModuleMember -Function Connect-DSM7Web -Variable DSM7WebService, DSM7Types
function Connect-DSM7WebRandom {
	<#
	.SYNOPSIS
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zufoallig ausgewaehlt wird.
	.DESCRIPTION
		Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zufaellig ausgewaehlt wird.
	.EXAMPLE
		Connect-DSM7WebRandom -WebServer "DSM7 BLS" -UseDefaultCredential
	.EXAMPLE
		Connect-DSM7WebRandom -WebServer "DSM7 BLS" -Port 8080 -User "Domaene\Benutzer" -UserPW "******"
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
		[switch]$UseSSL = $false,
		[switch]$UseDefaultCredential = $false,
		[System.String]$User,
		[System.String]$UserPW,
		$Credential
	)
	if ($UseDefaultCredential) {
		$SOAP = Connect-DSM7Web -WebServer $WebServer -Port $Port -UseSSL:$UseSSL -UseDefaultCredential
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
		$SOAP = Connect-DSM7Web -WebServer $WebServer -Port $Port -UseSSL:$UseSSL -Credential $Credential
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
				$SOAP = Connect-DSM7Web -WebServer $BLSServer -Port $Port -UseSSL:$UseSSL -Credential $Credential
			}
			else {
				$SOAP = Connect-DSM7Web -WebServer $BLSServer -Port $Port -UseSSL:$UseSSL -UseDefaultCredential
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
	$action = $action + "Request" 
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
	$Webrequest.ServerInfo.CmdbGuid = { 0000000 - 0000 - 0000 - 0000 - 000000000000 } 
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
	catch [System.Web.Services.Protocols.SoapException] {
		Write-Log 2 $_.Exception.Detail.Message.'#text' $MyInvocation.MyCommand 
		return $false 
	} 
	catch {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Confirm-Connect {
	if (!$DSM7WebService) {
		Write-Log 1 "Keine Verbindung zum Webserver (SOAP)!!!`n`t`t`t`tBitte die Funktion `"Connect-DSM7Web`" fuer die Verbindung benutzen,`n`t`t`t`toder es ist ein Fehler beim verbinden aufgetreten." $MyInvocation.MyCommand
		return $false
	}
	else {
		return $true
	}
}
function Find-DSM7Target {
	[CmdletBinding()] 
	param (
		[System.int32]$ID,
		[System.String]$Name,
		[System.String]$LDAPPath,
		[System.int32]$ParentContID
	)
	if ($ID) {
		$Target = (Get-DSM7ObjectList -Filter "(&(ObjectId=$ID)$DSM7Targets)")
	}
	else { 
		if ($ParentContID) {
			$Target = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Targets)" -ParentContID $ParentContID)
		}
		else {
			$Target = (Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)$DSM7Targets)" -LDAPPath $LDAPPath)
		}
	}
	if ($Target) {
		if ($Target.BasePropGroupTag -eq "OrgTreeContainer") {
			$TargetObject = Get-DSM7OrgTreeContainer -ID $Target.ID 
		}
		else {
			$TargetObject = Get-DSM7ObjectObject -ID $Target.ID
		}
		write-log 0 "TargetObject mit ID($($TargetObject.ID)) gefunden." $MyInvocation.MyCommand
		return $TargetObject
	}
	else {
		write-log 1 "TargetObject nicht gefunden!" $MyInvocation.MyCommand
		return $false
	}
}
###############################################################################
# DSM7 Funktionen - Convert
###############################################################################
function Convert-StringtoLDAPString ($String) {
	if ($String.contains("\")) { $String = $String.Replace("\", "\\") }
	if ($String.Contains("(") -or $String.Contains(")") ) {
		$String = $String.Replace("(", "\(")
		$String = $String.Replace(")", "\)")
	}
	return $String
}
function Convert-LDAPStringToReplaceString ($String) {
	if ($String.contains("\(")) { $String = $String.Replace("\(", "\+") }
	if ($String.Contains("\)")) { $String = $String.Replace("\)", "\-") }
	return $String
}
function Convert-ReplaceStringToLDAPString ($String) {
	if ($String.contains("\+")) { $String = $String.Replace("\+", "\(") }
	if ($String.Contains("\-")) { $String = $String.Replace("\-", "\)") }
	return $String
}

function Convert-DSM7ObjectListtoPSObject {
	[CmdletBinding()] 
	param ( 
		$ObjectList,
		[switch]$LDAP = $false
	)
	$DSM7ObjectMembers = ($ObjectList[0] | Get-Member -MemberType Properties).Name
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
	$DSM7ObjectMembers = ($ObjectList | Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $ObjectList) {
		$Raw = Convert-DSM7ObjecttoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -LDAP:$LDAP
		$DSM7ObjectList[$DSM7Object.ID] = @($Raw)
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
		$DSM7ObjectMembers = ($DSM7Object | Get-Member -MemberType Properties).Name
	}
	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData" -and $DSM7ObjectMember -ne "TargetObjectList" -and $DSM7ObjectMember -ne "PropGroupList") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0) {
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists | Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers) {
						for ($I = 0; $I -lt $($DSM7ObjectMemberLists.Count) - 1; $I++) {
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData | get-member -membertype properties)) { 
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
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
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
	$IDs += ($ObjectList | Select-Object -ExpandProperty SourceObjectID)
	$IDs += ($ObjectList | Select-Object -ExpandProperty TargetObjectID)
	$IDs = $IDs | Get-Unique
    $DSM7Objects = @()
	$DSM7Objects += Get-DSM7ObjectsObject -IDs $IDs
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
		$IDs += ($ObjectList | Select-Object -ExpandProperty AssignedObjectID)
		$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
		$DSM7ObjectsTargetIDs = $ObjectList | Select-Object -ExpandProperty TargetObjectList | Select-Object -ExpandProperty TargetObjectID -Unique
		foreach ($DSM7ObjectsTargetID in $DSM7ObjectsTargetIDs) {
			$filter = "$filter(ObjectID=$DSM7ObjectsTargetID)"
		}
		$filter = "(|$filter)"
		$DSM7ObjectsTargets = Get-DSM7ObjectList -Filter $filter
	}
	$DSM7ObjectMembers = ($ObjectList[0] | Get-Member -MemberType Properties).Name
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
	if (!$DSM7ObjectMembers) { $DSM7ObjectMembers = ($DSM7Object | Get-Member -MemberType Properties).Name }
	if ($resolvedName) {
		if (!$DSM7Objects) {
			$IDs = @() 
			$IDs += ($DSM7Object | Select-Object -ExpandProperty AssignedObjectID)
			$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
		}
		if (!$DSM7ObjectsTargets) {
			$DSM7ObjectsTargetIDs = $DSM7Object | Select-Object -ExpandProperty TargetObjectList | Select-Object -ExpandProperty TargetObjectID -Unique
			foreach ($DSM7ObjectsTargetID in $DSM7ObjectsTargetIDs) {
				$filter = "$filter(ObjectID=$DSM7ObjectsTargetID)"
			}
			$filter = "(|$filter)"
			$DSM7ObjectsTargets = Get-DSM7ObjectList -Filter $filter
		}
	}

	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData" -and $DSM7ObjectMember -ne "TargetObjectList" -and $DSM7ObjectMember -ne "PropGroupList" -and $DSM7ObjectMember -ne "PolicyRestrictionList" -and $DSM7ObjectMember -ne "SwInstallationParameters") {
			if ($DSM7ObjectMember -like "*List") {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				if ($DSM7ObjectMemberLists.Count -gt 0) {
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists | Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers) {
						for ($I = 0; $I -lt $($DSM7ObjectMemberLists.Count) - 1; $I++) {
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData | get-member -membertype properties)) { 
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
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}
	add-member -inputobject $Raw -MemberType NoteProperty -name "PolicyRestrictionList" -Value $DSM7Object.PolicyRestrictionList

	if ($resolvedName) {
		if ($AssignedObjectName -ne $AssignedObjectNameOld) {
			$AssignedObjectName = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).Name 
			$AssignedObjectUniqueId = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).UniqueId 
			$AssignedObjectSchemaTag = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).SchemaTag
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectName -Value $AssignedObjectName
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectSchemaTag -Value $AssignedObjectSchemaTag
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectUniqueId -Value $AssignedObjectUniqueId 
		$AssignedObjectNameOld = $AssignedObjectName
	}

	if ($DSM7Object.SwInstallationParameters) {
		$SwInstallationParameterList = @()
		foreach ($SwInstallationParameter in $DSM7Object.SwInstallationParameters) {
			$SwInstallationParameterPSObject = New-Object PSObject
			$DSM7ObjectMemberListsMembers = ($DSM7Object.SwInstallationParameters | Get-Member -MemberType Properties).Name
			foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers) {
				if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
					foreach ($GenTypeData in $($SwInstallationParameter.GenTypeData | get-member -membertype properties)) { 
						add-member -inputobject $SwInstallationParameterPSObject -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $SwInstallationParameter.GenTypeData.$($GenTypeData.Name)
					}
				} 
				else {
					add-member -inputobject $SwInstallationParameterPSObject -MemberType NoteProperty -name "$DSM7ObjectMemberListsMember" -Value $SwInstallationParameter.$DSM7ObjectMemberListsMember



				}
			}
			$SwInstallationParameterList += $SwInstallationParameterPSObject
		}

	}
	add-member -inputobject $Raw -MemberType NoteProperty -name "SwInstallationParameters" -Value $SwInstallationParameterList
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
				$TargetObjectName = $($DSM7ObjectsTargets | where { $_.ID -eq $TargetObject.TargetObjectID }).Name 
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
				if ($DSM7ObjectMemberLists.Count -gt 0) {
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists | Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers) {
						for ($I = 0; $I -lt $($DSM7ObjectMemberLists.Count) - 1; $I++) {
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData | get-member -membertype properties)) { 
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
		$AssignedObjectID = $($DSM7Configs | where { $_.ID -eq $Raw.AssignedConfiguration }).SoftwareObjectID
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectID -Value $AssignedObjectID
	} 

	if ($resolvedName) {
		if ($AssignedObjectName -ne $AssignedObjectNameOld) {
			$AssignedObjectName = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).Name 
			$AssignedObjectSchemaTag = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).SchemaTag 
			$AssignedObjectUniqueId = $($DSM7Objects | where { $_.ID -eq $Raw.AssignedObjectID }).UniqueId 
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectName -Value $AssignedObjectName
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectSchemaTag -Value $AssignedObjectSchemaTag
		add-member -inputobject $Raw -MemberType NoteProperty -name AssignedObjectUniqueId -Value $AssignedObjectUniqueId 
		$AssignedObjectNameOld = $AssignedObjectName
		if ($DSM7Object.TargetObjectID) {
			$TargetObjectName = $($DSM7Objects | where { $_.ID -eq $DSM7Object.TargetObjectID }).Name 
			add-member -inputobject $Raw -MemberType NoteProperty -name TargetObjectName -Value $TargetObjectName
		}
	}
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
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
			$TargetObjectName = $($DSM7Objects | where { $_.ID -eq $TargetObject.TargetObjectID }).Name 
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
	param ( $ObjectList, [switch]$resolvedName = $false)
	$DSM7ConfigIDs = @()
	if ($DSM7Version -gt "7.3.0") {
		$DSM7ConfigIDs += ($ObjectList | where { $_.AssignedConfiguration } | Select-Object -ExpandProperty AssignedConfiguration)
		if ($DSM7ConfigIDs.count -gt 0) { 
			$DSM7Configs = Get-DSM7SwInstallationConfigurationsObject $DSM7ConfigIDs
		}
	} 
	if ($resolvedName) {
		$IDs = @() 
		if ($DSM7Version -gt "7.3.0") {
			$IDs += ($DSM7Configs | where { $_.SoftwareObjectID } | Select-Object -ExpandProperty SoftwareObjectID)
		}
		else {
			$IDs += ($ObjectList | Select-Object -ExpandProperty AssignedObjectID)
		}
		$IDs += ($ObjectList | Select-Object -ExpandProperty TargetObjectID)
		$DSM7Objects = Get-DSM7ObjectsObject -IDs $IDs
	} 
	$DSM7ObjectMembers = ($ObjectList | Get-Member -MemberType Properties).Name
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
				foreach ($GenTypeData in $($Variable.GenTypeData | get-member -membertype properties)) { 
					add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $Variable.GenTypeData.$($GenTypeData.Name)
				}
			}
			$AllVariable += @($Raw)
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
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
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
function Convert-DSM7SwInstallationParamDefinitionstoPSObject {
	[CmdletBinding()] 
	param (
		$DSM7Object,
		$DSM7ObjectMembers,
		[switch]$resolvedName = $false
	)
	$Raw = New-Object PSObject
	foreach ($DSM7ObjectMember in $DSM7ObjectMembers) {
		if ($DSM7ObjectMember -ne "GenTypeData") {
			if ($DSM7ObjectMember -like "*List" -or $DSM7ObjectMember -like "*Category" ) {
				$DSM7ObjectMemberLists = $DSM7Object.$DSM7ObjectMember
				$RawListArray = @()
				foreach ($DSM7ObjectMemberList in $DSM7ObjectMemberLists) {
					$DSM7ObjectMemberListMembers = ($DSM7ObjectMemberList | Get-Member -MemberType Properties).Name

					$RawList = New-Object PSObject
					$RawListArrayListArray = @()
					foreach ($DSM7ObjectMemberListMember in $DSM7ObjectMemberListMembers) {
						$value = $DSM7ObjectMemberList.$DSM7ObjectMemberListMember
						if ($DSM7ObjectMemberListMember -like "*List") {
							$DSM7ObjectMemberListMemberLists = $DSM7ObjectMemberList.$DSM7ObjectMemberListMember
							foreach ($DSM7ObjectMemberListMemberList in $DSM7ObjectMemberListMemberLists) {
								$RawListList = New-Object PSObject
								$DSM7ObjectMemberListMemberListMembers = ($DSM7ObjectMemberListMemberList | Get-Member -MemberType Properties).Name
								foreach ($DSM7ObjectMemberListMemberListMember in $DSM7ObjectMemberListMemberListMembers) {
									if ($DSM7ObjectMemberListMemberListMember -eq "GenTypeData") {
										foreach ($GenTypeData in $($DSM7ObjectMemberListMemberList.GenTypeData | get-member -membertype properties)) { 
											add-member -inputobject $RawListList -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7ObjectMemberListMemberList.GenTypeData.$($GenTypeData.Name)
										}
									} 
									else {
										add-member -inputobject $RawListList -MemberType NoteProperty -name "$DSM7ObjectMemberListMemberListMember" -Value $DSM7ObjectMemberListMemberList.$DSM7ObjectMemberListMemberListMember
									}
								}
								$RawListArrayListArray += $RawListList
							}
							$value = $RawListArrayListArray
						}
						if ($DSM7ObjectMemberListMember -eq "GenTypeData") {
							foreach ($GenTypeData in $($DSM7ObjectMemberList.GenTypeData | get-member -membertype properties)) { 
								add-member -inputobject $RawList -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7ObjectMemberList.GenTypeData.$($GenTypeData.Name)
							}
						} 
						else {
							add-member -inputobject $RawList -MemberType NoteProperty -name "$DSM7ObjectMemberListMember" -Value $value
						}
					}
					$RawListArray += $RawList
				}
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $RawListArray
			}
			else {
				add-member -inputobject $Raw -MemberType NoteProperty -name $DSM7ObjectMember -Value $DSM7Object.$DSM7ObjectMember
			}
		} 
	}
	if ($DSM7Object.GenTypeData) {
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
			add-member -inputobject $Raw -MemberType NoteProperty -name "GenTypeData.$($GenTypeData.Name)" -Value $DSM7Object.GenTypeData.$($GenTypeData.Name)
		}
	}
	if ($resolvedName -and $DSM7Object.InstallationParamType -eq "ObjectLink") {
		$filter = ($($DSM7Object.FrontEndData) -split "ObjectFilter>")[1].trimend("</")
		if ($DSM7Object.DefaultValue) {
			$DefaultValueName = (Get-DSM7Object -ID $DSM7Object.DefaultValue).Name
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name "DefaultValueName" -Value $DefaultValueName
	}
	return $Raw
}

function Convert-DSM7SwInstallationParamDefinitionstoPSObjects {
	[CmdletBinding()] 
	param (
		$DSM7Objects,
		[switch]$resolvedName = $false
	)
	$DSM7ObjectMembers = ($DSM7Objects[0] | Get-Member -MemberType Properties).Name
	foreach ($DSM7Object in $DSM7Objects) {
		$DSM7Object = Convert-DSM7SwInstallationParamDefinitionstoPSObject -DSM7Object $DSM7Object -DSM7ObjectMembers $DSM7ObjectMembers -resolvedName:$resolvedName
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
				if ($DSM7ObjectMemberLists.Count -gt 0) {
					$DSM7ObjectMemberListsMembers = ($DSM7ObjectMemberLists | Get-Member -MemberType Properties).Name
					foreach ($DSM7ObjectMemberListsMember in $DSM7ObjectMemberListsMembers) {
						for ($I = 0; $I -lt $DSM7ObjectMemberLists.Count; $I++) {
							if ($DSM7ObjectMemberListsMember -eq "GenTypeData") {
								foreach ($GenTypeData in $($DSM7ObjectMemberLists[$I].GenTypeData | get-member -membertype properties)) { 
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
		foreach ($GenTypeData in $($DSM7Object.GenTypeData | get-member -membertype properties)) { 
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
	$DSM7ObjectMembers = ($DSM7Objects | Get-Member -MemberType Properties).Name

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
		Gibt eine Liste von Objekten zurueck. 
	.DESCRIPTION
		Gibt eine Liste von Objekten zurueck. 
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
			if ($GenTypeData) {
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7ObjectList
function Get-DSM7ObjectObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
if ($Dev) { Export-ModuleMember -Function Get-DSM7ObjectObject }
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
		[Parameter(Position = 0, Mandatory = $true)]
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
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs, 
		[system.string]$ObjectGroupType = "Object"
	)
	try {
		$IDs = $IDs | Sort-Object | Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetObjects"
		$Webrequest.ObjectIds = $IDs
		$Webrequest.RequestedObjectGroupType = $ObjectGroupType
		$Webresult = $DSM7WebService.GetObjects($Webrequest).ObjectList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7Objects {
	<#
	.SYNOPSIS
		Gibt eine Liste von Objekten zurueck. 
	.DESCRIPTION
		Gibt eine Liste von Objekten zurueck. Nur benutzen wenn man die Objektstruktur genau kennt!!!
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
		[Parameter(Position = 0, Mandatory = $true)]
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
		if ($DSM7Version -ne "7.4.3.0") {
			if (!$DSM7PropGroupDefList) {
				$global:DSM7PropGroupDefList = Convert-ArrayToHash -myArray (Get-DSM7PropGroupDefListObject) -myKey "Tag" 

			}
		}
		$groupkey = @{}
		$valueskey = @{}
		foreach ($Value in $Values) {
			$ValueName = $Value.split("=", 2)[0]
			$ValueValue = $Value.split("=", 2)[1]
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
				Write-Log 0 "aendere $Groupname.$Valuename = $Value" $MyInvocation.MyCommand
				$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
				$PropertyListObject.Tag = $Valuename
				$PropertyListObject.Type = ((($Object.PropGroupList | Where Tag -EQ $Groupname).propertyList) | where Tag -EQ $Valuename).Type
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7LDAPPath {
	<#
	.SYNOPSIS
		Gibt ein den LDAP Path zurueck. 
	.DESCRIPTION
		Gibt ein den LDAP Path zurueck. 
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
	catch [system.exception] {
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
			if ($DSM7CreationSource) { $CreationSource = $DSM7CreationSource }
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function New-DSM7InfrastructureJob {
	[CmdletBinding()] 
	param (
		[system.string]$SchemaTag,
		$PropGroupList,
		[system.string]$GroupType = "Object"
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreateInfrastructureJob"
		$Webrequest.JobDefinition = New-Object $DSM7Types["MdsObject"]
		$Webrequest.JobDefinition.SchemaTag = $SchemaTag
		$Webrequest.JobDefinition.Name = $DSM7CreationSource
		$Webrequest.JobDefinition.PropGroupList = $PropGroupList
		$Webresult = $DSM7WebService.CreateInfrastructureJob($Webrequest)
		Write-Log 0 "Job ($SchemaTag) erfolgreich." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] {
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
		Write-Log 0 "Loeschen Objekt $($Object.Name) ($($Object.ID)) erfolgreich." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] {
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
		Write-Log 0 "Verschieben von $($Object.Name) ($($Object.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $true)]
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
				$IDs = $($IDs | sort -Unique)
				$Webresult = Get-DSM7AssociationsObject -IDs $IDs -SchemaTag $SchemaTag 
				return $Webresult
			}
			else {
				return $false
			}
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
function Get-DSM7AssociationList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Association zurueck.
	.DESCRIPTION
		Gibt eine Liste von Association zurueck.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$SchemaTag,
		[system.string]$SourceObjectID = "*",
		[system.string]$TargetObjectID = "*",
		[system.string]$TargetSchemaTag = "*",
		[switch]$resolvedName = $false
	)
	if (Confirm-Connect) {
		#workaround not work SchemaList with version 7.4.3
		$DSM7AssociationSchemaListCheck = $true
		if ($DSM7Version -ne "7.4.3.0") {
			if (!$DSM7AssociationSchemaList) {
				$global:DSM7AssociationSchemaList = Get-DSM7AssociationschemaList | select -ExpandProperty Tag
			}
			if ($DSM7AssociationSchemaList.Contains($SchemaTag)) {
				$DSM7AssociationSchemaListCheck = $true
			}
			else {
				$DSM7AssociationSchemaListCheck = $false
			}
		}
		if ($DSM7AssociationSchemaListCheck) {
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
		$Webrequest = Get-DSM7RequestHeader -action "GetAssociationSchemaList"
		$Webrequest.SchemaTags = @()
		$Webresult = $DSM7WebService.GetAssociationSchemaList($Webrequest).SchemaList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7AssociationschemaList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Association Schemas zurueck.
	.DESCRIPTION
		Gibt eine Liste von Association Schemas zurueck.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[int]$ID, 
		[Parameter(Position = 1, Mandatory = $true)]
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Get-DSM7AssociationsObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs ,
		[Parameter(Position = 1, Mandatory = $true)]
		[system.string]$SchemaTag
	)
	try {
		$IDs = $IDs | Sort-Object | Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetAssociations"
		$Webrequest.AssociationIds = $IDs
		$Webrequest.SchemaTag = $SchemaTag
		$Webresult = $DSM7WebService.GetAssociations($Webrequest).AssociationList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function New-DSM7AssociationObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$SchemaTag,
		[Parameter(Position = 1, Mandatory = $true)]
		[Int]$SourceObjectID,
		[Parameter(Position = 2, Mandatory = $true)]
		[Int]$TargetObjectID,
		[Parameter(Position = 3, Mandatory = $true)]
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$SchemaTag,
		[Parameter(Position = 1, Mandatory = $true)]
		[system.Int32]$SourceObjectID,
		[Parameter(Position = 2, Mandatory = $true)]
		[system.string]$TargetSchemaTag,
		[Parameter(Position = 3, Mandatory = $true)]
		[System.Int32]$TargetObjectID
	)
	if (Confirm-Connect) {
		#workaround not work GetAssociationSchemaList with version 7.4.3
		$DSM7AssociationSchemaListCheck = $true
		if ($DSM7Version -ne "7.4.3.0") {
			if (!$DSM7AssociationSchemaList) {
				$global:DSM7AssociationSchemaList = Get-DSM7AssociationschemaList | select -ExpandProperty Tag
			}
			if ($DSM7AssociationSchemaList.Contains($SchemaTag)) {
				$DSM7AssociationSchemaListCheck = $true
			}
			else {
				$DSM7AssociationSchemaListCheck = $false
			}
		}
		if ($DSM7AssociationSchemaListCheck -and $SourceObjectID -gt 0 -and $TargetObjectID - 0 -and $TargetSchemaTag) {
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
		$Webrequest.AssociationListToCreate = $ObjectMdsAssociations
		$Webresult = $DSM7WebService.CreateAssociationList($Webrequest).CreatedListOfAssociations
		return $Webresult
	}
	catch [system.exception] {
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetDisplayNameLists"
		$Webrequest.DisplayNameIds = $IDs
		$Webresult = $DSM7WebService.GetDisplayNameLists($Webrequest).DisplayNames
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7DisplayNameLists {
	<#
	.SYNOPSIS
		Gibt DisplayNameList zurueck.
	.DESCRIPTION
		Gibt DisplayNameList zurueck.
	.EXAMPLE
		Get-DSM7GetDisplayNameLists -IDs 1,2,3,4,5 
	.NOTES
	.LINK
	#>
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
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
		catch [system.exception] {
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
		Gibt eine Liste von Computern zurueck.
	.DESCRIPTION
		Gibt eine Liste von Computern zurueck.
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
				$resultContainer = Get-DSM7ObjectList -Filter $DSM7Container -ParentContID $ParentContID -recursive -GenTypeData:$GenTypeData
				foreach ($Container in $resultContainer) {
					$FilterContainer = "(&(ParentContID=$($Container.ID))(SchemaTag=Computer)$filter)"
					$resultComputer = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer -GenTypeData:$GenTypeData
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
		Gibt das Computerobjekt zurueck.
	.DESCRIPTION
		Gibt das Computerobjekt zurueck.
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7Computer
function Update-DSM7Computer {
	<#
	.SYNOPSIS
		aendert das Computerobjekt.
	.DESCRIPTION
		aendert das Computerobjekt.
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
						Write-Log 1 "Aenderung kann nicht erfolgen!" $MyInvocation.MyCommand 
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
		catch [system.exception] {
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
	catch [system.exception] {
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
		[System.String]$WakeUpTime,
		[switch]$UpdatePolicyInstancesToPolicyStatus
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "ReinstallComputer"
		$Webrequest.Computer = $Computer
		$Webrequest.Options = New-Object $DSM7Types["ReinstallComputerOptions"]
		$Webrequest.Options.StartReinstallImmediately = $StartReinstallImmediately
		if ($WakeUp) {
			$Webrequest.Options.WakeUpForExecutionOptions = New-Object $DSM7Types["WakeUpForExecutionOptions"]
			$Webrequest.Options.WakeUpForExecutionOptions.WakeUpComputer = $WakeUp
			if ($WakeUpTime) {
				$StartDate = $(Get-Date($WakeUpTime)) 
			}
			else {
				$StartDate = $(Get-Date) 
			}
			#$StartDate = $StartDate + [System.TimeZoneInfo]::Local.BaseUtcOffset
			Write-Log 0 "Start Datum ist:($StartDate)" $MyInvocation.MyCommand
			$Webrequest.Options.WakeUpForExecutionOptions.ExecutionStartDate = New-Object $DSM7Types["MdsDateTime"]
			$Webrequest.Options.WakeUpForExecutionOptions.ExecutionStartDate.DateTime = $StartDate
			$Webrequest.Options.WakeUpForExecutionOptions.ExecutionStartDate.IsLocalTime = $true
		}
		$Webrequest.Options.UpdatePolicyInstancesToPolicyStatus = $UpdatePolicyInstancesToPolicyStatus
		$Webresult = $DSM7WebService.ReinstallComputer($Webrequest).ReinstallComputerResult
		Write-Log 0 "Computer auf Reinstall gesetzt." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] {
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
	.EXAMPLE
		Install-DSM7Computer -Name "%Computername%" -WakeUp 
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
		[switch]$UpdatePolicyInstancesActive,
		[switch]$WakeUp,
		[System.string]$WakeupTime
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
						if (Install-DSM7ReinstallComputer -Computer $(Get-DSM7ObjectObject -ID $ID) -StartReinstallImmediately -UpdatePolicyInstancesToPolicyStatus -WakeUp:$WakeUp -WakeUpTime $WakeupTime) {
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Install-DSM7Computer 
function Send-DSM7ComputerWakeUP {
	<#
	.SYNOPSIS
		WakeUP (WOL) den Computer.
	.DESCRIPTION
		WakeUP (WOL) den Computer.
	.EXAMPLE
		WakeUp-DSM7Computer -Name "%Computername%"
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
	.LINK
		WakeUp-DSM7Computer
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Name,
		[system.int32]$ID
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
						return $false
					}
				}
				if ($ID -gt 0) {
					$PropGroupList = @()
					$computerIdProperty = New-Object $DSM7Types["MdsTypedPropertyOfNullableOfInt32"]
					$computerIdProperty.Tag = "ComputerId"
					$computerIdProperty.Type = "ObjectLink"
					$computerIdProperty.TypedValue = $ID

					$computerRelatedJobPropGroup = New-Object $DSM7Types["MdsPropGroup"]
					$computerRelatedJobPropGroup.Tag = "ComputerRelatedJob";
					$computerRelatedJobPropGroup.PropertyList = @()
					$computerRelatedJobPropGroup.PropertyList += $computerIdProperty;
					$PropGroupList += $computerRelatedJobPropGroup

					$result = New-DSM7InfrastructureJob -PropGroupList $PropGroupList -SchemaTag "WakeUpOnLanJob"
					if ($result) {
						Write-Log 0 "WOL erfolgreich versendet." $MyInvocation.MyCommand
						return $true 
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}
		} 
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Set-Alias WakeUp-DSM7Computer Send-DSM7ComputerWakeUP
Export-ModuleMember -Function Send-DSM7ComputerWakeUP -Alias WakeUp-DSM7Computer
function Send-DSM7ComputerFastInstall {
	<#
	.SYNOPSIS
		FastInstall für den Computer oder PolicyInstanzen.
	.DESCRIPTION
		FastInstall für den Computer oder PolicyInstanzen.
	.EXAMPLE
		Send-DSM7ComputerFastInstall -Name "%Computername%"
	.EXAMPLE
		Send-DSM7ComputerFastInstall -Name "%Computername%" -PolicyInstanceIDs 1,2,3,4
	.EXAMPLE
		Send-DSM7ComputerFastInstall -Name "%Computername%" -IgnoreMaintenanceWindow
	.EXAMPLE
		Send-DSM7ComputerFastInstall -Name "%Computername%" -ShutdownAfterInstallation
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
	.LINK
		WakeUp-DSM7Computer
	.LINK
		Send-DSM7ComputerFastInstall
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[System.Array]$PolicyInstanceIDs,
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("User", "Service", "Auto")]
		[System.String]$ExecutionContext = "Auto",
		[Parameter(Position = 3, Mandatory = $false)]
		[switch]$IgnoreMaintenanceWindow,
		[Parameter(Position = 4, Mandatory = $false)]
		[switch]$ShutdownAfterInstallation
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
						return $false
					}
				}
				if ($ID -gt 0) {
					$PropGroupList = @()
					$computerIdProperty = New-Object $DSM7Types["MdsTypedPropertyOfNullableOfInt32"]
					$computerIdProperty.Tag = "ComputerId"
					$computerIdProperty.Type = "ObjectLink"
					$computerIdProperty.TypedValue = $ID

					$executionContextProperty = New-Object $DSM7Types["MdsTypedPropertyOfString"]
					$executionContextProperty.Tag = "ExecutionContext"
					$executionContextProperty.Type = "Option"
					$executionContextProperty.TypedValue = $ExecutionContext
					
					$ignoreMaintenanceWindowProperty = New-Object $DSM7Types["MdsTypedPropertyOfNullableOfBoolean"]
					$ignoreMaintenanceWindowProperty.Tag = "IgnoreMaintenanceWindow"
					$ignoreMaintenanceWindowProperty.Type = "Bool"
					$ignoreMaintenanceWindowProperty.TypedValue = $IgnoreMaintenanceWindow

					$policyInstancesToExecuteProperty = New-Object $DSM7Types["MdsTypedPropertyOfMdsCollectionOfInt"]
					$policyInstancesToExecuteProperty.Tag = "PolicyInstancesToExecute"
					$policyInstancesToExecuteProperty.Type = "CollectionOfInt"
					$policyInstancesToExecuteProperty.TypedValue = $policyInstancesToExecute

					$computerRelatedJobPropGroup = New-Object $DSM7Types["MdsPropGroup"]
					$computerRelatedJobPropGroup.Tag = "ComputerRelatedJob";
					$computerRelatedJobPropGroup.PropertyList = @()
					$computerRelatedJobPropGroup.PropertyList += $computerIdProperty

					$fastInstallJobPropGroup = New-Object $DSM7Types["MdsPropGroup"]
					$fastInstallJobPropGroup.Tag = "FastInstallJob"
					$fastInstallJobPropGroup.PropertyList = @()
					$fastInstallJobPropGroup.PropertyList += $executionContextProperty
					$fastInstallJobPropGroup.PropertyList += $ignoreMaintenanceWindowProperty
					$fastInstallJobPropGroup.PropertyList += $policyInstancesToExecuteProperty

					$PropGroupList += $fastInstallJobPropGroup
					$PropGroupList += $computerRelatedJobPropGroup
					
					$result = New-DSM7InfrastructureJob -PropGroupList $PropGroupList -SchemaTag "FastInstallJob"
					if ($result) {
						Write-Log 0 "Fastinstall erfolgreich versendet zu ID($ID)." $MyInvocation.MyCommand
						return $true 
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
			}
		} 
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Set-Alias FastInstall-DSM7Computer Send-DSM7ComputerFastInstall
Export-ModuleMember -Function Send-DSM7ComputerFastInstall -Alias FastInstall-DSM7Computer
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
				$Values += "BasicInventory.InitialMACAddress=" + $InitialMACAddress
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function New-DSM7Computer 
function Remove-DSM7Computer {
	<#
	.SYNOPSIS
		Loescht ein Computerobjekt.
	.DESCRIPTION
		Loescht ein Computerobjekt.
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
						Write-Log 1 "Loeschen kann nicht erfolgen! Bitte LDAPPath benutzen." $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Computer = Get-DSM7ObjectObject -ID $ID
					$result = Remove-DSM7Object -Object $Computer 
					Write-Log 0 "Computer ($($Computer.Name)) geloescht." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$toLDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
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
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		Gibt ein Containerobjekt zurueck.
	.DESCRIPTION
		Gibt ein Containerobjekt zurueck.
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
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7OrgTreeContainers {
	<#
	.SYNOPSIS
		Gibt ein Containerobjekt zurueck.
	.DESCRIPTION
		Gibt ein Containerobjekt zurueck.
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7OrgTreeContainers 

function New-DSM7OrgTreeContainerObject {
	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$SchemaTag = "OU",
		[Parameter(Position = 3, Mandatory = $true)]
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
			if ($DSM7CreationSource) { $CreationSource = $DSM7CreationSource }
			$Webrequest.NewOrgTreeContainer.GenTypeData.CreationSource = $CreationSource
		}
		$Webresult = $DSM7WebService.CreateOrgTreeContainer($Webrequest).CreatedOrgTreeContainer
		Write-Log 0 "($($Webresult.Name)) ($($Webresult.ID)) erfolgreich." $MyInvocation.MyCommand
		return $Webresult

	}
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $true, HelpMessage = "Name der OU")]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("OU", "Domain", "CitrixFarm", "CitrixZone", "SwFolder")]
		[system.string]$SchemaTag = "OU",
		[Parameter(Position = 3, Mandatory = $true)]
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
		catch [system.exception] {
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $true)]
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
								Write-Log 1 "($($Object.Name)) ($toLDAPPath) konnte nicht ausgefuehrt werden." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Update-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		aendert ein Containerobjekt.
	.DESCRIPTION
		aendert ein Containerobjekt.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 3, Mandatory = $false)]
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
						Write-Log 1 "Container nicht gefunden, kann nicht geaendert werden!" $MyInvocation.MyCommand 
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
							Write-Log 0 "($($Object.Name)) ($LDAPPath) erfolgreich geaendert." $MyInvocation.MyCommand
							$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
							return $result
						}
						else {
							Write-Log 1 "($($Object.Name)) ($LDAPPath) konnte nicht ausgefuehrt werden." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7OrgTreeContainer {
	<#
	.SYNOPSIS
		Loescht ein Containerobjekt.
	.DESCRIPTION
		Loescht ein Containerobjekt.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
						Write-Log 1 "Container nicht gefunden, kann nicht geloescht werden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($ID -gt 0) {
					$Object = Get-DSM7OrgTreeContainerObject -ID $ID
					if ($Object) {
						$result = Remove-DSM7OrgTreeContainerObject -Object $Object
						if ($result) {
							Write-Log 0 "($Name) ($LDAPPath) erfolgreich geloescht." $MyInvocation.MyCommand
							$result = Convert-DSM7ObjecttoPSObject($result) -LDAP
							return $result
						}
						else {
							Write-Log 1 "($Name) ($LDAPPath) konnte nicht ausgefuehrt werden." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
		Gibt ein Gruppenobjekt zurueck.
	.DESCRIPTION
		Gibt ein Gruppenobjekt zurueck.
	.EXAMPLE
		Get-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Get-DSM7Group -Name "Gruppe" -ParentDynGroup "Gruppe"
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		Get-DSM7GroupList
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ParentDynGroupID,
		[Parameter(Position = 6, Mandatory = $false)]
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7Group
function Get-DSM7GroupList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Gruppen zurueck.
	.DESCRIPTION
		Gibt eine Liste von Gruppen zurueck.
	.EXAMPLE
		Get-DSM7GroupList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
	.NOTES
	.LINK
		Get-DSM7Group
	.LINK
		Get-DSM7GroupList
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
		[ValidateSet("Group", "DynamicGroup", "ExternalGroup")]
		[system.string]$SchemaTag,
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
		if ($SchemaTag) {
			$Filter = "(SchemaTag=$SchemaTag)$Filter"
		}
		$Filter = "(&(|(BasePropGroupTag=Group)(BasePropGroupTag=ExternalGroup))$Filter)"
		$Attributes = "$Attributes,DynamicGroupProps.Filter,DynamicGroupProps.IsComplex,DynamicGroupProps.ParentDynGroupId,Group.TargetCategory"
		$Attributes = $Attributes.TrimStart(",")
		if ($recursive) {
			if ($ParentContID -gt 0) {
				$result = @()
				$resultComputer = Get-DSM7ObjectList -Attributes $Attributes -Filter $Filter -ParentContID $ParentContID -GenTypeData:$GenTypeData
				if ($resultComputer) {
					$result += $resultComputer
				} 
				$resultContainer = Get-DSM7ObjectList -Filter $DSM7Container -ParentContID $ParentContID -recursive
				foreach ($Container in $resultContainer) {
					$FilterContainer = "(&(ParentContID=$($Container.ID))$filter)"
					$resultComputer = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer 
					if ($resultComputer) {
						$result += $resultComputer
					}
				} 
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter $Filter -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
		}
		else {
			if ($ParentContID -gt 0) {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter $Filter -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter $Filter -GenTypeData:$GenTypeData
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
Export-ModuleMember -Function Get-DSM7GroupList
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("Group", "DynamicGroup", "ExternalGroup")]
		[system.string]$SchemaTag = "Group",
		[Parameter(Position = 3, Mandatory = $false)]
		[ValidateSet("Computer", "User")]
		[system.string]$Typ = "Computer",
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 6, Mandatory = $false)]
		[int]$ParentDynGroupID,
		[Parameter(Position = 7, Mandatory = $false)]
		[system.string]$DynamicGroupFilter,
		[Parameter(Position = 7, Mandatory = $false)]
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
						if ($DynamicGroupFilter) { $CreateGroup = $true }
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
									Write-Log 2 "Uebergeordnete Gruppe nicht eindeutig, bitte ID benutzen!!!" $MyInvocation.MyCommand 
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
						if ($ADSID) { $CreateGroup = $true }
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function New-DSM7Group
function Update-DSM7Group {
	<#
	.SYNOPSIS
		Aendert ein Gruppenobjekt.
	.DESCRIPTION
		Aendert ein Gruppenobjekt.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 5, Mandatory = $false)]
		[int]$ParentDynGroupID,
		[Parameter(Position = 6, Mandatory = $false)]
		[system.string]$DynamicGroupFilter,
		[Parameter(Position = 7, Mandatory = $false)]
		[system.string]$ADSID,
		[Parameter(Position = 8, Mandatory = $false)]
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
								$Values += "DynamicGroupProps.Filter=" + $DynamicGroupFilter
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
						Write-Log 0 "Gruppe ($($Object.Name)) wurde geaendert." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Gruppe konnte nicht geaendert werden!!!" $MyInvocation.MyCommand 
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
		catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 2, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$toLDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$toParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 5, Mandatory = $false)]
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Move-DSM7Group
function Remove-DSM7Group {
	<#
	.SYNOPSIS
		Loescht ein Gruppenobjekt.
	.DESCRIPTION
		Loescht ein Gruppenobjekt.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ParentDynGroupID,
		[Parameter(Position = 6, Mandatory = $false)]
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
						Write-Log 0 "($($Object.Name)) erfolgreich geloescht." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $true)]
		[system.string]$GroupName,
		[Parameter(Position = 2, Mandatory = $false)]
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$Filter
	)
	if (Confirm-Connect) {
		if ($Name -or $ID -gt 0) {
			if ($ID -le 1) {
				if ($ParentContID) {
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[ValidateSet("None", "Containers", "HierarchicalObjects", "DynamicGroups", "StaticGroups", "ExternalGroups", "AllStaticGroups", "AllGroups", "All")]
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
					return $false
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
		Write-Log 0 "Objektmitgliedschaften erfolgreich geaendert." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7MembershipInGroups {
	<#
	.SYNOPSIS
		aendert eine oder mehrere Gruppen eines Objektes.
	.DESCRIPTION
		aendert eine oder mehrere Gruppen eines Objektes.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
								$AddGroupIDs = $AddGroupList | select -ExpandProperty ID
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
								$RemoveGroupIDs = $RemoveGroupList | select -ExpandProperty ID
							}
						}
						if ($RemoveGroupIDs) {
							$RemoveGroupobjects = Get-DSM7ObjectsObject -IDs $RemoveGroupIDs
						}
						if ($RemoveGroupobjects -or $AddGroupobjects) {
							$result = Update-DSM7MembershipInGroupsObject -Object $Object -AddGroupobjects $AddGroupobjects -RemoveGroupobjects $RemoveGroupobjects
							if ($result) {
								$AddGroupNames = $AddGroupobjects | select -ExpandProperty Name
								$RemoveGroupNames = $RemoveGroupobjects | select -ExpandProperty Name
								Write-Log 0 "Objekt: $($Object.Name) - Gruppe(n) hinzugefuegt: ($AddGroupNames) und Gruppe(n) entfernt: ($RemoveGroupNames)" $MyInvocation.MyCommand
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
						Write-Log 1 "Diese Funktion benoetigt 7.2.2 oder hoeher!!!" $MyInvocation.MyCommand
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
	} 
	else {
		Write-Log 1 "Name($Name) oder ID($ID) nicht angegeben!!!" $MyInvocation.MyCommand 
		return $false
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
		Write-Log 0 "Gruppenmitgliedschaften erfolgreich geaendert." $MyInvocation.MyCommand
		return $true
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7MemberListOfGroup {
	<#
	.SYNOPSIS
		aendert eine oder mehrere Objekte zu einer Gruppe.
	.DESCRIPTION
		aendert eine oder mehrere Objekte zu einer Gruppe.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
								$AddObjectIDs = $AddObjectList | select -ExpandProperty ID
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
							$RemoveObjectIDs = Get-DSM7ObjectList -Filter $filter | select -ExpandProperty ID
						}
						if ($RemoveObjectIDs) {
							$RemoveObjectobjects = Get-DSM7ObjectsObject -IDs $RemoveObjectIDs
						}
						if ($RemoveObjectobjects -or $AddObjectobjects) {
							$result = Update-DSM7MemberListOfGroupObject -Group $Object -AddObjectobjects $AddObjectobjects -RemoveObjectobjects $RemoveObjectobjects
							if ($result) {
								$AddObjectNames = $AddObjectobjects | select -ExpandProperty Name
								$RemoveObjectNames = $RemoveObjectobjects | select -ExpandProperty Name
								Write-Log 0 "Gruppe: $($Object.Name) Objekt(e) hinzugefuegt: ($AddObjectNames) und Objekt(e) entfernt: ($RemoveObjectNames)" $MyInvocation.MyCommand
								return $true
							}
							else {
								Write-Log 1 "Gruppe: $($Object.Name) Objekt(e) nicht hinzugefuegt: ($AddObjectNames) und Objekt(e) ($RemoveObjectNames)!!!" $MyInvocation.MyCommand
								return $false
							}

						}
						else {
							Write-Log 1 "Gruppe: $($Object.Name) Objekt(e) nicht gefunden: ($AddObjectNames) und Objekt(e)($RemoveObjectNames)!!!" $MyInvocation.MyCommand

						}

					}
					else {
						Write-Log 1 "Diese Funktion benoetigt 7.2.3 oder hoeher!!!" $MyInvocation.MyCommand
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$GroupName,
		[Parameter(Position = 3, Mandatory = $false)]
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
				Write-Log 0 "($Name) zu Gruppe ($GroupName) erfolgreich hinzugefuegt." $MyInvocation.MyCommand
				$result = Convert-DSM7AssociationtoPSObject($result)
				return $result
			}
			else {
				Write-Log 1 "($Name) ist schon in Gruppe ($GroupName)!" $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "($Name) nicht zu ($GroupName) hinzugefuegt." $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Add-DSM7ComputerToGroup
function Remove-DSM7ComputerFromGroup {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[int]$GroupID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$GroupName,
		[Parameter(Position = 5, Mandatory = $false)]
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
		[Parameter(Position = 0, Mandatory = $false)]
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Get-DSM7PoliciesObject {
	[CmdletBinding()] 
	param (
		[system.array]$IDs
	)
	if (Confirm-Connect) {
		try {
			$Webrequest = Get-DSM7RequestHeader -action "GetPolicies"
			$Webrequest.PolicyIds = $IDs
			$Webresult = $DSM7WebService.GetPolicies($Webrequest).PolicyList
			return $Webresult
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Update-DSM7PolicyListObject {
	[CmdletBinding()] 
	param (
		$PolicyList
	)
	if (Confirm-Connect) {
		try {
			$Webrequest = Get-DSM7RequestHeader -action "UpdatePolicyList"
			$Webrequest.PolicyListToUpdate = $PolicyList
			$Webresult = $DSM7WebService.UpdatePolicyList($Webrequest).UpdatedPolicyList
			return $Webresult
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
function Update-DSM7PolicyObject {
	[CmdletBinding()] 
	param (
		$Policy,
		$InstallationParametersOfSwSetComponents,
		$Options,
		[switch]$Stats
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdatePolicy"
		if ($DSM7Version -gt "7.3.0") {
			$Webrequest.PolicyToUpdate = New-Object $DSM7Types["PolicyToManage"]
			$Webrequest.PolicyToUpdate.Policy = $Policy
			if ($InstallationParametersOfSwSetComponents) {
				$i = 0
				foreach ($key in $InstallationParametersOfSwSetComponents.Keys) {
					$Webrequest.PolicyToUpdate.InstallationParametersOfSwSetComponents += New-Object $DSM7Types["SwSetComponentInstallationParameters"]
					$Webrequest.PolicyToUpdate.InstallationParametersOfSwSetComponents[$i].SwInstallationParameters = $InstallationParametersOfSwSetComponents[$key]
					$Webrequest.PolicyToUpdate.InstallationParametersOfSwSetComponents[$i].SwSetComponentObjectId = $key
					$i++
				} 
			}
			if ($Options) {
				$Webrequest.Options = $Options
			}
		}
		else {
			$Webrequest.PolicyToUpdate = $Policy
			if ($InstallationParametersOfSwSetComponents) {
				$i = 0
				foreach ($key in $InstallationParametersOfSwSetComponents.Keys) {
					$Webrequest.InstallationParametersOfSwSetComponents += New-Object $DSM7Types["SwSetComponentInstallationParameters"]
					$Webrequest.InstallationParametersOfSwSetComponents[$i].SwInstallationParameters = $InstallationParametersOfSwSetComponents[$key]
					$Webrequest.InstallationParametersOfSwSetComponents[$i].SwSetComponentObjectId = $key
					$i++
				} 
			} 
		}
		$Webresult = $DSM7WebService.UpdatePolicy($Webrequest)
		if ($Stats) {
			write-log 0 "Anzahl betroffener Instanzen: $($Webresult.NumberOfInstancesAffected)." $MyInvocation.MyCommand 
			write-log 0 "Anzahl geupdateter Instanzen: $($Webresult.NumberOfInstancesUpdated)." $MyInvocation.MyCommand 
		}
		$global:DSM7AsynchronousExecution = $Webresult.AsynchronousExecution
		$global:DSM7InfrastructureTaskGuid = $Webresult.InfrastructureTaskGuid
		return $Webresult.UpdatedPolicy 
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Update-DSM7Policy {
	<#
	.SYNOPSIS
		aendert ein Policy Object aus.
	.DESCRIPTION
		aendert ein Policy Object aus.
	.EXAMPLE
		Update-DSM7Policy -ID xxx -PolicyRestrictionList (yyy,zzz) -PolicyRestrictionType Include -IsActiv
	.EXAMPLE
		Update-DSM7Policy -SwUniqueID "{A42DB21A-D859-4789-BD1C-FC5B5C61EA27}" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
	.EXAMPLE
		Update-DSM7Policy -SwName "Software" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
	.EXAMPLE
		Update-DSM7Policy -SwName "Software" -IsActiv -SwInstallationParams ("BootEnvironmentType=1234","UILanguage=en-us")
	.EXAMPLE
		Update-DSM7Policy -SwName "Software" -IsActiv -InstanceActivationMode AutoActivateOnce  -InstanceActivationOnCreate CreateInactive
	.EXAMPLE
		Update-DSM7Policy -SwName "Software" -IsActiv -UpdatePackage -CriticalUpdate -DeactivateUpdatedInstances -RemoveInstanceInstallationParameters
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
		[Parameter(Position = 0, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$SwName,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$SwUniqueID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.array]$SwInstallationParams,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.int32]$TargetId,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.int32]$TargetParentContID,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position = 6, Mandatory = $false)]
		[switch]$IsActiv = $false,
		[Parameter(Position = 7, Mandatory = $false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position = 8, Mandatory = $false)]
		[system.string]$Parameter,
		[ValidateSet("Include", "Exclude", "None")]
		[Parameter(Position = 9, Mandatory = $false)]
		[system.string]$PolicyRestrictionType,
		[Parameter(Position = 10, Mandatory = $false)]
		[system.array]$PolicyRestrictionList,
		[Parameter(Position = 11, Mandatory = $false)]
		[switch]$UpdatePackage,
		[Parameter(Position = 12, Mandatory = $false)]
		[switch]$CriticalUpdate,
		[Parameter(Position = 13, Mandatory = $false)]
		[switch]$DeactivateUpdatedInstances,
		[Parameter(Position = 14, Mandatory = $false)]
		[switch]$RemoveInstanceInstallationParameters,
		[Parameter(Position = 15, Mandatory = $false)]
		[ValidateSet("CreateActive", "CreateInactive")]
		[System.String]$InstanceActivationOnCreate = 0,
		[Parameter(Position = 16, Mandatory = $false)]
		[ValidateSet("AutoActivateAlways", "AutoActivateOnce", "DontAutoactivate")]
		[system.string]$InstanceActivationMode = "DontAutoactivate",
		[Parameter(Position = 17, Mandatory = $false)]
		[switch]$Stats
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
				$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
				if ($TargetObject -and $AssignedObject) {
					Write-Log 0 "($($AssignedObject.Name)) und ($TargetName) gefunden." $MyInvocation.MyCommand
					$Policys = Convert-DSM7PolicyListtoPSObject(Get-DSM7PolicyListByAssignedSoftwareObject -ID $AssignedObject.ID) | Select-Object ID -ExpandProperty TargetObjectList | where { $_.TargetObjectID -eq $TargetObject.ID }
					if ($Policys.count -gt 1) {
						Write-Log 1 "Mehere Policys($($Policys.count)) gefunden!!! Bitte ID benutzen." $MyInvocation.MyCommand
					}
					else { 
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
					if ($SwInstallationParams) {

						$SwSetComponentInstallationParameters = @{}
						if ($AssignedObject.SchemaTag -eq "OSSoftwareSet" -or $AssignedObject.SchemaTag -eq "eScriptSoftwareSet" ) {
							$PolicyList = Get-DSM7PolicyListByTarget -ID $policy.TargetObjectList[0].TargetObjectID
							$PolicyListComponentIds = $PolicyList | where { $_.'SwSetComponentPolicy.ParentPolicyId' -eq $Policy.ID } | select -ExpandProperty ID
							$PolicyListObjects = Get-DSM7PoliciesObject -IDs $PolicyListComponentIds
							foreach ($PolicyListObject in $PolicyListObjects) {
								$i = 0
								foreach ($SwInstallationParam in $SwInstallationParams) {
									$ValueName = $SwInstallationParam.split("=", 2)[0]
									$ValueValue = $SwInstallationParam.split("=", 2)[1]
									$policyparam = $PolicyListObject.swinstallationparameters | where { $_.Tag -eq $ValueName }
									if ($policyparam) {
										$policyparam.Value = $ValueValue
										$SwSetComponentInstallationParameters[$PolicyListObject.ID] += $policyparam
										Write-Log 0 "Parameter ($ValueName=$ValueValue) geaendert." $MyInvocation.MyCommand
										$i++
									}
								}
							}
						}
						else {
							foreach ($SwInstallationParam in $SwInstallationParams) {
								$ValueName = $SwInstallationParam.split("=", 2)[0]
								$ValueValue = $SwInstallationParam.split("=", 2)[1]
								$policyparam = $policy.swinstallationparameters | where { $_.Tag -eq $ValueName }
								$policyparam.Value = $ValueValue
								Write-Log 0 "Parameter ($ValueName=$ValueValue) geaendert." $MyInvocation.MyCommand

							}
						}
					} 
					if ($Policy.IsActive -and $ActivationStartDate) {
						$Policy.IsActive = $false
						$Policy = Update-DSM7PolicyObject -Policy $Policy 
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
					if ($PolicyListObjects) {
						foreach ($PolicyListObject in $PolicyListObjects) {
							$PolicyListObject = Update-DSM7PolicyObject -Policy $PolicyListObject
						}
					}
					if ($UpdatePackage) {
						if ($AssignedObject.'Software.IsLastReleasedRev') {
							Write-Log 0 "$($AssignedObject.Name) auf ($($TargetObject.Name)) ist schon letzte Revision." $MyInvocation.MyCommand
						}
						else {
							$newAssignedObject = Get-DSM7Software -UniqueID $AssignedObject.UniqueID -IsLastReleasedRev
							$Policy.AssignedObjectID = $newAssignedObject.ID
							$PolicyOptions = New-Object $DSM7Types["PolicyUpdateOptions"]
							if ($CriticalUpdate) {
								$PolicyOptions.Criticality = "CriticalUpdate"
							}
							else {
								$PolicyOptions.Criticality = "NonCriticalUpdate"
							}
							$PolicyOptions.DeactivateUpdatedInstances = $DeactivateUpdatedInstances
							$PolicyOptions.RemoveInstanceInstallationParameters = $RemoveInstanceInstallationParameters
						}
					}
					$Policy.InstanceActivationMode = $InstanceActivationMode
					$Policy.InstanceActivationOnCreate = $InstanceActivationOnCreate
					$Policy = Update-DSM7PolicyObject -Policy $Policy -InstallationParametersOfSwSetComponents $SwSetComponentInstallationParameters -Options $PolicyOptions -Stats:$Stats
					if ($Policy) {
						$Policy = Convert-DSM7PolicytoPSObject ($Policy) -resolvedName
						Write-Log 0 "$($AssignedObject.Name) auf ($($TargetObject.Name)) erfolgreich geaendert." $MyInvocation.MyCommand
						return $Policy
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
		catch [system.exception] {
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
		Write-Log 0 "$($PolicyTarget.ID) erfolgreich hinzugefuegt." $MyInvocation.MyCommand
		return $Webresult
	}
	catch [system.exception] {
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
	catch [system.exception] {
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7PolicyList


function Move-DSM7PolicyToTarget {
	<#
	.SYNOPSIS
		aendert ein Policy Object aus.
	.DESCRIPTION
		aendert ein Policy Object aus.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[int]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.int32]$TargetParentContID,
		[switch]$ForceRemove = $false

	)
	if (Confirm-Connect) {
		try {
			$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
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
				if ($result) {
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Move-DSM7PolicyToTarget
function Remove-DSM7PolicyFromTarget {
	<#
	.SYNOPSIS
		aendert ein Policy Object aus.
	.DESCRIPTION
		aendert ein Policy Object aus.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[int]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.int32]$TargetParentContID,
		[switch]$ForceRemove = $false

	)
	if (Confirm-Connect) {
		try {
			$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
			if ($TargetObject) {
				Write-Log 0 "($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
				$Policy = Get-DSM7PolicyObject -ID $ID
				if ($Policy.TargetObjectList.Count -le 1 -and $Policy.TargetObjectList[0].TargetObjectID -ne $TargetObject.ID) {
					$result = Remove-DSM7PolicyObject -Policy $Policy -ForceDelete
				}
				else {
					$RemoveObject = Get-DSM7ObjectObject -ID $TargetObject.ID
					$RemovePolicy = Get-DSM7PolicyObject -ID $ID
					$result = Remove-DSM7TargetFromPolicyObject -Policy $RemovePolicy -PolicyTarget $RemoveObject -ForceRemove:$ForceRemove

				}
				if ($result) {
					Write-Log 0 "Policy erfolgreich von ($($TargetObject.Name)) entfernt." $MyInvocation.MyCommand
					return $true
				}
				else {
					Write-Log 1 "Ziele nicht entfernt." $MyInvocation.MyCommand
					return $false 
				}
			}
			else {
				Write-Log 1 "($TargetName) nicht gefunden." $MyInvocation.MyCommand
				return $false 
			}
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Remove-DSM7PolicyFromTarget
function Add-DSM7PolicyToTarget {
	<#
	.SYNOPSIS
		Fuegt eine Policy einem Object zu.
	.DESCRIPTION
		Fuegt eine Policy einem Object zu.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[int]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetParentContID

	)
	if (Confirm-Connect) {
		try {
			$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
			if ($TargetObject) {
				$Policy = Get-DSM7PolicyObject -ID $ID
				Write-Log 0 "($ID) und ($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
				$result = Add-DSM7TargetToPolicyObject -Policy $Policy -PolicyTarget $TargetObject 
				if ($result) {
					Write-Log 0 "Policy Ziel ($TargetName) hinzugefuegt." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
		New-DSM7Policy -UpdateID "ARDC-210215:AcroRdrDCUpd2100120138.msp:Adobe Acrobat Reader DC 21:0407" -TargetName "Ziel" -IsActiv
	.EXAMPLE
		New-DSM7Policy -swid 12345 -TargetID 54321 -IsActiv -SwInstallationParams ("BootEnvironmentType=1234","UILanguage=en-us")
	.EXAMPLE
		New-DSM7Policy -IsActiv -TargetID 54321 -SwUniqueID "{4F3BB3DB-F1F3-4ACA-A7B6-F8CA57FD20F1}" -JobPolicy -JobPolicyTrigger 10
	.EXAMPLE
		New-DSM7Policy -IsActiv -TargetID 54321 -SwUniqueID "{D4128974-088B-4395-B326-5A9DBBCE9DFD}" -DenyPolicy
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$SwName,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$SwID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$SwUniqueID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$SwUpdateID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.array]$SwInstallationParams,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.int32]$TargetParentContID,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.int32]$Priority = 1000,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.int32]$MaintenanceBehavior = 2,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.int32]$WakeUpTimeSpan = 240,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.int32]$MaxPreStagingTime = 365,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.int32]$MinPreStagingTime = 365,
		[Parameter(Position = 6, Mandatory = $false)]
		[switch]$IsActiv = $false,
		[Parameter(Position = 7, Mandatory = $false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position = 8, Mandatory = $false)]
		[switch]$IsUserPolicyCurrentComputer = $false,
		[Parameter(Position = 9, Mandatory = $false)]
		[switch]$IsUserPolicyAllassociatedComputer = $false,
		[Parameter(Position = 10, Mandatory = $false)]
		[switch]$JobPolicy = $false,
		[Parameter(Position = 10, Mandatory = $false)]
		[system.int32]$JobPolicyTrigger = 0,
		[Parameter(Position = 10, Mandatory = $false)]
		[switch]$DenyPolicy = $false,
		[Parameter(Position = 10, Mandatory = $false)]
		[switch]$Pilot = $false,
		[Parameter(Position = 11, Mandatory = $false)]
		[ValidateSet("CreateActive", "CreateInactive")]
		[System.String]$InstanceActivationOnCreate = "CreateActive",
		[Parameter(Position = 12, Mandatory = $false)]
		[ValidateSet("AutoActivateAlways", "AutoActivateOnce", "DontAutoactivate")]
		[system.string]$InstanceActivationMode = "DontAutoactivate",
		[Parameter(Position = 13, Mandatory = $false)]
		[switch]$Stats

	)
	if (Confirm-Connect) {
		try {
			$NoPolicy = $false
			if ($SwName) {
				if ($Pilot) {
					$AssignedObject = Get-DSM7Software -Name $SwName -LDAPPath $SwLDAPPath
				}
				else {
					$AssignedObject = Get-DSM7Software -Name $SwName -LDAPPath $SwLDAPPath -IsLastReleasedRev
				}
			}
			if ($SwUniqueID) {
				if ($Pilot) {
					$AssignedObject = Get-DSM7Software -UniqueID $SwUniqueID
				}
				else {
					$AssignedObject = Get-DSM7Software -UniqueID $SwUniqueID -IsLastReleasedRev
				}
			}
			if ($SwUpdateID) {
				if ($Pilot) {
					$AssignedObject = Get-DSM7Software -UpdateID $SwUpdateID
				}
				else {
					$AssignedObject = Get-DSM7Software -UpdateID $SwUpdateID -IsLastReleasedRev
				}
			}
			if ($SwID) {
				$AssignedObject = Get-DSM7Software -ID $SwID
			}
			if ($AssignedObject) {
				$DSMSwSetIds = Get-DSM7AssociationList -SchemaTag "SwSetComponents" -SourceObjectID $AssignedObject.ID | select -ExpandProperty TargetObjectID
				if ($DSMSwSetIds) {
					Write-Log 0 "Software ist ein Set." $MyInvocation.MyCommand
					$DSMInstallationParamDefinitions = @{}
					foreach ($DSMSwSetId in $DSMSwSetIds) {
						$DSMSoftware = Get-DSM7ObjectObject -ID $DSMSwSetId
						$DSMInstallationParamDefinitions[$DSMSwSetId] = Get-DSM7SwInstallationParamDefinitionsObject $DSMSoftware
						$DSMTestnoValue = $DSMInstallationParamDefinitions[$DSMSwSetId] | where { $_.IsMandatory -and !$_.DefaultValue }
						if ($DSMTestnoValue -and !$SwInstallationParams -and !$SwSetComponentPolicyIDs) {
							Write-Log 1 "Es kann keine Policy erstellt, es fehlen folgende Parameter: ($($DSMTestnoValue|select Tag))!!!" $MyInvocation.MyCommand
							return $false 
						}

					}
					if ($SwInstallationParams) {
						$SwSetComponentInstallationParameters = @{}
						foreach ($key in $DSMInstallationParamDefinitions.Keys) {
							$i = 0
							foreach ($SwInstallationParam in $SwInstallationParams) {
								$ValueName = $SwInstallationParam.split("=", 2)[0]
								$ValueValue = $SwInstallationParam.split("=", 2)[1]
								$DSMInstallationParamDefinition = $DSMInstallationParamDefinitions[$key] | where { $_.Tag -eq $ValueName }
								if ($DSMInstallationParamDefinition) {
									$SwSetComponentInstallationParameters[$key] += New-Object $DSM7Types["MdsSWInstallationParam"]
									$SwSetComponentInstallationParameters[$key][$i].Tag = $DSMInstallationParamDefinition.Tag
									$SwSetComponentInstallationParameters[$key][$i].SwInstallationParamDefID = $DSMInstallationParamDefinition.ID
									$SwSetComponentInstallationParameters[$key][$i].Type = "SwInstallationConfiguration"
									$SwSetComponentInstallationParameters[$key][$i].Value = $ValueValue
									$i++
								}
							}
						}
					}
				}
				$DSMInstallationParamDefinitions = Get-DSM7SwInstallationParamDefinitionsObject (Get-DSM7ObjectObject -ID $AssignedObject.ID)
				$DSMTestnoValue = $DSMInstallationParamDefinitions | where { $_.IsMandatory -and !$_.DefaultValue }
				if ($DSMTestnoValue -and !$SwInstallationParams -and !$DenyPolicy) {
					Write-Log 1 "Es kann keine Policy erstellt, es fehlen folgende Parameter: ($($DSMTestnoValue|select Tag))!!!" $MyInvocation.MyCommand
					return $false 
				}
				if ($SwInstallationParams) {
					$SwInstallationParameters = @{}
					$i = 0
					foreach ($SwInstallationParam in $SwInstallationParams) {
						$ValueName = $SwInstallationParam.split("=", 2)[0]
						$ValueValue = $SwInstallationParam.split("=", 2)[1]
						$DSMInstallationParamDefinition = $DSMInstallationParamDefinitions | where { $_.Tag -eq $ValueName }
						if ($DSMInstallationParamDefinition) {
							$Raw = New-Object PSObject
							add-member -inputobject $Raw -MemberType NoteProperty -name Id -Value $DSMInstallationParamDefinition.ID
							add-member -inputobject $Raw -MemberType NoteProperty -name Tag -Value $DSMInstallationParamDefinition.Tag
							add-member -inputobject $Raw -MemberType NoteProperty -name Value -Value $ValueValue
							add-member -inputobject $Raw -MemberType NoteProperty -name Type -Value $DSMInstallationParamDefinition.InstallationParamType
							$SwInstallationParameters[$($DSMInstallationParamDefinition.ID)] = $Raw
						}
					}
				}
				if ($SwSetComponentPolicyIDs) {
					$SwSetComponentInstallationParameters = @{}
					$i = 0
					foreach ($SwSetComponentPolicyID in $SwSetComponentPolicyIDs) {
						$SwSetComponentPolicy = Get-DSM7PolicyObject -ID $SwSetComponentPolicyID 
						if ($SwSetComponentPolicy.SwInstallationParameters) {
							$SwSetComponentInstallationParameters[$($SwSetComponentPolicy.AssignedObjectID)] = $SwSetComponentPolicy.SwInstallationParameters
						}
					}

				}
				$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
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
						"VMWPPatchPackage" { $SchemaTag = "PatchPolicy" }
						"MSWUV6Package" { $SchemaTag = "PatchPolicy" }
						"LPRPatchPackage" { $SchemaTag = "PatchPolicy" }
						"PnpPackage" { $SchemaTag = "PnpPolicy" }
						default { $SchemaTag = "SwPolicy" }
					}
					switch ($AssignedObject."Software.ReleaseStatus") {
						0 { $StagingMode = "InstallationTest" }
						1 { $StagingMode = "Standard" }
						2 { $NoPolicy = $true }
						default { $StagingMode = "Standard" }
					}
					if ($NoPolicy) {
						Write-Log 1 "Es kann keine Policy erstellt werden Paket ist zurueckgezogen!!!" $MyInvocation.MyCommand
					}
					else {
						Write-Log 0 "($($AssignedObject.Name)) und ($($TargetObject.Name)) gefunden." $MyInvocation.MyCommand
						$Policy = New-Object $DSM7Types["MdsPolicy"]
						$Policy.SchemaTag = $SchemaTag
						$Policy.Priority = $Priority
						$Policy.WakeUpTimeSpan = $WakeUpTimeSpan
						$Policy.MaxPreStagingTime = $MaxPreStagingTime
						$Policy.MinPreStagingTime = $MinPreStagingTime
						$Policy.MaintenanceBehavior = $MaintenanceBehavior
						if ($JobPolicy) {
							$Policy.SchemaTag = "JobPolicy"
							$PropertyList = @()
							$PropertyListObject = New-Object $DSM7Types["MdsTypedPropertyOfString"]
							$PropertyListObject.Tag = "JobTrigger"
							$PropertyListObject.Type = "Option"
							$PropertyListObject.TypedValue = $JobPolicyTrigger
							$PropertyList += $PropertyListObject
							$PropGroupListObject = New-Object $DSM7Types["MdsPropGroup"]
							$PropGroupListObject.Tag = "JobPolicy"
							$PropGroupListObject.PropertyList = $PropertyList
							$PropGroupList += $PropGroupListObject
							$Policy.PropGroupList = $PropGroupList
							$Policy.InstallationOrder = $AssignedObject.'Software.InstallationOrder'
						}
						if ($SchemaTag = "PatchPolicy") {
							$Policy.ShopForAllUsers = $true
						}
						if ($DenyPolicy) {
							$Policy.SchemaTag = "DenyPolicy"
							$Policy.ShopForAllUsers = $true
							$Policy.MaintenanceBehavior = 0
							$Policy.WakeUpTimeSpan = 240
							$Policy.MaxPreStagingTime = 365
							$Policy.MinPreStagingTime = 365
							$Policy.Priority = -2147483648
						}
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
						$Policy.InstanceActivationMode = $InstanceActivationMode
						$Policy.InstanceActivationOnCreate = $InstanceActivationOnCreate

						$result = New-DSM7PolicyObject -NewPolicy $Policy -PolicyTarget $PolicyTarget -SwInstallationParam $SwInstallationParameters -InstallationParametersOfSwSetComponents $SwSetComponentInstallationParameters -Stats:$Stats
						if ($result) {
							$result = Convert-DSM7PolicytoPSObject ($result) -resolvedName
							if ($result) {
								Write-Log 0 "Neue Policy ($($result.ID)) mit Ziel ($($TargetObject.Name)) erstellt." $MyInvocation.MyCommand
							}
							else {
								Write-Log 1 "Keine neue Policy mit Ziel ($($TargetObject.Name)) erstellt!!!" $MyInvocation.MyCommand
							}
							return $result
						}
						else {
							Write-Log 2 "Keine neue Policy mit Ziel ($($TargetObject.Name)) erstellt!!!" $MyInvocation.MyCommand
							return $false 
						}
					}
				}
				else {
					Write-Log 1 "Ziel ($TargetName$TargetID) nicht gefunden." $MyInvocation.MyCommand
					return $false 
				}
			}

			else {
				Write-Log 1 "($SwName$SwUniqueID$SwID) nicht gefunden." $MyInvocation.MyCommand
				return $false 

			} 
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function New-DSM7Policy

function Copy-DSM7Policy {
	<#
	.SYNOPSIS
		Kopiert ein Policy zu einem neuem Ziel.
	.DESCRIPTION
		Kopiert ein Policy zu einem neuem Ziel.
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.Int32]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetParentContID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.array]$SwSetComponentPolicyIDs,
		[Parameter(Position = 5, Mandatory = $false)]
		[switch]$IsActiv = $false,
		[Parameter(Position = 6, Mandatory = $false)]
		[switch]$IsUserPolicy = $false,
		[Parameter(Position = 7, Mandatory = $false)]
		[switch]$IsUserPolicyCurrentComputer = $false,
		[Parameter(Position = 8, Mandatory = $false)]
		[switch]$IsUserPolicyAllassociatedComputer = $false,
		[Parameter(Position = 9, Mandatory = $false)]
		[switch]$JobPolicy = $false,
		[Parameter(Position = 10, Mandatory = $false)]
		[switch]$Stats


	)
	if (Confirm-Connect) {
		try {
			$NoPolicy = $false
			$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
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
				$Policy = Get-DSM7PolicyObject -ID $ID
				if ($Policy.SchemaTag -ne "SwSetComponentPolicy") {
					if ($SwSetComponentPolicyIDs) {
						$SwSetComponentInstallationParameters = @{}
						$i = 0
						foreach ($SwSetComponentPolicyID in $SwSetComponentPolicyIDs) {
							$SwSetComponentPolicy = Get-DSM7PolicyObject -ID $SwSetComponentPolicyID 
							if ($SwSetComponentPolicy.SwInstallationParameters) {
								$SwSetComponentInstallationParameters[$($SwSetComponentPolicy.AssignedObjectID)] = $SwSetComponentPolicy.SwInstallationParameters
							}
						}

					}
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

					$result = New-DSM7PolicyObject -NewPolicy $Policy -PolicyTarget $PolicyTarget -InstallationParametersOfSwSetComponents $SwSetComponentInstallationParameters -Stats:$Stats
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
					Write-Log 1 "Keine neue Policy erstellt, Policy ist Komponente!" $MyInvocation.MyCommand
					return $true
				}
			}
			else {
				Write-Log 1 "Kein Ziel gefunden!!!" $MyInvocation.MyCommand

			}
		}
		catch [system.exception] {
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
		$SwInstallationParam,
		$InstallationParametersOfSwSetComponents,
		[switch]$Stats
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "CreatePolicy"
		if ($DSM7Version -gt "7.3.0") {
			$Webrequest.PolicyToCreate = New-Object $DSM7Types["PolicyToManage"]
			$Webrequest.PolicyToCreate.Policy = $NewPolicy
			$Webrequest.PolicyToCreate.Policy.TargetObjectList = $PolicyTarget
			if ($SWInstallationParam) {
				$i = 0
				foreach ($key in $SwInstallationParam.Keys) {

					$Webrequest.PolicyToCreate.Policy.SwInstallationParameters += New-Object $DSM7Types["MdsSWInstallationParam"]
					$Webrequest.PolicyToCreate.Policy.SwInstallationParameters[$i].Tag = $SwInstallationParam[$key].Tag
					$Webrequest.PolicyToCreate.Policy.SwInstallationParameters[$i].SwInstallationParamDefID = $key
					$Webrequest.PolicyToCreate.Policy.SwInstallationParameters[$i].Type = "SwInstallationConfiguration"
					$Webrequest.PolicyToCreate.Policy.SwInstallationParameters[$i].Value = $SwInstallationParam[$key].Value
					$i++
				}

			}
			if ($InstallationParametersOfSwSetComponents) {
				$i = 0
				foreach ($key in $InstallationParametersOfSwSetComponents.Keys) {
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents += New-Object $DSM7Types["SwSetComponentInstallationParameters"]
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents[$i].SwInstallationParameters = $InstallationParametersOfSwSetComponents[$key]
					$Webrequest.PolicyToCreate.InstallationParametersOfSwSetComponents[$i].SwSetComponentObjectId = $key
					$i++
				} 
			} 
			if ($DSM7Version -gt "7.4.0") {
				$Webrequest.PolicyToCreate.Policy.GenTypeData = new-object $DSM7Types["MdsGenType"]
				$CreationSource = $MyInvocation.MyCommand.Module.Name
				if ($DSM7CreationSource) { $CreationSource = $DSM7CreationSource }
				$Webrequest.PolicyToCreate.Policy.GenTypeData.CreationSource = $CreationSource
			}
		}
		else {
			$Webrequest.NewPolicy = $NewPolicy
			$Webrequest.NewPolicy.TargetObjectList = $PolicyTarget
			$Webrequest.InstallationParametersOfSwSetComponents = $InstallationParametersOfSwSetComponents
		}
		$Webresult = $DSM7WebService.CreatePolicy($Webrequest)
		if ($Stats) {
			write-log 0 "Anzahl erstellter Instanzen: $($Webresult.NumberOfInstancesCreated)." $MyInvocation.MyCommand 
			write-log 0 "Anzahl Instanzen mit nicht gueltigen Voraussetzungen: $($Webresult.NumberOfInstancesFailingPrerequisite)." $MyInvocation.MyCommand 
			write-log 0 "Anzahl ungueltiger Instanzen: $($Webresult.NumberOfInvalidInstances)." $MyInvocation.MyCommand 
		}
		$global:DSM7AsynchronousExecution = $Webresult.AsynchronousExecution
		$global:DSM7InfrastructureTaskGuid = $Webresult.InfrastructureTaskGuid

		return $Webresult.CreatedPolicy
	}
	catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Remove-DSM7Policy {
	<#
	.SYNOPSIS
		Luescht die Policy.
	.DESCRIPTION
		Loescht die Policy.
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$SwName,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$SwUniqueID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$SwLDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.int32]$TargetID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 4, Mandatory = $false)]
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
			$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
			if (($TargetObject -and $AssignedObject) -or $ID) {
				if (!$ID) {
					$Policys = Convert-DSM7PolicyListtoPSObject(Get-DSM7PolicyListByAssignedSoftwareObject -ID $AssignedObject.ID) | Select-Object ID -ExpandProperty TargetObjectList | where { $_.TargetObjectID -eq $TargetObject.ID }
					if ($Policys.count -gt 1) {
						Write-Log 1 "Mehere Policys($($Policys.count)) gefunden!!! Bitte ID benutzen." $MyInvocation.MyCommand
					}
					else { 
						$ID = $Policys.ID
					}
				}
				if ($ID) {
					$result = Get-DSM7PolicyObject -ID $ID
					if ($result) {
						$result = Remove-DSM7PolicyObject -Policy $result -ForceDelete:$ForceDelete -DeleteAssociatedPolicies:$DeleteAssociatedPolicies
						Write-Log 0 "$($AssignedObject.Name) auf ($($TargetObject.Name)) erfolgreich geloescht." $MyInvocation.MyCommand
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
		catch [system.exception] {
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
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
		catch [system.exception] {
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
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[switch]$resolvedName
	)
	if (Confirm-Connect) {
		try {
			if ($Name -or $ID -gt 0) {
				$Object = Find-DSM7Target -ID $ID -Name $Name -LDAPPath $LDAPPath -ParentContID $ParentContID
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
		catch [system.exception] {
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
		Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -TargetName "Name" -TargetLDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -TargetName "Name" -TargetLDAPPath "Managed Users & Computers/OU1" -ExtentionName "Name" -ExtentionLDAPPath "Managed Users & Computers/OU1"
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -ID 1234 -TargetID 1235
	.EXAMPLE
		Copy-DSM7PolicyListNewTarget -ID 1234 -TargetID 1235 -ExtentionID 1236
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$TargetName,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$TargetLDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.int32]$TargetParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ExtentionID,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ExtentionName,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ExtentionLDAPPath,
		[Parameter(Position = 17, Mandatory = $false)]
		[switch]$Stats

	)
	if (Confirm-Connect) {
		try {
			$SourceObject = Find-DSM7Target -ID $ID -Name $Name -LDAPPath $LDAPPath -ParentContID $ParentContID

			if ($SourceObject.count -gt 1) {
				Write-Log 1 "($Name) -> ($LDAPPath) nicht eindeutig." $MyInvocation.MyCommand
				return $false
			}
			else {
				[Array]$SourcePolicy = Get-DSM7PolicyListByTarget -ID $SourceObject.ID
				if ($SourcePolicy) {
					Write-Log 0 "($Name) -> ($LDAPPath) erfolgreich." $MyInvocation.MyCommand
					$TargetObject = Find-DSM7Target -ID $TargetID -Name $TargetName -LDAPPath $TargetLDAPPath -ParentContID $TargetParentContID
					if (!$TargetObject) {
						if ($TargetLDAPPath -or $TargetParentContID) {
							if (!$TargetParentContID) {
								$TargetParentContID = Get-DSM7LDAPPathID -LDAPPath $TargetLDAPPath
							}
						}
						else {
							$TargetParentContID = $SourceObject.ParentContID
						}
						$TargetObject = New-DSM7Object -Name $TargetName -ParentContID $TargetParentContID -SchemaTag $SourceObject.SchemaTag -GroupType $SourceObject.GroupType -PropGroupList $SourceObject.PropGroupList
						Write-Log 0 "($TargetName) -> ($LDAPPath) erfolgreich erstellt." $MyInvocation.MyCommand
					}
					if ($TargetObject.count -gt 1) {
						Write-Log 1 "Ziel $TargetName nicht erstellt/oder nicht eindeutig!" $MyInvocation.MyCommand
						return $false
					}
					else {
						Write-Log 0 "($($TargetObject.Name)) -> erfolgreich ermittelt." $MyInvocation.MyCommand
						$PolicylistTarget = Get-DSM7PolicyListByTarget -ID $TargetObject.ID
						$I = 0
						$J = 0
						$K = $SourcePolicy.Count - ($SourcePolicy | where { $_.SchemaTag -eq "SwSetComponentPolicy" }).Count
						if ($ExtentionID -or $ExtentionName) {
							if ($ExtentionID -le 1) {
								$PolicylistExtention = Get-DSM7PolicyListByTarget -Name $ExtentionName -LDAPPath $ExtentionLDAPPath
							}
							else {
								$PolicylistExtention = Get-DSM7PolicyListByTarget -ID $ExtentionID
							}
						}
						foreach ($Policy in $SourcePolicy) {
							$SWSetIDs = @()
							if ($Policy.AssignedObjectSchemaTag -like "*Set") {
								$SWSetIDs = $SourcePolicy | where { $_.'SwSetComponentPolicy.ParentPolicyId' -eq $Policy.ID } | select -ExpandProperty ID
							}
							$PolicyTarget = New-Object $DSM7Types["MdsPolicyTarget"]
							$PolicyTarget.TargetObjectID = $TargetObject.ID
							$PolicyTarget.TargetSchemaTag = $TargetObject.SchemaTag
							$IDTarget = $($PolicylistTarget | where { $_.AssignedObjectUniqueID -eq $($Policy.AssignedObjectUniqueID) }).ID 
							if ($IDTarget -gt 0 -and $Policy.SchemaTag -ne "SwSetComponentPolicy") {
								Write-Log 0 "Paket ($($Policy.AssignedObjectName)) ist schon zugewiesen." $MyInvocation.MyCommand
								$J++ 
       }
							elseif ($Policy.SchemaTag -ne "SwSetComponentPolicy") {
								$ID = $($PolicylistExtention | where { $_.AssignedObjectUniqueID -eq $($Policy.AssignedObjectUniqueID) }).ID 
								if ($ID -gt 0) {
									$result = Add-DSM7PolicyToTarget -ID $ID -TargetID $TargetObject.ID

								}
								else {
									$result = Copy-DSM7Policy -ID $Policy.ID -TargetID $TargetObject.ID -IsActiv:$Policy.IsActive -SwSetComponentPolicyIDs $SWSetIDs -Stats:$Stats
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
						if ($I -eq $K) {
							Write-Log 0 "Alle Policys erstellt! $I Policy(s) erstellt." $MyInvocation.MyCommand
							return $true
						}
						else {
							Write-Log 1 "Nicht alle Policys neu erstellt! $I von $K erstellt, $J waren schon vorhahen." $MyInvocation.MyCommand
							return $true
						}
					}
				}
				else {
					Write-Log 1 "Konnte kein Object finden!" $MyInvocation.MyCommand
					return $false
				}
			}
		}
		catch [system.exception] {
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
		$Webresult = $DSM7WebService.GetPolicyStatisticsByTarget($Webrequest).ComplianceStatisticResults
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatisticsByTarget {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Software zurueck.
	.DESCRIPTION
		Gibt eine Statistik von einer Software zurueck.
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatistics {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Policy zurueck.
	.DESCRIPTION
		Gibt eine Statistik von einer Policy zurueck.
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyStatisticsByPolicies {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Software zurueck.
	.DESCRIPTION
		Gibt eine Statistik von einer Software zurueck.
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
		[Parameter(Position = 0, Mandatory = $true)]
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
		Gibt die festgestellten Sicherheitsluecken zurueck.
	.DESCRIPTION
		Gibt die festgestellten Sicherheitsluecken zurueck.
	.EXAMPLE
		Get-DSM7ComputerMissingPatch -Name "Computername"
	.NOTES
	.LINK
		Get-DSM7ComputerMissingPatch
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $false)]
		[int32]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Name
	)
	if (Confirm-Connect) {
		try {
			if ($ID -lt 1) {
				$ID = $(Get-DSM7Computer -Name $Name).ID
			}
			else {
				$Name = $(Get-DSM7Computer -ID $ID).Name 
   }
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
					$result = Get-DSM7SoftwareIDs -IDs $IDs
					return $result
				}
				else {
					Write-Log 1 "($Name) keine Sicherheitsluecken vorhanden!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "($Name$ID) nicht erfolgreich!" $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] {
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
		[system.string]$ID,
		[system.string]$ComplianceState
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstanceCountByPolicy"
		$Webrequest.PolicyId = $ID
		if ($ComplianceState) {
			$Webrequest.FilterCriteria = New-Object $DSM7Types["PolicyInstanceFilterCriteria"] 
			$Webrequest.FilterCriteria.ComplianceStates = $ComplianceState
		}
		$Webresult = $DSM7WebService.GetPolicyInstanceCountByPolicy($Webrequest).NumberOfResults
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Get-DSM7PolicyInstanceCountByPolicy {
	<#
	.SYNOPSIS
		Gibt eine Statistik von einer Policy zurueck.
	.DESCRIPTION
		Gibt eine Statistik von einer Policy zurueck.
	.EXAMPLE
		Get-DSM7PolicyInstanceCountByPolicy -ID 123456 -ComplianceState Compliant 
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
		[Parameter(Position = 0, Mandatory = $true)] 
		[system.string]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[ValidateSet("Undefined", "Compliant", "NotCompliant", "CompliancePending", "NotPossible", "ClientSidePrerequisitesFailed")]
		[system.string]$ComplianceState
	)
	if (Confirm-Connect) {
		if ($ID -or $Name) {
			$result = Get-DSM7PolicyInstanceCountByPolicyObject -ID $ID -ComplianceState $ComplianceState
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PolicyInstanceListByNode {
	<#
	.SYNOPSIS
		Gibt eine Liste PolicyInstances von Objekten zurueck.
	.DESCRIPTION
		Gibt eine Liste PolicyInstances von Objekten zurueck.
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
function New-DSM7PolicyInstance {
	<#
	.SYNOPSIS
		Erstellt eine PolicyInstance.
	.DESCRIPTION
		Erstellt eine PolicyInstance.
	.EXAMPLE
		New-DSM7PolicyInstance -PolicyID 1234 -NodeId 1234
	.NOTES
	.LINK
		Get-DSM7PolicyInstanceCountByPolicy
	.LINK
		Get-DSM7PolicyInstanceListByNode
	.LINK
		Update-DSM7PolicyInstance
	#>	[CmdletBinding()] 
	param (
		[Parameter(Position = 0, Mandatory = $true)]
		[System.Int32]$PolicyID,
		[Parameter(Position = 1, Mandatory = $true)]
		[System.Int32]$NodeId
	)
	if (Confirm-Connect) {
		$Policy = Get-DSM7PolicyObject -ID $PolicyID
		if ($Policy.InstanceCreationMode -eq 1) {
			try {
				$Webrequest = Get-DSM7RequestHeader -action "CreatePolicyInstance"
				$Webrequest.Policy = $Policy
				$Webrequest.NodeId = $NodeId
				$Webresult = $DSM7WebService.CreatePolicyInstance($Webrequest).CreatedPolicyInstance 
				Write-Log 0 "PolicyInstance ($($Webresult.ID)) erfolgreich erstell für NodeID ($NodeID)." $MyInvocation.MyCommand
				return $Webresult
			}
			catch [system.exception] {
				Write-Log 2 $_ $MyInvocation.MyCommand 
				return $false 
			} 
		}
		Write-Log 1 "Policy InstanceCreationMode ($($Policy.InstanceCreationMode)) kann keine Instanz erstellt werden!" $MyInvocation.MyCommand
		return $false
	}
}
Export-ModuleMember -Function New-DSM7PolicyInstance
function Update-DSM7PolicyInstanceListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$PolicyInstanceList
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpdatePolicyInstanceList"
		$Webrequest.PolicyInstanceListToUpdate = $PolicyInstanceList
		$Webresult = $DSM7WebService.UpdatePolicyInstanceList($Webrequest).UpdatedPolicyInstanceList
		$policyInstanceIDs = $PolicyInstanceList | select -ExpandProperty PolicyID
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PolicyInstanceListByPolicyObject {
	[CmdletBinding()] 
	param ( 
		[system.string]$ID
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstanceListByPolicy"
		$Webrequest.PolicyId = $ID
		$Webresult = $DSM7WebService.GetPolicyInstanceListByPolicy($Webrequest).PolicyInstanceList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PolicyInstanceListByPolicy {
	<#
	.SYNOPSIS
		Gibt eine Liste PolicyInstances von Policys zurueck.
	.DESCRIPTION
		Gibt eine Liste PolicyInstances von Policys zurueck.
	.EXAMPLE
		Get-DSM7PolicyInstanceListByPolicy -ID 123456" 
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
		[system.string]$ID,
		[switch]$resolvedName = $false
	)
	if (Confirm-Connect) {
		if ($ID) {
			$result = Get-DSM7PolicyInstanceListByPolicyObject -ID $ID
			if ($result) {
				Write-Log 0 "PolicyInstances bei Policy $ID!" $MyInvocation.MyCommand 

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
Export-ModuleMember -Function Get-DSM7PolicyInstanceListByPolicy
function Get-DSM7PolicyInstancesObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetPolicyInstances"
		$Webrequest.PolicyInstanceIds = $IDs
		$Webresult = $DSM7WebService.GetPolicyInstances($Webrequest).PolicyInstanceList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PolicyInstances {
	<#
	.SYNOPSIS
		Liste PolicyInstances.
	.DESCRIPTION
		Liste PolicyInstances.
	.EXAMPLE
		Get-DSM7PolicyInstances -IDs 123456,123457
	.NOTES
	.LINK
		Get-DSM7PolicyInstances
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.array]$IDs
	)
	if (Confirm-Connect) {
		$result = Get-DSM7PolicyInstancesObject -IDs $IDs
		if ($result) {
			Write-Log 0 "PolicyInstances $IDs!" $MyInvocation.MyCommand 
			$result = Convert-DSM7PolicyInstanceListtoPSObject -resolvedName:$resolvedName $result 
			return $result
		}
		else {
			Write-Log 1 "Keine PolicyInstances vorhanden!" $MyInvocation.MyCommand 
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7PolicyInstances
function Remove-DSM7PolicyInstanceListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$Policy,
		[Parameter(Position = 1, Mandatory = $true)]
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Update-DSM7PolicyInstances {
	<#
	.SYNOPSIS
		aendert eine PolicyInstances.
	.DESCRIPTION
		aendert eine PolicyInstances.
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 12345,65141 -active 
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 12345,65141 -reinstall
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 12345,65141 -ActivationStartDate %date%
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 12345,65141 -deactivateuntilreinsall
	.EXAMPLE
		Update-DSM7PolicyInstances -ID 12345,65141 -uninstall
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
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$ActivationStartDate,
		[Parameter(Position = 2, Mandatory = $false)]
		[switch]$active,
		[Parameter(Position = 3, Mandatory = $false)]
		[switch]$deactivateuntilreinsall,
		[Parameter(Position = 4, Mandatory = $false)]
		[switch]$reinstall,
		[switch]$uninstall
	)
	if (Confirm-Connect) {
		$PolicyInstanceList = Get-DSM7PolicyInstancesObject -IDs $IDs
		if ($PolicyInstanceList) {
			foreach ($PolicyInstance in $PolicyInstanceList) {
				$PolicyInstance.IsActive = $active
				if ($active) {
					Write-Log 0 "Policy Instance aktiviert ID ($($PolicyInstance.ID))" $MyInvocation.MyCommand 
				}
				if ($deactivateuntilreinsall) {
					$PolicyInstance.IsActive = $false
					$PolicyInstance.InstanceActivationMode = "AutoactivateOnce"
					Write-Log 0 "Policy Instance deaktiviert bis zur Neuinstallation ID ($($PolicyInstance.ID))" $MyInvocation.MyCommand 
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
				if ($uninstall) {
					$PolicyInstance.RequestType = "UninstalledOnPurpose"
					$PolicyInstance.IsActive = $true
					$PolicyInstance.DesiredConfiguration = $null

					Write-Log 0 "Policy Instance uninstall ID ($($PolicyInstance.ID))" $MyInvocation.MyCommand 
				} 
				if ($ActivationStartDate) {
					$StartDate = $(Get-Date($ActivationStartDate)) 
					$StartDate = $StartDate + [System.TimeZoneInfo]::Local.BaseUtcOffset
					if ([System.TimeZoneInfo]::Local.IsDaylightSavingTime($StartDate)) {
						$StartDate = $StartDate + 36000000000
					}
					$PolicyInstance.ActivationStartDate = $StartDate
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
		Loescht eine PolicyInstance.
	.DESCRIPTION
		Loescht eine PolicyInstance.
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
		[Parameter(Position = 0, Mandatory = $true)]
		$ID
	)
	if (Confirm-Connect) {
		$PolicyInstance = Get-DSM7PolicyInstancesObject -IDs $ID
		$Policy = Get-DSM7PolicyObject -ID $PolicyInstance.PolicyID

		$result = Remove-DSM7PolicyInstanceListObject -Policy $Policy -PolicyInstance $PolicyInstance 
		if ($result) {
			Write-Log 0 "Policyinstance geloescht." $MyInvocation.MyCommand
			$result = $true
		}
		else {
			Write-Log 1 "Fehler beim Policyinstance geloeschen!" $MyInvocation.MyCommand
			$result = $false
		}
		return $result
	}
}
Export-ModuleMember -Function Remove-DSM7PolicyInstance
function Update-DSM7PolicyInstancesActive {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$ID
	)
	$policyInstancelist = Get-DSM7PolicyInstanceListByNode -ID $ID -resolvedName 
	$policyInstanceIDs = $policyInstancelist | where { $_.IsActive -eq $false } | select -ExpandProperty ID
	if ($policyInstanceIDs) {
		foreach ($ID in $policyInstanceIDs) {
			$PolicyName = $($policyInstancelist | where { $_.ID -eq $($ID) }).AssignedObjectName
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
		[Parameter(Position = 0, Mandatory = $true)]
		$NodeId
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "UpgradePolicyInstancesByNode"
		$Webrequest.NodeId = $NodeId
		$Webresult = $DSM7WebService.UpgradePolicyInstancesByNode($Webrequest).UpdatedPolicyInstanceList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7SwInstallationConfigurationsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		[Array]$IDs
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetSwInstallationConfigurations"
		$Webrequest.InstallationConfigurationIds = $IDs
		$Webresult = $DSM7WebService.GetSwInstallationConfigurations($Webrequest).InstallationConfigurations
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
Export-ModuleMember -Function Get-DSM7SwInstallationConfigurationsObject
###############################################################################
# DSM7 Funktionen - Software 
function Get-DSM7SoftwareIDs {
	<#
	.SYNOPSIS
		Gibt ein Software Objekte zurueck.
	.DESCRIPTION
		Gibt ein Software Objekte zurueck.
	.EXAMPLE
		Get-DSM7SoftwareIDs -IDs 12345,123456
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
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
		[Parameter(Position = 0, Mandatory = $true)]
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Set-Alias Get-DSM7SoftwarebyIDs Get-DSM7SoftwareIDs
Export-ModuleMember -Function Get-DSM7SoftwareIDs -Alias Get-DSM7SoftwarebyIDs
function Get-DSM7Software {
	<#
	.SYNOPSIS
		Gibt ein Software Objekt zurueck.
	.DESCRIPTION
		Gibt ein Software Objekt zurueck.
	.EXAMPLE
		Get-DSM7Software -Name "Software" -LDAPPath ""Global Software Library/SWF1"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UniqueID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UpdateID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[switch]$IsLastReleasedRev
	)
	if (Confirm-Connect) {
		try {
			$SoftwareListID = $ID
			if ($Name) {
				$Name = Convert-StringtoLDAPString($Name)
				if ($IsLastReleasedRev) {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)(Software.IsLastReleasedRev=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
				}
				else {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(Name:IgnoreCase=$Name)(Software.IsLastRevision=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
				}
				if ($SoftwareList.count -gt 1) {
					Write-Log 1 "($Name) nicht eindeutig. Bitte LDAPPath nutzen!" $MyInvocation.MyCommand
					return $false
				}
				$SoftwareListID = $SoftwareList.ID
			}
			if ($UniqueID) {
				if ($IsLastReleasedRev) {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastReleasedRev=1)(BasePropGroupTag=Software))"
				}
				else {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))"
				}
				$SoftwareListID = $SoftwareList.ID
			}
			if ($UpdateID) {
				$UpdateID = Convert-StringtoLDAPString($UpdateID)
				if ($IsLastReleasedRev) {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(PatchPackage.UpdateId:IgnoreCase=$UpdateID)(Software.IsLastReleasedRev=1)(BasePropGroupTag=Software))"
				}
				else {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(PatchPackage.UpdateId:IgnoreCase=$UpdateID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))"
				}
				$SoftwareListID = $SoftwareList.ID
			}
			if ($SoftwareListID) {
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Get-DSM7Software
function Move-DSM7Software {
	<#
	.SYNOPSIS
		Verschiebt ein Softwareobjekt.
	.DESCRIPTION
		Verschiebt ein Softwareobjekt.
	.EXAMPLE
		Move-DSM7Software -Name "%Softwarename%" -toLDAPPath "Global Software Library/Folder1/Folder2"
	.EXAMPLE
		Move-DSM7Software -ID 12345 -toLDAPPathID 12345
	.EXAMPLE
		Move-DSM7Software -UniqueID "{UniqueID}" -toLDAPPath "Global Software Library/Folder1/Folder2"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 1, Mandatory = $false)]
		[System.String]$UniqueID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$toLDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[Int]$toLDAPPathID
	)
	if (Confirm-Connect) {
		try {
			if (($Name -or $ID -gt 0 -or $UniqueID) -and ($toLDAPPath -or $toLDAPPathID -gt 0) ) {
				if ($ID -eq 0) {
					if ($UniqueID) {
						$search = Get-DSM7Software -UniqueID $UniqueID
					}
					else {
						$search = Get-DSM7Software -Name $Name -LDAPPath $LDAPPath -UniqueID
					}
					if ($search) {
						$ID = $search.ID
					}
					else {
						Write-Log 1 "Software kann nicht nach ($toLDAPPath) verschoben werden!" $MyInvocation.MyCommand 
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
							Write-Log 1 "Software ($($Object.Name)) befindet sich schon in ($($Object.ParentContID))." $MyInvocation.MyCommand
							return $false
						}
						else {
							$result = Move-DSM7Object -Object $Object -ParentContID $ParentContID
							if ($result) { 
								$result = Convert-DSM7ObjecttoPSObject($result)
								Write-Log 0 "Software ($($result.Name)) erfolgreich nach ($($result.ParentContID)) verschoben." $MyInvocation.MyCommand
								return $true
							}
							else {
								return $false
							}
						}
					}
					else {
						Write-Log 1 "Software kann nicht nach ($toLDAPPath$toLDAPPathID) verschoben werden." $MyInvocation.MyCommand
					}
				} 
			}
			else {
				Write-Log 1 "Name, UniqueID oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}

		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Move-DSM7Software

function Update-DSM7Software {
	<#
	.SYNOPSIS
		aendert das Softwareobjekt.
	.DESCRIPTION
		aendert das Softwareobjekt.
	.EXAMPLE
		Update-DSM7Software -Name "Software" -Values @("Name=neuerName")
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
						Write-Log 1 "Aenderung kann nicht erfolgen!" $MyInvocation.MyCommand 
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
}
Export-ModuleMember -Function Update-DSM7Software

function Get-DSM7SoftwareList {
	<#
	.SYNOPSIS
		Gibt eine Liste von Software zurueck.
	.DESCRIPTION
		Gibt eine Liste von Software zurueck.
	.EXAMPLE
		Get-DSM7SoftwareList -LDAPPath "Global Software Library/SwFolder1/SwFolder2" -recursive
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		Gibt Softwarekategorien zurueck.
	.DESCRIPTION
		Gibt Softwarekategorien zurueck.
	.EXAMPLE
		Get-DSM7SoftwareCategoryList -LDAPPath "Global Software Library/Patch Library" -recursive
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Attributes,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Filter,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath = "",
		[Parameter(Position = 3, Mandatory = $false)]
		[int]$ParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
		[switch]$GenTypeData = $false,
		[Parameter(Position = 5, Mandatory = $false)]
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
		Gibt ein Softwarekategorie zurueck.
	.DESCRIPTION
		Gibt ein Softwarekategorie zurueck.
	.EXAMPLE
		Get-DSM7SoftwareCategory -ID 1234
	.EXAMPLE
		Get-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 4, Mandatory = $false)]
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
							if ($IDs) {
								$NameIDs = get-dsm7objects -IDs $IDs -ObjectGroupType "Catalog"

								foreach ($NameID in $NameIDs) {
									$StringName = Convert-StringtoLDAPString $NameID.Name
									$regex = [Regex]$NameID.ID
									$result.'DynamicSwCategoryProps.FilterName' = $regex.Replace($result.'DynamicSwCategoryProps.FilterName', $StringName, 1)
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
		catch [system.exception] {
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
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $true)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[ValidateSet("SwCategory", "PatchMgmtRuleFilter", "DynamicSwCategory", "DynamicPatchMgmtRuleFilter")]
		[system.string]$SchemaTag = "SwCategory",
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$ParentDynGroup,
		[Parameter(Position = 7, Mandatory = $false)]
		[system.string]$Filter,
		[Parameter(Position = 8, Mandatory = $false)]
		[switch]$resolvedName = $false,
		[switch]$lastCat = $false,
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
							if ($linepara[0].contains('PatchPackage.Products')) { $PatchSchema = "PatchProduct" }
							if ($linepara[0].contains('PatchPackage.ProductFamily')) { $PatchSchema = "PatchProductFamily" }

							foreach ($LineName in $linepara[1].split(",")) {
								$LineName = Convert-ReplaceStringToLDAPString $LineName
								[System.Array]$FilterName = Get-DSM7ObjectList -LDAProot "<LDAP://rootCatalog>" -Filter "(&(Name=$LineName)(PatchCategoryObject.RequiredLicense=$PatchMgmtLicense)(SchemaTag=$PatchSchema)(BasePropGroupTag=PatchCategoryObject))" -Attributes "PatchCategoryObject.RequiredLicense"
								if ($FilterName -and $FilterName.count -gt 0) {
									$LineName = $LineName.replace("\", "\\\")
									$LineName = $LineName.replace("+", "\+")
									$LineName = $LineName.replace("-", "\-")
									$regex = [Regex]$LineName
									if ($FilterName.count -gt 1) {
										if ($lastCat) { 
											$Filter = $regex.Replace($Filter, $FilterName[-1].ID, 1)
										}
										else {
											Write-Log 1 "Konnte Filter ($Filter) nicht aufloesen, mehrere Objekte vorhanden ($($FilterName.count))!!!" $MyInvocation.MyCommand 
										} 
									}
									else {
										$Filter = $regex.Replace($Filter, $FilterName.ID, 1)
									}
								}
								else {
									Write-Log 1 "Konnte Filter ($Filter) nicht aufloesen!!!" $MyInvocation.MyCommand 
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
						if ($Filter) { $CreateGroup = $true }
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

						if ($Filter) { $CreateGroup = $true }
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function New-DSM7SoftwareCategory
function Update-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		aendert eine Softwarekategorie.
	.DESCRIPTION
		aendert eine Softwarekategorie.
	.EXAMPLE
		Update-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library" -Filter "(Name=Test)"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$Description,
		[Parameter(Position = 2, Mandatory = $false)]
		[int]$ID,
		[Parameter(Position = 3, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 4, Mandatory = $false)]
		[system.string]$ParentContID,
		[Parameter(Position = 5, Mandatory = $false)]
		[system.string]$Filter,
		[Parameter(Position = 6, Mandatory = $false)]
		[switch]$resolvedName = $false,
		[Parameter(Position = 7, Mandatory = $false)]
		[switch]$lastCat = $false,
		[Parameter(Position = 8, Mandatory = $false)]
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
								if ($linepara[0].contains('PatchPackage.Products')) { $PatchSchema = "PatchProduct" }
								if ($linepara[0].contains('PatchPackage.ProductFamily')) { $PatchSchema = "PatchProductFamily" }

								foreach ($LineName in $linepara[1].split(",")) {
									$LineName = Convert-ReplaceStringToLDAPString $LineName
									[System.Array]$FilterName = Get-DSM7ObjectList -LDAProot "<LDAP://rootCatalog>" -Filter "(&(Name=$LineName)(PatchCategoryObject.RequiredLicense=$PatchMgmtLicense)(SchemaTag=$PatchSchema)(BasePropGroupTag=PatchCategoryObject))" -Attributes "PatchCategoryObject.RequiredLicense"
									if ($FilterName -and $FilterName.count -gt 0) {
										$LineName = $LineName.replace("\", "\\\")
										$LineName = $LineName.replace("+", "\+")
										$LineName = $LineName.replace("-", "\-")
										$regex = [Regex]$LineName
										if ($FilterName.count -gt 1) {
											if ($lastCat) { 
												$Filter = $regex.Replace($Filter, $FilterName[-1].ID, 1)
											}
											else {
												Write-Log 1 "Konnte Filter ($Filter) nicht aufloesen, mehrere Objekte vorhanden ($($FilterName.count))!!!" $MyInvocation.MyCommand 
											} 
										}
										else {
											$Filter = $regex.Replace($Filter, $FilterName.ID, 1)
										}
									}
									else {
										Write-Log 1 "Konnte Filter ($Filter) nicht aufloesen!!!" $MyInvocation.MyCommand 
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
								$Values += "DynamicSwCategoryProps.Filter=" + $Filter
							} 
						}
						"DynamicPatchMgmtRuleFilter" {
							if ($Filter) {
								$Values += "DynamicSwCategoryProps.Filter=" + $Filter
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
						Write-Log 0 "Softwarekategorie ($($Object.Name)) wurde geaendert." $MyInvocation.MyCommand 
						$Object = Convert-DSM7ObjectListtoPSObject($Object)
						return $Object
					}
					else {
						Write-Log 1 "Softwarekategorie konnte nicht geaendert werden!!!" $MyInvocation.MyCommand 
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Update-DSM7SoftwareCategory
function Remove-DSM7SoftwareCategory {
	<#
	.SYNOPSIS
		Loescht eine Softwarekategorie.
	.DESCRIPTION
		Loescht eine Softwarekategorie.
	.EXAMPLE
		Remove-DSM7SoftwareCategory -ID 1234
	.EXAMPLE
		Remove-DSM7SoftwareCategory -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[System.Int32]$ID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 3, Mandatory = $false)]
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
						Write-Log 0 "($($Object.Name)) erfolgreich geloescht." $MyInvocation.MyCommand
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Remove-DSM7SoftwareCategory

function Get-DSM7SwInstallationParamDefinitions {
	<#
	.SYNOPSIS
		Gibt von einem Softwarepaket die Parameter Definition zurueck.
	.DESCRIPTION
		Gibt von einem Softwarepaket die Parameter Definition zurueck.
	.EXAMPLE
		Get-DSM7SwInstallationParamDefinitions -ID 1234
	.EXAMPLE
		Get-DSM7SwInstallationParamDefinitions -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
	.NOTES
	.LINK
		Get-DSM7SoftwareList
	.LINK
		Get-DSM7SoftwareIDs
	.LINK
		Get-DSM7Software
	.LINK
		Update-DSM7Software
	.LINK
		Move-DSM7Software
	.LINK
		Get-DSM7SwInstallationParamDefinitions
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
		[switch]$resolvedName,
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
						Write-Log 1 "Nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
				if ($UniqueID) {
					$SoftwareList = Get-DSM7ObjectList -Filter "(&(UniqueID:IgnoreCase=$UniqueID)(Software.IsLastRevision=1)(BasePropGroupTag=Software))" -LDAPPath $LDAPPath
					$ID = $SoftwareList.ID
				}
				if ($ID -gt 0) {
					$Software = Get-DSM7ObjectObject -ID $ID 
					$SoftwareParamDef = Get-DSM7SwInstallationParamDefinitionsObject $Software 
					if ($SoftwareParamDef) {
						$SoftwareParamDef = Convert-DSM7SwInstallationParamDefinitionstoPSObjects -DSM7Objects $SoftwareParamDef -resolvedName:$resolvedName
						Write-Log 0 "Parameter zu Software ($($Software.Name)) gefunden." $MyInvocation.MyCommand 
						return $SoftwareParamDef
					}
					else {
						Write-Log 1 "Nicht gefunden!" $MyInvocation.MyCommand 
						return $false
					}
				}
			}
			else {
				Write-Log 1 "Name oder ID nicht angegeben!!!" $MyInvocation.MyCommand 
				return $false
			}
		}
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7SwInstallationParamDefinitions

function Get-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$Object
	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetSwInstallationParamDefinitions"
		$Webrequest.ObjectToQuery = $Object
		$Webresult = $DSM7WebService.GetSwInstallationParamDefinitions($Webrequest).InstallationParameterDefinitions
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}

function Add-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$UniqueID,
		[Parameter(Position = 1, Mandatory = $true)]
		$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		$Values,
		[Parameter(Position = 2, Mandatory = $true)]
		$InstallationParamType = "String" ,
		[Parameter(Position = 2, Mandatory = $false)]
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
		$DisplayName.CultureCode = "de"
		$DisplayName.Representation = "Test456"
		$DisplayNameList += $DisplayName 
		$Webrequest.SwInstallationParamDefinitionToAdd.DisplayNameList = $DisplayNameList
		$LocigalCategory = @()
		$DisplayName = New-Object $DSM7Types["MdsDisplayName"]
		$DisplayName.CultureCode = "de"
		$DisplayName.Representation = "Test456"
		$LocigalCategory += $DisplayName 
		$Webrequest.SwInstallationParamDefinitionToAdd.LocigalCategory = $LocigalCategory
		$PredefinedValues = @()
		$PredefinedValue = New-Object $DSM7Types["MdsSWIPPredefinedValue"]
		$PredefinedValue.PredefinedValue = "Test"
		$PredefinedValueDisplayNameList = @()
		$PredefinedValueDisplayName = New-Object $DSM7Types["MdsDisplayName"]
		$PredefinedValueDisplayName.CultureCode = "de"
		$PredefinedValueDisplayName.Representation = "Test456"
		$PredefinedValueDisplayNameList += $PredefinedValueDisplayName 
		$PredefinedValue.DisplayNameList = $PredefinedValueDisplayNameList
		$PredefinedValues += $PredefinedValue
		$Webrequest.SwInstallationParamDefinitionToAdd.PredefinedValueList = $PredefinedValues
		$Webresult = $DSM7WebService.AddSwInstallationParamDefinition($Webrequest).AddedSwInstallationParamDefinition
		Write-Log 0 "($NodeId) erfolgreich." $MyInvocation.MyCommand

		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Remove-DSM7SwInstallationParamDefinitionsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$Object

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "DeleteSwInstallationParamDefinition"
		$Webrequest.SwInstallationParamDefinitionToDelete = $Object
		$Webresult = $DSM7WebService.DeleteSwInstallationParamDefinition($Webrequest)

		return $true
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7DepotStatesOfPackage {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		[int32]$ID
	)
	$result = Get-DSM7DepotStatesOfPackageObject -ID $ID
	return $result 
}
#Export-ModuleMember -Function Get-DSM7DepotStatesOfPackage
function Get-DSM7DepotStatesOfPackageObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		[int32]$ID

	)
	try {
		$Webrequest = Get-DSM7RequestHeader -action "GetDepotStatesOfPackage"
		$Webrequest.PackageId = $ID
		$Webresult = $DSM7WebService.GetDepotStatesOfPackage($Webrequest).DepotStates
		return $Webresult
	}
	catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7ResolveVariablesForTarget {
	<#
	.SYNOPSIS
		Gibt eine Liste von Variablen eines Objektes zurueck.
	.DESCRIPTION
		Gibt eine Liste von Variablen eines Objektes zurueck.
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
				Write-Log 0 "Variablen fuer Ziel ID ($TargetID) ermittelt." $MyInvocation.MyCommand
				return $Variables
			} 
			else {
				Write-Log 1 "($TargetName/$TargetID) nicht gefunden!" $MyInvocation.MyCommand
				return $false
			}
		}
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Get-DSM7VariableGroups {
	<#
	.SYNOPSIS
		Gibt eine Liste von Variablen Gruppen und deren Variablen zurueck.
	.DESCRIPTION
		Gibt eine Liste von Variablen Gruppen und deren Variablen zurueck.
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
		catch [system.exception] {
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
	catch [system.exception] {
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
		[Parameter(Position = 2, Mandatory = $true)]
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
					$VariableNameGroup = $Variable.split("=", 2)[0]
					$VariableValue = $Variable.split("=", 2)[1]
					$VariableGroup = $VariableNameGroup.split(".")[0]
					$VariableName = $VariableNameGroup.split(".")[1]
					$VariableID = $($VariableGroups | where { $_.Tag -eq $VariableName -and $_.GroupTag -eq $VariableGroup }).ID
					if ($VariableID) {

						$VariableSet = New-Object $DSM7Types["MdsVariableValueAssignment"]

						$VariableSet.VariableId = $VariableID
						$VariableSet.Value = $VariableValue
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
		catch [system.exception] {
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
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}
function Remove-DSM7VariablesOnTarget {
	<#
	.SYNOPSIS
		Loesche eine Liste von Variablen an einem Objektes.
	.DESCRIPTION
		Loesche eine Liste von Variablen an eimem Objektes.
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
		[Parameter(Position = 2, Mandatory = $true)]
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
					$VariableID = $($VariableGroups | where { $_.Tag -eq $VariableName -and $_.GroupTag -eq $VariableGroup }).ID
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
		catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		$Names = @()

	)
	try {
		$IDs = $IDs | Sort-Object | Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetObjectSchemaList"
		$Webrequest.Schematags = $Names
		$Webresult = $DSM7WebService.GetObjectSchemaList($Webrequest).SchemaList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 
}
function Get-DSM7PropGroupDefListObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $false)]
		$Names = @()

	)
	try {
		$IDs = $IDs | Sort-Object | Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetPropGroupDefList"
		$Webrequest.PropGroupTags = $Names
		$Webresult = $DSM7WebService.GetPropGroupDefList($Webrequest).PropGroupDefList
		return $Webresult
	}
	catch [system.exception] {
		Write-Log 2 $_ $MyInvocation.MyCommand 
		return $false 
	} 

}

function Get-DSM7DisplayNameListsObject {
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $true)]
		$IDs = @()

	)
	try {
		$IDs = $IDs | Sort-Object | Get-Unique
		$Webrequest = Get-DSM7RequestHeader -action "GetDisplayNameLists"
		$Webrequest.DisplayNameIds = $IDs
		$Webresult = $DSM7WebService.GetDisplayNameLists($Webrequest).DisplayNames
		return $Webresult
	}
	catch [system.exception] {
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.int32]$UserID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserUniqueID,
		[Parameter(Position = 3, Mandatory = $false)]
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
					Write-Log 0 "Computer ($ID) zu Benutzer ($UserID) erfolgreich hinzugefuegt." $MyInvocation.MyCommand
					$result = Convert-DSM7AssociationtoPSObject($result)
					return $result
				}
				else {
					Write-Log 1 "Computer ($ID) ist schon zu Benutzer ($UserID) zugeordnet!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "Computer ($ID) nicht zu Benutzer ($UserID) hinzugefuegt." $MyInvocation.MyCommand
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
function Get-DSM7ComputerToUser {
	<#
	.SYNOPSIS
		Gibt die zugeordneten Benutzer zu einem Computer zurueck.
	.DESCRIPTION
		Gibt die zugeordneten Benutzer zu einem Computer zurueck.
	.EXAMPLE
		Get-DSM7ComputerToUser -ID x
	.EXAMPLE
		Get-DSM7ComputerToUser -UserID x
	.NOTES
	.LINK
		Add-DSM7ComputerToUser 
	.LINK
		Remove-DSM7ComputerToUser
	.LINK
		Get-DSM7ComputerToUser
	#>
	[CmdletBinding()] 
	param ( 
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.int32]$UserID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserUniqueID,
		[Parameter(Position = 3, Mandatory = $false)]
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
			if ($ID -or $UserID) {
				if ($ID) { 
					$result = Get-DSM7AssociationList -SchemaTag "ComputerAssociatedUser" -SourceObjectID $ID
				}
				if ($result) {
					Write-Log 0 "Computer ($ID) hat zugehoerige Benutzer." $MyInvocation.MyCommand
					$result = Convert-DSM7AssociationListtoPSObject($result) -resolvedName
					return $result
				}
				else {
					Write-Log 1 "Computer ($ID) hat keine Benutzer!" $MyInvocation.MyCommand
					return $false
				}
				if ($UserID) {
					$result = Get-DSM7AssociationList -SchemaTag "ComputerAssociatedUser" -TargetObjectID $UserID -TargetSchemaTag "User"
				}
				if ($result) {
					Write-Log 0 "Benutzer ($UserID) ist Computern zugeordnet." $MyInvocation.MyCommand
					$result = Convert-DSM7AssociationListtoPSObject($result) -resolvedName
					return $result
				}
				else {
					Write-Log 1 "Benutzer ($ID) keinem Computer zugeordnet!" $MyInvocation.MyCommand
					return $false
				}
			}
			else {
				Write-Log 1 "Computer ($ID) oder Benutzer ($UserID) nicht angeben." $MyInvocation.MyCommand
				return $false
			}
		}
		else {
			Write-Log 1 "Funktion nicht in der Version vorhanden!" $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ComputerToUser
function Get-DSM7ComputerToUserList {
	<#
	.SYNOPSIS
		Gibt die Liste zugeordneten Benutzer zu Computer zurueck.
	.DESCRIPTION
		Gibt die Liste zugeordneten Benutzer zu Computer zurueck.
	.EXAMPLE
		Get-DSM7ComputerToUserList
	.NOTES
	.LINK
		Add-DSM7ComputerToUser 
	.LINK
		Remove-DSM7ComputerToUser
	.LINK
		Get-DSM7ComputerToUser
	.LINK
		Get-DSM7ComputerToUserList
	#>
	if (Confirm-Connect) {
		$result = Get-DSM7AssociationList -SchemaTag "ComputerAssociatedUser"
		if ($result) {
			Write-Log 0 "Liste fertig." $MyInvocation.MyCommand
			$result = Convert-DSM7AssociationListtoPSObject($result) -resolvedName
			return $result
		}
		else {
			Write-Log 1 "Es gibt keine zugeordneten Benutzer zu Computern!" $MyInvocation.MyCommand
			return $false
		}
	}
}
Export-ModuleMember -Function Get-DSM7ComputerToUserList
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
		[Parameter(Position = 0, Mandatory = $false)]
		[system.int32]$ID,
		[Parameter(Position = 0, Mandatory = $false)]
		[system.string]$Name,
		[Parameter(Position = 1, Mandatory = $false)]
		[system.string]$LDAPPath,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.int32]$UserID,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserName,
		[Parameter(Position = 2, Mandatory = $false)]
		[system.string]$UserUniqueID,
		[Parameter(Position = 3, Mandatory = $false)]
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
function Get-DSM7UserList {
	<#
	.SYNOPSIS
		Gibt eine Liste von User zurueck.
	.DESCRIPTION
		Gibt eine Liste von User zurueck.
	.EXAMPLE
		Get-DSM7UserList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
	.NOTES
	.LINK
		Get-DSM7UserList
	.LINK
		Get-DSM7User
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
				$resultUser = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=User)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
				if ($resultUser) {
					$result += $resultUser
				} 
				$resultContainer = Get-DSM7ObjectList -Filter $DSM7Container -ParentContID $ParentContID -recursive
				foreach ($Container in $resultContainer) {
					$FilterContainer = "(&(ParentContID=$($Container.ID))(SchemaTag=User)$filter)"
					$resultUser = Get-DSM7ObjectList -Attributes $Attributes -Filter $FilterContainer 
					if ($resultUser) {
						$result += $resultUser
					}
				} 
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=User)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
		}
		else {
			if ($ParentContID -gt 0) {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=User)$Filter)" -ParentContID $ParentContID -GenTypeData:$GenTypeData
			}
			else {
				$result = Get-DSM7ObjectList -Attributes $Attributes -Filter "(&(SchemaTag=User)$Filter)" -GenTypeData:$GenTypeData
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
Export-ModuleMember -Function Get-DSM7UserList

function Get-DSM7User {
	<#
	.SYNOPSIS
		Gibt das Benutzerobjekt zurueck.
	.DESCRIPTION
		Gibt das Benutzerobjekt zurueck.
	.EXAMPLE
		Get-DSM7User -Name "%Benutzer%" 
	.EXAMPLE
		Get-DSM7User -ID 1234
	.EXAMPLE
		Get-DSM7User -UniqueID %SID%
	.EXAMPLE
		Get-DSM7User -Name "%Benutzer%" -LDAPPath "Managed Users & Computers/domaene/loc/Benutzer"
	.NOTES
	.LINK
		Get-DSM7User
	.LINK
		Get-DSM7UserList
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
		catch [system.exception] {
			Write-Log 2 $_ $MyInvocation.MyCommand 
			return $false 
		} 
	}
} 
Export-ModuleMember -Function Get-DSM7User
###############################################################################
# DSM7 Funktionen - NCP
###############################################################################
function Get-DSM7NCP {
	<#
	.SYNOPSIS
		Gibt das NCP als XML zurueck.
	.DESCRIPTION
		Gibt das NCP als XML zurueck.
	.EXAMPLE
		Get-DSM7NCP 
	.NOTES
	.LINK
		Get-DSM7NCPObjects
	.LINK
		Get-DSM7NCP
	#>
	[CmdletBinding()] 
	param ( 
		[system.string]$Path,
		[system.string]$NCPFile,
		$Credential
	)
	if (!$Path) {
		$DSM7RegPath = Convert-StringtoPSRegKey $DSM7RegPath -is32Bit
		Write-Log 0 "Registry DSM Client Base ($DSM7RegPath)." $MyInvocation.MyCommand 
		$DSM7Path = Get-RegistryValue $DSM7RegPath "ServerSourcePath"
		Write-Log 0 "DSM Server Path: ($DSM7Path)." $MyInvocation.MyCommand 
	}
	else {
		$DSM7Path = $Path
	}
	Write-Log 0 "DSM Server Path: ($DSM7Path)." $MyInvocation.MyCommand 
	if ($Credential) {
		New-PSDrive -Name ORG -PSProvider FileSystem -Root $DSM7Path -Credential $Credential | Out-Null
	}
	else {
		New-PSDrive -Name ORG -PSProvider FileSystem -Root $DSM7Path | Out-Null

	}
	$DSM7ExportNCPlocal = $NCPFile
	if (Test-Path "ORG:\$DSM7ExportNCP") {
		if (Test-Path "ORG:\$DSM7NCPfile") {
			$NCPFilelastwritetime = [datetime](Get-ItemProperty -Path "ORG:\$DSM7NCPfile" -Name LastWriteTime).lastwritetime
			Write-Log 0 "Lastwritetime of file $DSM7Path\$DSM7NCPfile ($NCPFilelastwritetime)." $MyInvocation.MyCommand 
		} 
		if (!$DSM7ExportNCPlocal) { $DSM7ExportNCPlocal = "$ENV:Temp\$DSM7ExportNCPXML" }
		if (Test-Path $DSM7ExportNCPlocal) {
			$DSM7ExportNCPlastwritetime = [datetime](Get-ItemProperty -Path $DSM7ExportNCPlocal -Name LastWriteTime).lastwritetime
			Write-Log 0 "Lastwritetime of file $DSM7ExportNCPlocal ($DSM7ExportNCPlastwritetime)." $MyInvocation.MyCommand 
		}
		else {
			[datetime]$DSM7ExportNCPlastwritetime = "1970/01/01"
		}
		if ($NCPFilelastwritetime -gt $DSM7ExportNCPlastwritetime ) {
			Write-Log 0 "Create DSM Export XML.($NCPFilelastwritetime > $DSM7ExportNCPlastwritetime)" $MyInvocation.MyCommand 
			Start-Process -FilePath "ORG:\$DSM7ExportNCP" -ArgumentList "/xml:$DSM7ExportNCPlocal /full"  -Wait
		}
	}
	Remove-PSDrive ORG
	if (test-path $DSM7ExportNCPlocal) {
		if (remove-XMLSpecialChar -file $DSM7ExportNCPlocal) {
			$DSMNCP = [XML] (get-content -path $DSM7ExportNCPlocal -Encoding UTF8)
		}
	}

	return $DSMNCP
} 
Export-ModuleMember -Function Get-DSM7NCP
function Get-DSM7NCPObjects {
	<#
	.SYNOPSIS
		Gibt das NCP Objekte zurueck.
	.DESCRIPTION
		Gibt das NCP Objekt zurueck.
	.EXAMPLE
		Get-DSM7NCPObjects -DSMNCP $NCP
	.NOTES
	.LINK
		Get-DSM7NCPObjects
	.LINK
		Get-DSM7NCP
#>
	param(
		[XML]$DSMNCP,
		[System.Array]$DSMNCPObjects,
		[system.int32]$ParentID,
		[array]$object,
		[string]$Path
	)
	if ($DSMNCP) {
		$object = $DSMNCP.SelectNodes("//NCPObject")[0]
	}
	foreach ($item in $object) {
		switch ($item.type) {
			"ORG" { $InfraID = 0 }
			"OU" { $InfraID = 1 }
			"Site" { $InfraID = 2 }
			Default { $InfraID = 9 }
		}
		$Raw = New-Object PSObject
		if ($item.Type -eq "MGNT_POINT") { $Name = $item.Name -replace "Management Point " -replace '\(|\)' }
		else { $Name = $item.Name }
		add-member -inputobject $Raw -MemberType NoteProperty -name "Name" -Value $Name
		add-member -inputobject $Raw -MemberType NoteProperty -name "Type" -Value $item.Type
		add-member -inputobject $Raw -MemberType NoteProperty -name "InfraID" -Value $InfraID
		add-member -inputobject $Raw -MemberType NoteProperty -name "ID" -Value $item.ID
		add-member -inputobject $Raw -MemberType NoteProperty -name "Description" -Value $item.Description.value
		$sections = @()
		foreach ($section in $item.SECTION) {
			$RawSection = New-Object PSObject
			add-member -inputobject $RawSection -MemberType NoteProperty -name "Name" -Value $section.value
			$Variables = @()
			foreach ($variable in $section.variable) {
				$RawVar = New-Object PSObject
				add-member -inputobject $RawVar -MemberType NoteProperty -name "Name" -Value $variable.Name
				add-member -inputobject $RawVar -MemberType NoteProperty -name "Type" -Value $variable.type
				add-member -inputobject $RawVar -MemberType NoteProperty -name "Value" -Value $variable.value
				add-member -inputobject $RawVar -MemberType NoteProperty -name "Status" -Value $variable.STATUS_SPECIFIED
				$Variables += $RawVar 
			}
			add-member -inputobject $RawSection -MemberType NoteProperty -name "Variables" -Value $Variables
			$sections += $RawSection
		}
		add-member -inputobject $Raw -MemberType NoteProperty -name "Sections" -Value $sections
		add-member -inputobject $Raw -MemberType NoteProperty -name "ParentPath" -Value $Path
		add-member -inputobject $Raw -MemberType NoteProperty -name "ParentID" -Value $ParentID

		if ($infraID -lt 4) {
			$Path = $Path + "/Infra=" + $item.Name
		}
		else {
			$Path = $Path + "/Name=" + $item.Name

		}
		$path = $Path.trimstart("/")
		$DSMCount = ($Path).split("/").count 
		add-member -inputobject $Raw -MemberType NoteProperty -name "DSMCount" -Value $DSMCount -Force

		foreach ($ncpitem in $item.NCPObject) {
			$DSMNCPObjects = Get-DSM7NCPObjects -object $ncpitem -Path $Path -ParentID $item.ID -DSMNCPObjects $DSMNCPObjects
		}
		$PathSort = $Path -replace " "
		add-member -inputobject $Raw -MemberType NoteProperty -name "Path" -Value $Path
		add-member -inputobject $Raw -MemberType NoteProperty -name "PathSort" -Value $PathSort
		$DSMNCPObjects += $Raw

	}
	return $DSMNCPObjects
}
Export-ModuleMember -Function Get-DSM7NCPObjects
# SIG # Begin signature block
# MIID6QYJKoZIhvcNAQcCoIID2jCCA9YCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUwlXiYSsNMOv5ljR0dzkDy++h
# jM6gggIKMIICBjCCAXOgAwIBAgIQu5sKUC9Qh6ZJ3pWdk+J2LzAJBgUrDgMCHQUA
# MBUxEzARBgNVBAMTClV3ZSBGcmFua2UwHhcNMTkxMTI5MTM1MDMyWhcNMzkxMjMx
# MjM1OTU5WjAVMRMwEQYDVQQDEwpVd2UgRnJhbmtlMIGfMA0GCSqGSIb3DQEBAQUA
# A4GNADCBiQKBgQCtDYV+VqoUSxMgO+is0UUWdyzvWchxX2+JKiuI8vqEz5wdhYdR
# qysDT1sBvIHVpkd8Bwg1V5R+t9W9BmLYxugQhcXRrcvH7q6NuQ8Sj4gez5JuVmsI
# XHNz82lL0KZalR6o1ShkcsyeMY9WxRobpVD8yGJ2r0T4bW5V1Zbb9eDKTQIDAQAB
# o18wXTATBgNVHSUEDDAKBggrBgEFBQcDAzBGBgNVHQEEPzA9gBA5Gm4cEkdUJ8rS
# pxcYeU3roRcwFTETMBEGA1UEAxMKVXdlIEZyYW5rZYIQu5sKUC9Qh6ZJ3pWdk+J2
# LzAJBgUrDgMCHQUAA4GBAIYzsiiW7hfNxy5DoGR8ZL5LDo4MQ3P9Zt8KJPux1lcT
# /xYTrcvHEdJ0oYfHekhBi43aA7jk1tjtU2kL2VqWlt477q6zxXfgWSJS62kUeKvf
# 151usx5IWvaFONFgXwSlTG6lqGD6fkLrtdybMGX03ZgJ6rn6F6S3vdMTvakkCh7x
# MYIBSTCCAUUCAQEwKTAVMRMwEQYDVQQDEwpVd2UgRnJhbmtlAhC7mwpQL1CHpkne
# lZ2T4nYvMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkG
# CSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEE
# AYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQuqMUdwayhSJjUfOZl0W3lB/AuiDANBgkq
# hkiG9w0BAQEFAASBgAPdwzzO33Y1lHgd66tQCrPKlaheLK6+x8BpQqXRqJ9MuyHF
# fK0k1OnEOFVG+JnkAL5bjSXxSBbV4K7fVQQXDNfQpOfRa+AkM4MU9rqSmfpc0eGR
# nNpTsS6Jj+3xQVLo5Sj8U5dxwjXcEuqlqggacQkNPPGHPCk1DPHfK+W6F5CC
# SIG # End signature block
