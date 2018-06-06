---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7ExternalGroupMembers

## SYNOPSIS
Ermittelt Mitglieder einer Externalgruppe.

## SYNTAX

```
Get-DSM7ExternalGroupMembers [[-Name] <String>] [[-ID] <Int32>] [[-LDAPPath] <String>]
 [[-TargetSchemaTag] <String>] [<CommonParameters>]
```

## DESCRIPTION
Ermittelt Mitglieder einer Externalgruppe.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7ExternalGroupMembers -Name "Gruppe" -LDAPPath "Managed Users & Computers/OU1"
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
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

### -TargetSchemaTag
{{Fill TargetSchemaTag Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
veraltet

## RELATED LINKS
