---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7module
online version:
schema: 2.0.0
---

# Get-DSM7Objects

## SYNOPSIS
Gibt eine Liste von Objekten zurück.

## SYNTAX

```
Get-DSM7Objects [-IDs] <Array> [-ObjectGroupType <String>] [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Liste von Objekten zurück.
Nur benutzen wenn man die Objektstruktur genau kennt!!!

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7Objects -IDs (1,2,3)
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

### -ObjectGroupType
{{Fill ObjectGroupType Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Object
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7ObjectList]()

[Get-DSM7Object]()

[Get-DSM7Objects]()

