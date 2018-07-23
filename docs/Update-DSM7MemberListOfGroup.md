---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Update-DSM7MemberListOfGroup

## SYNOPSIS
Ändert eine oder mehrere Objekte zu einer Gruppe.

## SYNTAX

```
Update-DSM7MemberListOfGroup [[-Name] <String>] [[-ID] <Int32>] [[-LDAPPath] <String>] [-AddObjectIDs <Object>]
 [-AddObjectNames <Object>] [-RemoveObjectIDs <Object>] [-RemoveObjectNames <Object>] [<CommonParameters>]
```

## DESCRIPTION
Ändert eine oder mehrere Objekte zu einer Gruppe.

## EXAMPLES

### BEISPIEL 1
```
Update-DSM7MembershipInGroups -Name "Gruppe" -AddObjectNames "Computername1,Computername2" -RemoveObjectNames "Computername1,Computername2" -LDAPPath "Managed Users & Computers/OU1"
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

### -AddObjectIDs
{{Fill AddObjectIDs Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AddObjectNames
{{Fill AddObjectNames Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveObjectIDs
{{Fill RemoveObjectIDs Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveObjectNames
{{Fill RemoveObjectNames Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

