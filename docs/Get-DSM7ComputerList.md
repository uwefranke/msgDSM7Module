---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7ComputerList

## SYNOPSIS
Gibt eine Liste von Computern zurück.

## SYNTAX

```
Get-DSM7ComputerList [[-Attributes] <String>] [[-Filter] <String>] [[-LDAPPath] <String>]
 [[-ParentContID] <Int32>] [-GenTypeData] [-recursive] [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Liste von Computern zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7ComputerList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
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

### -ParentContID
{{Fill ParentContID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenTypeData
{{Fill GenTypeData Description}}

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

[Get-DSM7ComputerList]()

[Get-DSM7Computer]()

[Update-DSM7Computer]()

[Install-DSM7Computer]()

[New-DSM7Computer]()

[Remove-DSM7Computer]()

[Move-DSM7Computer]()

