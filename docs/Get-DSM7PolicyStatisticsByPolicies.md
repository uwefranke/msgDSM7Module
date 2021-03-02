---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7PolicyStatisticsByPolicies

## SYNOPSIS
Gibt eine Statistik von einer Software zurueck.

## SYNTAX

```
Get-DSM7PolicyStatisticsByPolicies [-IDs] <Array> [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Statistik von einer Software zurueck.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7PolicyStatisticsByTarget -Name "Software" -LDAPPath "Global Software Library/SwFolder1/SwFolder2"
```

## PARAMETERS

### -IDs
{{Fill IDs Description}}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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

[Get-DSM7PolicyList]()

[Remove-DSM7Policy]()

[New-DSM7Policy]()

[Copy-DSM7Policy]()

[Add-DSM7PolicyToTarget]()

[Move-DSM7PolicyToTarget]()

[Update-DSM7Policy]()

[Get-DSM7PolicyListByTarget]()

[Get-DSM7PolicyListByAssignedSoftware]()

[Copy-DSM7PolicyListNewTarget]()

[Get-DSM7PolicyStatisticsByTarget]()

[Get-DSM7PolicyStatistics]()

