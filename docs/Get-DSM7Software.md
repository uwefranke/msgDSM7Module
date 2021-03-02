---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7Software

## SYNOPSIS
Gibt ein Software Objekt zurueck.

## SYNTAX

```
Get-DSM7Software [[-ID] <Int32>] [[-Name] <String>] [[-UniqueID] <String>] [[-UpdateID] <String>]
 [[-LDAPPath] <String>] [-IsLastReleasedRev] [<CommonParameters>]
```

## DESCRIPTION
Gibt ein Software Objekt zurueck.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7Software -Name "Software" -LDAPPath ""Global Software Library/SWF1"
```

## PARAMETERS

### -ID
{{Fill ID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
{{Fill Name Description}}

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

### -UniqueID
{{Fill UniqueID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateID
{{Fill UpdateID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
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

### -IsLastReleasedRev
{{Fill IsLastReleasedRev Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

[Get-DSM7SoftwareCategoryList]()

[Get-DSM7SoftwareCategory]()

[New-DSM7SoftwareCategory]()

[Update-DSM7SoftwareCategory]()

[Remove-DSM7SoftwareCategory]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

