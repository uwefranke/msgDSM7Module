---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# New-DSM7PolicyInstance

## SYNOPSIS
Erstellt eine PolicyInstance.

## SYNTAX

```
New-DSM7PolicyInstance [-PolicyID] <Int32> [-NodeId] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Erstellt eine PolicyInstance.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7PolicyInstance -PolicyID 1234 -NodeId 1234
```

## PARAMETERS

### -PolicyID
{{ Fill PolicyID Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeId
{{ Fill NodeId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
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

[Update-DSM7PolicyInstance]()

