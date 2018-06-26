---
external help file: msgDSM7Module-help.xml
Module Name: msgdsm7module
online version:
schema: 2.0.0
---

# New-DSM7Association

## SYNOPSIS
Neue Association wird erstellt.

## SYNTAX

```
New-DSM7Association [-SchemaTag] <String> [-SourceObjectID] <Int32> [-TargetSchemaTag] <String>
 [-TargetObjectID] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Neue Association wird erstellt.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7Association -SchemaTag "Schema" -SourceObjectID 1234 -TargetSchemaTag "Schema" -TargetObjectID 1234
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSchemaTag
{{Fill TargetSchemaTag Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetObjectID
{{Fill TargetObjectID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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

[Get-DSM7AssociationList]()

[Get-DSM7AssociationschemaList]()

[New-DSM7Association]()

