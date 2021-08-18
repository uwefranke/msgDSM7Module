---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Send-DSM7ComputerFastInstall

## SYNOPSIS
FastInstall f ¼r den Computer oder PolicyInstanzen.

## SYNTAX

```
Send-DSM7ComputerFastInstall [[-Name] <String>] [[-ID] <Int32>] [[-PolicyInstanceIDs] <Array>]
 [[-ExecutionContext] <String>] [-IgnoreMaintenanceWindow] [-ShutdownAfterInstallation] [<CommonParameters>]
```

## DESCRIPTION
FastInstall f ¼r den Computer oder PolicyInstanzen.

## EXAMPLES

### BEISPIEL 1
```
Send-DSM7ComputerFastInstall -Name "%Computername%"
```

### BEISPIEL 2
```
Send-DSM7ComputerFastInstall -Name "%Computername%" -PolicyInstanceIDs 1,2,3,4
```

### BEISPIEL 3
```
Send-DSM7ComputerFastInstall -Name "%Computername%" -IgnoreMaintenanceWindow
```

### BEISPIEL 4
```
Send-DSM7ComputerFastInstall -Name "%Computername%" -ShutdownAfterInstallation
```

## PARAMETERS

### -Name
{{ Fill Name Description }}

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
{{ Fill ID Description }}

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

### -PolicyInstanceIDs
{{ Fill PolicyInstanceIDs Description }}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExecutionContext
{{ Fill ExecutionContext Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Auto
Accept pipeline input: False
Accept wildcard characters: False
```

### -IgnoreMaintenanceWindow
{{ Fill IgnoreMaintenanceWindow Description }}

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

### -ShutdownAfterInstallation
{{ Fill ShutdownAfterInstallation Description }}

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

[Get-DSM7ComputerList]()

[Get-DSM7Computer]()

[Update-DSM7Computer]()

[Install-DSM7Computer]()

[New-DSM7Computer]()

[Remove-DSM7Computer]()

[Move-DSM7Computer]()

[WakeUp-DSM7Computer]()

[Send-DSM7ComputerFastInstall]()

