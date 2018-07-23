---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7GroupMembers

## SYNOPSIS
Ermittelt Mitglieder einer Gruppe.

## SYNTAX

```
Get-DSM7GroupMembers [[-Name] <String>] [[-ID] <Int32>] [[-LDAPPath] <String>] [[-Filter] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Ermittelt Mitglieder einer Gruppe.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7GroupMembers -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 2
```
Get-DSM7GroupMembers -Name "Gruppe" -Filter "Name=Computername"
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

### -ID
{{Fill ID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
{{Fill Filter Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
neue Funktion ab der Version 7.2.3

## RELATED LINKS

[Get-DSM7Group]()

[New-DSM7Group]()

[Move-DSM7Group]()

[Update-DSM7Group]()

[Remove-DSM7Group]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

