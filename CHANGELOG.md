# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added

### Changed

* function New-DSM7Policy (create ShopPolicy)

### Fixed
## [1.0.3.10] - 2021-10-28
### Fixed

* function Get-DSM7AssociationList 
## [1.0.3.9] - 2021-09-09
### Add

* function New-DSM7PolicyInstance

## [1.0.3.8] - 2021-08-18
### Add

* function FastInstall-DSM7Computer

## [1.0.3.7] - 2021-08-17
### Changed

* function Update-DSM7PolicyInstances (uninstall)

## [1.0.3.6] - 2021-07-29
### Changed

* function Update-DSM7PolicyInstances (deactivateuntilreinsall)
## [1.0.3.5] - 2021-07-07
### Changed

* function Update-DSM7PolicyInstances (ActivationStartDate)
## [1.0.3.4] - 2021-04-16
### Added

* function Get-DSM7PolicyInstances

## [1.0.3.3] - 2021-04-16
### Fixed

* function Get-DSM7ComputerList (GenTypeData -recursive not work)
## [1.0.3.2] - 2021-03-05
### Fixed

* function Get-DSM7Software (convert to LDAP string UpdateID)
## [1.0.3.1] - 2021-03-03
### Fixed

* function Connect-DSM7Web -UseSSL 
* version .0 not work in powershellgallery
## [1.0.3.0] - 2021-03-03 (Test)
### Fixed

* function Connect-DSM7Web -UseSSL 
## [1.0.2.9] - 2021-03-03 (Test)
### Fixed

* function Connect-DSM7Web -UseSSL 
## [1.0.2.8] - 2021-03-02
### Added

* Get-DSM7Software -UpdateId  "UpdateID"
### Fixed

* add schema tag (VMWPPatchPackage) in function New-DSM7Policy
## [1.0.2.7] - 2020-12-18
### Added

* Test ivanti version DSM 2020.2 (7.4.4.0)
### Fixed

* logic error in function Copy-DSM7PolicyListNewTarget
## [1.0.2.6] - 2020-11-12

### Fixed

