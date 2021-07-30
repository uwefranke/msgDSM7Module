---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Update-DSM7PolicyInstances

## SYNOPSIS
aendert eine PolicyInstances.

## SYNTAX

```
Update-DSM7PolicyInstances [-IDs] <Object> [[-ActivationStartDate] <String>] [-active]
 [-deactivateuntilreinsall] [-reinstall] [<CommonParameters>]
```

## DESCRIPTION
aendert eine PolicyInstances.

## EXAMPLES

### BEISPIEL 1
```
Update-DSM7PolicyInstances -ID 12345,65141 -active
```

### BEISPIEL 2
```
Update-DSM7PolicyInstances -ID 12345,65141 -reinstall
```

### BEISPIEL 3
```
Update-DSM7PolicyInstances -ID 12345,65141 -ActivationStartDate %date%
```

### BEISPIEL 4
```
Update-DSM7PolicyInstances -ID 12345,65141 -deactivateuntilreinsall
```

## PARAMETERS

### -IDs
{{ Fill IDs Description }}

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

### -ActivationStartDate
{{ Fill ActivationStartDate Description }}

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

### -active
{{ Fill active Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -deactivateuntilreinsall
{{ Fill deactivateuntilreinsall Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -reinstall
{{ Fill reinstall Description }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7PolicyInstanceCountByPolicy]()

[Get-DSM7PolicyInstanceListByNode]()

[Update-DSM7PolicyInstances]()

