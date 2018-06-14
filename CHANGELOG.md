# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

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

## [1.0.0.80](archive/1.0.0.80.zip) - 2018-05-31

### Fixed

* function Update-DSM7Policy 

## [1.0.0.79] - 2018-05-24

### Fixed

* function Convert-DSM7PolicyInstacetoPSObject proerty AssignedObjectID change since DSM 2016.2

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

## [1.0.0.41] - 2015-
## [1.0.0.40] - 2015-
## [1.0.0.39] - 2015-
## [1.0.0.38] - 2015-
## [1.0.0.37] - 2015-
## [1.0.0.36] - 2015-
## [1.0.0.35] - 2015-
## [1.0.0.34] - 2015-
## [1.0.0.33] - 2015-
## [1.0.0.32] - 2015-
## [1.0.0.31] - 2015-
## [1.0.0.30] - 2015-
## [1.0.0.29] - 2015-
## [1.0.0.28] - 2015-
## [1.0.0.27] - 2015-
## [1.0.0.26] - 2015-
## [1.0.0.25] - 2015-
## [1.0.0.24] - 2015-
## [1.0.0.23] - 2015-
## [1.0.0.22] - 2015-
## [1.0.0.21] - 2014-
## [1.0.0.20] - 2014-
## [1.0.0.19] - 2014-
## [1.0.0.18] - 2014-
## [1.0.0.17] - 2014-
## [1.0.0.16] - 2014-
## [1.0.0.15] - 2014-
## [1.0.0.14] - 2014-
## [1.0.0.12] - 2013-
## [1.0.0.11] - 2013-
## [1.0.0.10] - 2013-
## [1.0.0.9] - 2013-
## [1.0.0.8] - 2013-
## [1.0.0.7] - 2013-
## [1.0.0.6] - 2013-
## [1.0.0.5] - 2013-
## [1.0.0.4] - 2013-
## [1.0.0.3] - 2013-
## [1.0.0.2] - 2013-
## [1.0.0.1] - 2013-
## [1.0.0.0] - 2013-01-17

* Intitial