* Workaround error with MdsObjectSchema in DSM version 7.4.3.0 - Update-DSM7Object [issue #3](https://github.com/uwefranke/msgDSM7Module/issues/3)
## [1.0.2.5] - 2020-10-29
### Fixed

* Workaround error with MdsObjectSchema in DSN version 7.4.3.0 - Get-DSM7AssociationList
* error in function Get-DSM7GroupList not recieved ExternalGroup
## [1.0.2.4] - 2020-08-21
### Changed

* function Wakeup-DSM7Computer rename to Send-DSM7ComputerWakeUp (Alias: Wakeup-DSM7Computer) (Get-Verb waring during import)
## [1.0.2.3] - 2020-08-20

### Added

* function Wakeup-DSM7Computer [issue #1](https://github.com/uwefranke/msgDSM7Module/issues/1)

### Changed

* funktion Install-DSM7Computer -Name "xxxxxx" -Wakeup

### Fixed

* function Remove-DSM7PolicyFromTarget [issue #2](https://github.com/uwefranke/msgDSM7Module/issues/2)

## [1.0.2.2] - 2020-08-19

### Fixed

* function Get-DSM7NCPObjects

## [1.0.2.1] - 2020-08-12

### Added

* function Get-DSM7NCPObjects

### Changed
* required powershell version 5.1

## [1.0.1.19] - 2020-07-02

### Changed

* function Update-DSM7SoftwareCategory
* function New-DSM7SoftwareCategory

## [1.0.1.18] - 2020-06-09

### Added

* support DSM Version 7.4.3.0   
* function Get-DSM7NCP

## [1.0.1.17] - 2019-12-20

### Added

* function Get-DSM7UserList

### Fixed

* function internal Convert-DSM7PolicyInstanceListtoPSObject 

## [1.0.1.16] - 2019-12-04

### Added

*  function Get-DSM7PolicyInstanceListByPolicy 

### Fixed

* function Get-DSM7PolicyInstanceCountByPolicy 
* function Get-DSM7ComputerToUser 

## [1.0.1.15] - 2019-10-09

### Added

*  function Get-DSM7Permissions 

*  function Get-DSM7ComputerToUser 

## [1.0.1.14] - 2018-12-03

### Fixed

* function Get-DSM7GroupList (export)

## [1.0.1.13] - 2018-11-30

### Added

* function Get-DSM7GroupList 

## [1.0.1.12] - 2018-10-16

### Fixed

* function New-DSM7Policy (create DenyPolicy, default parameter changed)
* function Convert-DSM7PolicytoPSObject
* function Get-DSM7ListOfMemberships
* function Update-DSM7MembershipInGroups

## [1.0.1.11] - 2018-08-14

### Added

* function  Get-DSM7SwInstallationParamDefinitions

### Fixed

* function Copy-DSM7PolicyListNewTarget (New Group) 

## [1.0.1.10] - 2018-08-06

### Changed

* New-DSM7Policy (create DenyPolicy and JobPolicy)

## [1.0.1.9] - 2018-07-31

### Added

* Find-DSM7Target new internal function

### Changed

* function Get-DSM7Software (parameter -IsLastReleasedRev)
* function Copy-DSM7PolicyListNewTarget
* function Copy-DSM7Policy
* function New-DSM7Policy (new parameters)
* function Update-DSM7Policy (new parameters and options)

### Fixed

* internal function Convert-DSM7PolicytoPSObject (Null elements)

## [1.0.1.8] - 2018-07-30

### Fixed

* internal function Convert-DSM7PolicytoPSObject (SwInstallationParameter -> SwInstallationParameters)

### Changed

## [1.0.1.7] - 2018-07-27

### Changed

* function New-DSM7Policy (new with SwInstallationParams)
* function Update-DSM7Policy (new with SwInstallationParams)

### Fixed

* function Copy-DSM7Policy
* function Copy-DSM7PolicyListNewTarget

## [1.0.1.6] - 2018-07-24

### Change

* function Get-DSM7PolicyListByTarget (PolicyRestrictionList was empty)

## [1.0.1.5] - 2018-07-23

### Added

* function Move-DSM7Software

## [1.0.1.4] - 2018-07-19

### Added

* Upload to [www.powershellgallery.com](https://www.powershellgallery.com/packages/msgDSM7Module)

## [1.0.1.3] - 2018-07-11

### Fixed

* msgDSM7Module.psd1

## [1.0.1.2] - 2018-06-26

### Changed

* function Get-DSM7SoftwareIDs

## [1.0.1.1] - 2018-06-19

### Changed

* help files and Changelog.md

## [1.0.1.0] - 2018-06-14

### Fixed

* function Convert-DSM7PolicyInstanceListtoPSObject

### Changed

* function Convert-DSM7PolicytoPSObject
* function Copy-DSM7Policy
* function New-DSM7PolicyObject
* function Convert-DSM7PolicyInstancetoPSObject

### Added

* Changelog.md
* new Helpfiles /docs/*.md

## [1.0.0.80] - 2018-05-31

### Fixed

* function Update-DSM7Policy

## [1.0.0.79] - 2018-05-24

### Fixed

* function Convert-DSM7PolicyInstacetoPSObject property AssignedObjectID change since DSM 2016.2

## [1.0.0.78] - 2018-01-25

### Changed

* function New-DSM7Object (DSM 2018.1)
* function New-DSM7Computer (DSM 2018.1)
* function New-DSM7OrgTreeContainer (DSM 2018.1)
* function New-DSM7Policy (DSM 2018.1)
* function Copy-DSM7Policy (DSM 2018.1)

### Added

* variable $global:DSM7CreationSource (DSM 2018.1)

## [1.0.0.77] - 2018-01-25

### Changed

* function Get-DSM7ServerInfo (DSM 2017.1)

## [1.0.0.76] - 2017-12-13

### Changed

* function Get-DSM7GroupMembers (DSM 2017.1)

## [1.0.0.75] - 2017-11-27

### Added

* function Get-DSM7SoftwareCategoryList
* function Get-DSM7SoftwareList
* function Get-DSM7ComputerList
* function Get-DSM7ObjectList

## [1.0.0.74] - 2017-11-17

### Added

* function Get-DSM7SoftwareCategoryList
* function Get-DSM7SoftwareCategory
* function New-DSM7SoftwareCategory
* function Update-DSM7SoftwareCategory

## [1.0.0.73] - 2017-11-14

### Fixed

* function Connect-DSM7Web delete cache for reconnect

## [1.0.0.72] - 2017-08-31

### Fixed

* function Update-DSM7Software

## [1.0.0.71] - 2017-08-16

### Changed

* function New-DSM7SoftwareCategory for APM

## [1.0.0.70] - 2017-07-11

### Added

* function Get-DSM7LADPPath for export

## [1.0.0.69] - 2017-06-19

### Fixed

* function Update-DSM7Object

## [1.0.0.68] - 2017-06-14

### Fixed

* function New-DSM7Policy
* function Remove-DSM7PolicyFromTarget

## [1.0.0.67] - 2017-06-12

### Fixed

* function DisConnect-DSM7Web

## [1.0.0.66] - 2017-06-09

### Changed

* function Update-DSM7Object
* function Connect-DSM7Web

## [1.0.0.65] - 2017-05-03

### Added

* fuction Remove-DSM7TargetFromPolicy

## [1.0.0.64] - 2017-03-30

### Changed

* function Get-DSM7ObjectList

## [1.0.0.63] - 2017-03-17

### Fixed

* function Get-DSM7AssociationList

## [1.0.0.62] - 2017-03-10

### Fixed

* function Get-DSM7ComputerList for version DSM 2016.2.1

## [1.0.0.61] - 2017-01-30

### Fixed

* function Add-DSM7TargetToPolicy
* function New-DSM7Policy
* Help file

## [1.0.0.60] - 2017-01-27

### Fixed

* function Convert-DSM7PolicyInstaceListtoPSObject

## [1.0.0.59] - 2017-01-25

### Fixed

* function Get-DSM7ObjectList

## [1.0.0.58] - 2017-01-20

### Added

* function Get-DSM7SoftwareCategory
* function New-DSM7SoftwareCategory
* function Update-DSM7SoftwareCategory
* function Remove-DSM7SoftwareCategory
* function Remove-DSM7Group

### Changed

* SwCategory
* function Get-DSM7GroupMembers
* function Get-DSM7ListOfMemberships
* function Update-DSM7MembershipInGroups
* function Update-DSM7MemberListOfGroup

## [1.0.0.57] - 2017-01-18

### Fixed

* version dependences

## [1.0.0.56] - 2017-01-16

### Added

* function Get-DSM7User
* function Add-DSM7ComputerToUser
* function Remove-DSM7ComputerToUser

## [1.0.0.55] - 2017-01-10

### Changed

* support for DSM 2016.2.1 (7.3.2)
* function Get-DSM7AssociationsObjectchemaList
* function Get-DSM7AssociationList
* function New-DSM7Association

## [1.0.0.54] - 2016-12-20

### Added

* function Get-DSM7VariableGroups
* function Get-DSM7ResolveVariablesForTarget
* function Set-DSM7VariablesOnTarget
* function Remove-DSM7VariablesOnTarget

## [1.0.0.53] - 2016-12-15

### Changed

* support for DSM 2016.2.1 (7.3.2)
* function Get-DSM7GroupMembersObject

## [1.0.0.52] - 2016-11-24

### Fixed

* fuction Convert-DSM7PolicyInstaceListtoPSObject - Deny Policy no property Config

## [1.0.0.51] - 2016-08-26

### Fixed

* function Update-DSM7MembershipInGroups
* function Update-DSM7MemberListOfGroup

## [1.0.0.50] - 2016-08-25

### Fixed

* function Get-DSM7SoftwareList
* function Get-DSM7ComputerList

## [1.0.0.49] - 2016-08-08

### Added

* function Remove-Log

### Fixed

* function Get-DSM7SoftwareList
* function Get-DSM7ComputerList

## [1.0.0.48] - 2016-03-23

### Fixed

* function Convert-DSM7PolicyListtoPSObject

## [1.0.0.47] - 2016-03-01

### Fixed

* function Remove-DSM7Policy
* function Get-DSM7Group

## [1.0.0.46] - 2016-02-18

### Added

* function Get-DSM7OrgTreeContainers
* function Get-DSM7Objects

### Fixed

* function New-DSM7Policy

## [1.0.0.45] - 2016-02-17

### Added

* function Move-DSM7Group

## [1.0.0.44] - 2016-02-16

### Changed

* function Update-DSM7Policy
* function Get-DSM7Policy
* function Convert-DSM7PolicytoPSObject

## [1.0.0.43] - 2016-01-27

### Added

* function Get-DSM7SwInstallationConfigurations

### Fixed

* function Update-DSM7PolicyInstances

## [1.0.0.42] - 2016-01-12

### Changed

* support for version DSM 7.3
* function Update-DSM7PolicyObject
* function Remove-DSM7PolicyObject
* function New-DSM7Policy
* function Update-DSM7PolicyInstances
* function Install-DSM7ReinstallComputer

## [1.0.0.41] - 2015-11-12

### Changed

* function Copy-DSM7PolicyListNewTarget
* function Copy-DSM7Policy

## [1.0.0.40] - 2015-11-12

### Changed

* function Write-Host for Ochestrator
* function Update-DSM7PolicyInstances

## [1.0.0.39] - 2015-10-27

### Changed

* function Remove-DSM7Policy

## [1.0.0.38] - 2015-09-30

### Changed

* function Get-DSM7Object

## [1.0.0.37] - 2015-09-23

### Changed

* for DSM CallScript

## [1.0.0.36] - 2015-08-25

### Added

* function Confirm-Connect

## [1.0.0.35] - 2015-08-19

### Changed

* function Update-DSM7Policy

## [1.0.0.34] - 2015-08-10

### Changed

* help for group functions

## [1.0.0.33] - 2015-07-28

### Changed

* function New-DSM7Computer

## [1.0.0.32] - 2015-07-09

### Fixed

* function Get-DSM7SoftwareList

## [1.0.0.31] - 2015-07-08

### Fixed

* group functions with empty

## [1.0.0.30] - 2015-06-19

### Added

* function Update-DSM7Software

## [1.0.0.29] - 2015-06-17

### Added

* new objects version DSM 7.2.3
* function Get-DSM7GroupMembers replaced Get-DSM7ComputerGroupMembers
* function Get-DSM7ListOfMemberships replaced Get-DSM7ComputerInGroups
* function Get-DSM7GroupMembers replaced Get-DSM7ExternalGroupMembers
* function Update-DSM7MembershipInGroups
* function Update-DSM7MemberListOfGroup

## [1.0.0.28] - 2015-06-08

### Fixed

* function Get-DSM7Group

### Added

* function Connect-DSM7WebRandom

## [1.0.0.27] - 2015-06-05

### Fixed

* function Connect-DSM7Web

## [1.0.0.26] - 2015-03-19

### Added

* function Confirm-Creds
* function Convert-ArrayToHash

## [1.0.0.25] - 2015-03-12

### Fixed

* Powershell version required, error with array

## [1.0.0.24] - 2015-03-11

### Fixed

* LDAPPATH

## [1.0.0.23] - 2015-03-10

### Fixed

* Credential

## [1.0.0.22] - 2015-02-20

### Added

* function PSCredential
* function Get-DSM7ExternalGroupMembers

## [1.0.0.21] - 2014-12-05

### Added

*function Copy-DSM7PolicyListNewTarget

## [1.0.0.20] - 2014-11-07

### Added

* function Update-DSM7Group

## [1.0.0.19] - 2014-10-22

### Added

* function Remove-DSM7PolicyInstance

## [1.0.0.18] - 2014-09-24

### Added

* function Get-DSM7PolicyListByTarget

## [1.0.0.17] - 2014-07-29

### Added

* object PolicyInstance

## [1.0.0.16] - 2014-05-27

### Changed

* function Get-DSM7ComputerInGroups

## [1.0.0.15] - 2014-05-26

### Fixed

* function Update-DSM7Computer retrun value

## [1.0.0.14] - 2014-05-26

### Fixed

* function Update-DSM7Computer - value description

## [1.0.0.12] - 2013-06-17

### Added

* function Get-DSM7SwInstallationParamDefinitions

## [1.0.0.11] - 2013-06-17

### Changed

* function Move-DSM7Computer

## [1.0.0.10] - 2013-05-23

### Added

* function Get-DSM7PolicyStatisticsByTarget

## [1.0.0.9] - 2013-04-22

### Changed

* function Get-DSM7SoftwareList

## [1.0.0.8] - 2013-04-09

### Fixed

* function Get-DSM7SoftwareList

## [1.0.0.7] - 2013-04-03

### Added

* function Update-DSM7Group
* function Move-DSM7Group

## [1.0.0.6] - 2013-04-02

### Fixed

* time offset

## [1.0.0.5] - 2013-03-28

### Changed

* all group functions

### Added

* function New-DSM7Group

## [1.0.0.4] - 2013-03-27

### Changed

* all container functions

## [1.0.0.3] - 2013-03-27

### Changed

* all computer object functions

## [1.0.0.2] - 2013-03-26

### Added

* structurobjects

## [1.0.0.1] - 2013-03-25

### Fixed

* objectlist

## [1.0.0.0] - 2013-01-10

* Intitial
