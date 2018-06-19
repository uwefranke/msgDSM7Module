---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7module
online version:
schema: 2.0.0
---

# Get-DSM7Group

## SYNOPSIS
Gibt ein Gruppenobjekt zurück.

## SYNTAX

```
Get-DSM7Group [[-Name] <String>] [[-ID] <Int32>] [[-LDAPPath] <String>] [[-ParentContID] <String>]
 [[-ParentDynGroup] <String>] [[-ParentDynGroupID] <String>] [[-ADSID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gibt ein Gruppenobjekt zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7Group -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 2
```
Get-DSM7Group -Name "Gruppe" -ParentDynGroup "Gruppe"
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

### -ParentContID
{{Fill ParentContID Description}}

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

### -ParentDynGroup
{{Fill ParentDynGroup Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentDynGroupID
{{Fill ParentDynGroupID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ADSID
{{Fill ADSID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7Group]()

[New-DSM7Group]()

[Move-DSM7Group]()

[Update-DSM7Group]()

[Remove-DSM7Group]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Add-DSM7ComputerToGroup]()

[Remove-DSM7ComputerFromGroup]()

