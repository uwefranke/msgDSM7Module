---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7SwInstallationParamDefinitions

## SYNOPSIS
Gibt von einem Softwarepaket die Parameter Definition zurueck.

## SYNTAX

```
Get-DSM7SwInstallationParamDefinitions [[-Name] <String>] [[-UniqueID] <String>] [[-ID] <Int32>]
 [[-LDAPPath] <String>] [[-Values] <String[]>] [-resolvedName] [-LDAP] [<CommonParameters>]
```

## DESCRIPTION
Gibt von einem Softwarepaket die Parameter Definition zurueck.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7SwInstallationParamDefinitions -ID 1234
```

### BEISPIEL 2
```
Get-DSM7SwInstallationParamDefinitions -Name "Softwarekategorie" -LDAPPath "Global Software Library/Application Library"
```

## PARAMETERS

### -Name
{{Fill Name Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniqueID
{{Fill UniqueID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
{{Fill ID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LDAPPath
{{Fill LDAPPath Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Values
{{Fill Values Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolvedName
{{Fill resolvedName Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LDAP
{{Fill LDAP Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7SoftwareList]()

[Get-DSM7SoftwareIDs]()

[Get-DSM7Software]()

[Update-DSM7Software]()

[Move-DSM7Software]()

[Get-DSM7SwInstallationParamDefinitions]()

[Get-DSM7SoftwareCategoryList]()

[Get-DSM7SoftwareCategory]()

[New-DSM7SoftwareCategory]()

[Update-DSM7SoftwareCategory]()

[Remove-DSM7SoftwareCategory]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

