---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Set-DSM7VariablesOnTarget

## SYNOPSIS
Setzt eine Liste von Variablen eines Objektes.

## SYNTAX

```
Set-DSM7VariablesOnTarget [-TargetID <Int32>] [-TargetName <String>] [-LDAPPath <String>] [-Variables] <Array>
 [<CommonParameters>]
```

## DESCRIPTION
Setzt eine Liste von Variablen eines Objektes.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7ResolveVariablesForTarget -TargetID 123
```

Get-DSM7ResolveVariablesForTarget -TargetName %Computer%

## PARAMETERS

### -TargetID
{{Fill TargetID Description}}

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

### -TargetName
{{Fill TargetName Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Variables
{{Fill Variables Description}}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[Get-DSM7VariableGroups]()

[Get-DSM7ResolveVariablesForTarget]()

[Set-DSM7VariablesOnTarget]()

[Remove-DSM7VariablesOnTarget]()

