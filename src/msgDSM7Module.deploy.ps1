<#
.SYNOPSIS
   Installiert Powershell Module msgDSM7Module
.DESCRIPTION
   Installiert Powershell Module msgDSM7Module
.EXAMPLE
   msgDSM7Module.deploy.ps1 
.EXAMPLE
   msgDSM7Module.deploy.ps1 -nolink
#>
[CmdletBinding()]
Param(
	[switch]$nolink
)
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}"' -f ($myinvocation.MyCommand.Definition))
exit
}
$scriptpath = Split-Path -parent $MyInvocation.MyCommand.Definition
$programpath = "msg services AG\DSMAutomation\Powershell\Modules"
$psmodule = "msgDSM7Module"
Import-Module "$scriptpath\$psmodule" -Force -ErrorAction SilentlyContinue
$psmoduleget = get-module $psmodule
write-host "Powershell Module ($psmodule) Version ($($psmoduleget.Version)) wird installiert."
if ([Environment]::Is64BitProcess) {
	$destpath = "$env:ProgramFiles\$programpath"
}
else {
	$destpath = "${env:ProgramFiles(x86)}\$programpath"
}
if (!(test-path "$destpath\$psmodule")) {
	write-host "Erstelle Dir ($destpath)."
	mkdir "$destpath\$psmodule" -Verbose:$VerbosePreference| Out-Null
}
write-host "Kopiere Module nach ($destpath)."
Copy-Item "$scriptpath\*.psd1" "$destpath\$psmodule" -Verbose:$VerbosePreference
Copy-Item "$scriptpath\*.psm1" "$destpath\$psmodule" -Verbose:$VerbosePreference
Copy-Item "$scriptpath\index.html" "$destpath\$psmodule" -Verbose:$VerbosePreference

$p = [Environment]::GetEnvironmentVariable("PSModulePath","Machine")
if ($p -notlike "*$destpath*"){
	write-host "Erweitere PSModulePath ($destpath)."
	$p += ";$destpath"
	[Environment]::SetEnvironmentVariable("PSModulePath",$p,"Machine")
}
if (!$nolink) {
	write-host "Erstelle Startmenü Eintrag."
	$psmoduledir = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\$($psmoduleget.CompanyName)"
	if (!(test-path $psmoduledir)) {mkdir $psmoduledir -Verbose:$VerbosePreference| Out-Null}
	$TargetFile = "$destpath\$psmodule\index.html"
	$ShortcutFile = "$psmoduledir\Hilfe für $psmodule.lnk"
	$WScriptShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
	$Shortcut.TargetPath = $TargetFile
	$Shortcut.Save()
}
# SIG # Begin signature block
# MIIEMQYJKoZIhvcNAQcCoIIEIjCCBB4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUeezrKG9++eMbcE5L8y3/2D16
# 8D6gggJAMIICPDCCAamgAwIBAgIQUW95fLQCIbVOuAnpDDc4ZTAJBgUrDgMCHQUA
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
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBRJ
# xtHd5lM5V8sRQND1bUFB2nfwMDANBgkqhkiG9w0BAQEFAASBgKQMHqdGi+9U10jS
# dparMe1bLo+fHeBdC8Q25LJpETcX7IYf0f8NTH6iqmUmVSI2OWdRnWwpFjOhOhut
# D07xSnqhUYho9MwpqzrGFm+7/J5iAyyEg4knpdar9IOttR0Sy5j5ALl+vNOea75Y
# MMuVC7QvKAQWmx06QrbYDC5CuP1G
# SIG # End signature block
