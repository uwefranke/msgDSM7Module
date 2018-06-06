---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Remove-Log

## SYNOPSIS
eigene Log Funktion

## SYNTAX

```
Remove-Log [-Logpath] <String> [-Logname] <String> [-CountLogFiles <Int32>] [-DaysLogFilesAge <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
eigene Log Funktion

## EXAMPLES

### BEISPIEL 1
```
Remove-Log -CountLogFiles 10 -DaysLogFilesAge 30 -Logpath "c:\Logs" -Logname "Test"
```

## PARAMETERS

### -Logpath
{{Fill Logpath Description}}

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

### -Logname
{{Fill Logname Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CountLogFiles
{{Fill CountLogFiles Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DaysLogFilesAge
{{Fill DaysLogFilesAge Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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

[Write-Log]()

[Remove-Log]()

