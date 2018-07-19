
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

# SIG # Begin signature block
# MIIEMQYJKoZIhvcNAQcCoIIEIjCCBB4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQURKIzPv8OSOfwu93P7kIava+e
# wFmgggJAMIICPDCCAamgAwIBAgIQUW95fLQCIbVOuAnpDDc4ZTAJBgUrDgMCHQUA
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
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBS3
# Ue8HCmxe/OIeQtbZrrZcCC6+hDANBgkqhkiG9w0BAQEFAASBgDsk0XusYFgnx5MQ
# k3dn0QThLGARhfxWD+I/efXdzUeAFejw1J8pq77lhQfIEDES7k1UOMoknDz9pVHb
# bzNSZ5tc8jGOa/TcBXdvrwvMAfa0qa2ZbSY8oYMDiVoCDCuhelneK7r3qfgZnc9U
# qxElBgylC+STmdyiuFzf1U95pOu/
# SIG # End signature block
