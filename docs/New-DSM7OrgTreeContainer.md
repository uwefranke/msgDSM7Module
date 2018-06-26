---
external help file: msgDSM7Module-help.xml
Module Name: msgdsm7module
online version:
schema: 2.0.0
---

# New-DSM7OrgTreeContainer

## SYNOPSIS
Erstellt ein Containerobjekt.

## SYNTAX

```
New-DSM7OrgTreeContainer [-Name] <String> [[-Description] <String>] [[-SchemaTag] <String>]
 [-LDAPPath] <String> [<CommonParameters>]
```

## DESCRIPTION
Erstellt ein Containerobjekt.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7OrgTreeContainer -Name "OU2" -LDAPPATH "Managed Users & Computers/OU1"
```

## PARAMETERS

### -Name
Name der OU

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

### -Description
{{Fill Description Description}}

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

### -SchemaTag
{{Fill SchemaTag Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: OU
Accept pipeline input: False
Accept wildcard characters: False
```

### -LDAPPath
{{Fill LDAPPath Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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

[Get-DSM7OrgTreeContainer]()

[New-DSM7OrgTreeContainer]()

[Move-DSM7OrgTreeContainer]()

[Remove-DSM7OrgTreeContainer]()

[Update-DSM7OrgTreeContainer]()

