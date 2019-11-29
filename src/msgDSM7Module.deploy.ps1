
<#PSScriptInfo

.VERSION 1.1

.GUID 936c87ee-e4be-494a-9388-b7d8b695e484

.AUTHOR Uwe Franke

.COMPANYNAME msg services AG

.COPYRIGHT msg services AG

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


.PRIVATEDATA 

#> 



<# 

.DESCRIPTION 
 Installiert Powershell Module msgDSM7Module 

#> 
[CmdletBinding()]
Param(
)
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
	Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}"' -f ($myinvocation.MyCommand.Definition))
	exit
}
$scriptpath = Split-Path -parent $MyInvocation.MyCommand.Definition

$psmodule = "msgDSM7Module"
Import-Module "$scriptpath\$psmodule" -Force -ErrorAction SilentlyContinue
$psmoduleget = get-module $psmodule
$psmodulegetVersion = $psmoduleget.Version
write-host "Powershell Module ($psmodule) Version ($psmodulegetVersion) wird installiert."
if ($PSVersionTable.PSVersion.Major -ge 4) {
	$programpath = "$ENV:Programfiles\WindowsPowerShell\Modules"
	if (!(test-path "$programpath\$psmodule")) {
		write-host "Erstelle Dir ($programpath\$psmodule)."
		mkdir "$programpath\$psmodule" -Verbose:$VerbosePreference| Out-Null
	}
	if (!(test-path "$programpath\$psmodule\$psmodulegetVersion")) {
		write-host "Erstelle Dir ($programpath\$psmodule\$psmodulegetVersion)."
		mkdir "$programpath\$psmodule\$psmodulegetVersion" -Verbose:$VerbosePreference| Out-Null
	}

	if (!(test-path "$programpath\$psmodule\$psmodulegetVersion\de-DE")) {
		write-host "Erstelle Dir ($programpath\$psmodule\$psmodulegetVersion\de-DE)."
		mkdir "$programpath\$psmodule\$psmodulegetVersion\de-DE" -Verbose:$VerbosePreference| Out-Null
	}
	$destpath = "$programpath\$psmodule\$psmodulegetVersion"
}
else {
	$programpath = "$env:ProgramFiles\msg services AG\DSMAutomation\Powershell\Modules"
	if (!(test-path "$programpath\$psmodule")) {
		write-host "Erstelle Dir ($programpath\$psmodule)."
		mkdir "$programpath\$psmodule" -Verbose:$VerbosePreference| Out-Null
	}
	if (!(test-path "$programpath\$psmodule\de-DE")) {
		write-host "Erstelle Dir ($programpath\$psmodule\de-DE)."
		mkdir "$programpath\$psmodule\de-DE" -Verbose:$VerbosePreference| Out-Null
	}
	$destpath = "$programpath\$psmodule"
}
write-host "Kopiere Module nach ($destpath)."
Copy-Item "$scriptpath\*.psd1" "$destpath" -Verbose:$VerbosePreference
Copy-Item "$scriptpath\*.psm1" "$destpath" -Verbose:$VerbosePreference
Copy-Item "$scriptpath\de-DE\*.txt" "$destpath\de-DE" -Verbose:$VerbosePreference 
Copy-Item "$scriptpath\de-DE\*.xml" "$destpath\de-DE" -Verbose:$VerbosePreference 

$p = [Environment]::GetEnvironmentVariable("PSModulePath","Machine")
if ($p -notlike "*$programpath*"){
	write-host "Erweitere PSModulePath ($programpath)."
	$p += ";$programpath"
	[Environment]::SetEnvironmentVariable("PSModulePath",$p,"Machine")
}
