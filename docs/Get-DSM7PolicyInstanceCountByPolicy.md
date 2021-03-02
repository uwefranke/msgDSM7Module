---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7PolicyInstanceCountByPolicy

## SYNOPSIS
Gibt eine Statistik von einer Policy zurueck.

## SYNTAX

```
Get-DSM7PolicyInstanceCountByPolicy [-ID] <String> [[-ComplianceState] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Statistik von einer Policy zurueck.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7PolicyInstanceCountByPolicy -ID 123456 -ComplianceState Compliant
```

## PARAMETERS

### -ID
{{Fill ID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComplianceState
{{Fill ComplianceState Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7PolicyInstanceCountByPolicy]()

[Get-DSM7PolicyInstanceListByNode]()

[Update-DSM7PolicyInstance]()

