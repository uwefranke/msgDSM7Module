---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# New-DSM7SoftwareCategory

## SYNOPSIS
Erstellt eine Softwarekategorie.

## SYNTAX

```
New-DSM7SoftwareCategory [-Name] <String> [[-Description] <String>] [[-SchemaTag] <String>]
 [[-LDAPPath] <String>] [[-ParentContID] <String>] [[-ParentDynGroup] <String>] [[-Filter] <String>]
 [-resolvedName] [-lastCat] [-PatchLink] [<CommonParameters>]
```

## DESCRIPTION
Erstellt eine Softwarekategorie.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7SoftwareCategory -Name "Softwarekategorie" -Typ "User" -LDAPPath "Global Software Library/Application Library"
```

### BEISPIEL 2
```
New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "DynamicSwCategory" -LDAPPath "Global Software Library/Application Library" -Filter "(Name=Test)"
```

### BEISPIEL 3
```
New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "PatchMgmtRuleFilter"
```

### BEISPIEL 4
```
New-DSM7SoftwareCategory -Name "Softwarekategorie" -SchemaTag "DynamicPatchMgmtRuleFilter" -Filter "(Name=Test)"
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
Default value: SwCategory
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
Position: 4
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

### -Filter
{{Fill Filter Description}}

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

### -resolvedName
{{Fill resolvedName Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastCat
{{Fill lastCat Description}}

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

### -PatchLink
{{Fill PatchLink Description}}

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

[Get-DSM7SoftwareList]()

[Get-DSM7SoftwareIDs]()

[Get-DSM7Software]()

[Update-DSM7Software]()

[Move-DSM7Software]()

[Get-DSM7SoftwareCategoryList]()

[Get-DSM7SoftwareCategory]()

[New-DSM7SoftwareCategory]()

[Update-DSM7SoftwareCategory]()

[Remove-DSM7SoftwareCategory]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

