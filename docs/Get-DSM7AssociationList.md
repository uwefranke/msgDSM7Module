---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7AssociationList

## SYNOPSIS
Gibt eine Liste von Association zurück.

## SYNTAX

```
Get-DSM7AssociationList [-SchemaTag] <String> [-SourceObjectID <String>] [-TargetObjectID <String>]
 [-TargetSchemaTag <String>] [-resolvedName] [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Liste von Association zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7AssociationList -SchemaTag "ComputerAssociatedUser"
```

## PARAMETERS

### -SchemaTag
{{Fill SchemaTag Description}}

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

### -SourceObjectID
{{Fill SourceObjectID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetObjectID
{{Fill TargetObjectID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSchemaTag
{{Fill TargetSchemaTag Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *
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

[Get-DSM7AssociationList]()

[Get-DSM7AssociationschemaList]()

[New-DSM7Association]()

