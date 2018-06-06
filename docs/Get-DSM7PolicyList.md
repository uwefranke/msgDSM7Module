---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7PolicyList

## SYNOPSIS
Listet Policy(s) Object auf.

## SYNTAX

```
Get-DSM7PolicyList [[-Attributes] <String>] [[-Filter] <String>] [-recursive] [<CommonParameters>]
```

## DESCRIPTION
Listet Policy(s) Object auf.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7PolicyList -Filter "(AssignedObjectId=1234)" -Attributes "AssignedObjectId"
```

## PARAMETERS

### -Attributes
{{Fill Attributes Description}}

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

### -Filter
{{Fill Filter Description}}

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

### -recursive
{{Fill recursive Description}}

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

