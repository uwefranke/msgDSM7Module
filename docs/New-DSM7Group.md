---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# New-DSM7Group

## SYNOPSIS
Erstellt ein Gruppenobjekt.

## SYNTAX

```
New-DSM7Group [-Name] <String> [[-Description] <String>] [[-SchemaTag] <String>] [[-Typ] <String>]
 [[-LDAPPath] <String>] [[-ParentContID] <String>] [[-ParentDynGroup] <String>] [[-ParentDynGroupID] <Int32>]
 [[-DynamicGroupFilter] <String>] [[-ADSID] <String>] [<CommonParameters>]
```

## DESCRIPTION
Erstellt ein Gruppenobjekt.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7Group -Name "Gruppe" -SchemaTag "DynamicGroup" -LDAPPath "Managed Users & Computers/OU1" -DynamicGroupFilter "(Name=Test)"
```

### BEISPIEL 2
```
New-DSM7Group -Name "Gruppe" -SchemaTag "ExternalGroup" -LDAPPath "Managed Users & Computers/Server managed/OU1" -ADSID "S-1-5-21-xxxx"
```

### BEISPIEL 3
```
New-DSM7Group -Name "Gruppe" -Typ "User" -LDAPPath "Managed Users & Computers/OU1"
```

## PARAMETERS

### -Name
{{Fill Name Description}}

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
Default value: Group
Accept pipeline input: False
Accept wildcard characters: False
```

### -Typ
{{Fill Typ Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Computer
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
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentContID
{{Fill ParentContID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentDynGroup
{{Fill ParentDynGroup Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentDynGroupID
{{Fill ParentDynGroupID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DynamicGroupFilter
{{Fill DynamicGroupFilter Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ADSID
{{Fill ADSID Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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

[Get-DSM7Group]()

[New-DSM7Group]()

[Move-DSM7Group]()

[Update-DSM7Group]()

[Remove-DSM7Group]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

