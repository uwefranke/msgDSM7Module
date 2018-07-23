---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7PolicyInstanceListByNode

## SYNOPSIS
Gibt eine Liste PolicyInstances von Objekten zurück.

## SYNTAX

```
Get-DSM7PolicyInstanceListByNode [[-Name] <String>] [[-ID] <String>] [[-LDAPPath] <String>] [-resolvedName]
 [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Liste PolicyInstances von Objekten zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7PolicyInstanceListByNode -Name "%Computername%"
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

### -resolvedName
{{Fill resolvedName Description}}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7PolicyInstanceCountByPolicy]()

[Get-DSM7PolicyInstanceListByNode]()

[Update-DSM7PolicyInstance]()

