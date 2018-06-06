---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Update-DSM7PolicyInstances

## SYNOPSIS
Ändert eine PolicyInstances.

## SYNTAX

```
Update-DSM7PolicyInstances [-IDs] <Object> [-active] [-reinstall] [<CommonParameters>]
```

## DESCRIPTION
Ändert eine PolicyInstances.

## EXAMPLES

### BEISPIEL 1
```
Update-DSM7PolicyInstances -ID 123456,65141 -active
```

### BEISPIEL 2
```
Update-DSM7PolicyInstances -ID 123456,65141 -reinstall
```

## PARAMETERS

### -IDs
{{Fill IDs Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -active
{{Fill active Description}}

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

### -reinstall
{{Fill reinstall Description}}

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

[Get-DSM7PolicyInstanceCountByPolicy]()

[Get-DSM7PolicyInstanceListByNode]()

[Update-DSM7PolicyInstances]()

