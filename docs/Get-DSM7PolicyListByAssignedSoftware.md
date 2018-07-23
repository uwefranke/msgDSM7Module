---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7PolicyListByAssignedSoftware

## SYNOPSIS
Ermittelt die Policys einer Software.

## SYNTAX

```
Get-DSM7PolicyListByAssignedSoftware [[-Name] <String>] [[-ID] <String>] [[-LDAPPath] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Ermittelt die Policys einer Software.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7PolicyListByAssignedSoftware -ID 1234
```

### BEISPIEL 2
```
Get-DSM7PolicyListByAssignedSoftware -Name "Software" -$LDAPPath "Global Software Library/SWF1"
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
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
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

[Get-DSM7PolicyList]()

[Get-DSM7Policy]()

[Remove-DSM7Policy]()

[New-DSM7Policy]()

[Add-DSM7PolicyToTarget]()

[Move-DSM7PolicyToTarget]()

[Update-DSM7Policy]()

[Get-DSM7PolicyListByTarget]()

[Get-DSM7PolicyListByAssignedSoftware]()

[Copy-DSM7PolicyListNewTarget]()

[Get-DSM7PolicyStatisticsByTarget]()

[Get-DSM7PolicyStatistics]()

