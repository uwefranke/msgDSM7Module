---
external help file: msgDSM7Module-help.xml
Module Name: msgdsm7module
online version:
schema: 2.0.0
---

# Update-DSM7Policy

## SYNOPSIS
Ändert ein Policy Object aus.

## SYNTAX

```
Update-DSM7Policy [[-ID] <Int32>] [[-SwName] <String>] [[-SwUniqueID] <String>] [[-SwLDAPPath] <String>]
 [[-TargetName] <String>] [[-TargetLDAPPath] <String>] [[-ActivationStartDate] <String>] [-IsActiv]
 [-IsUserPolicy] [[-Parameter] <String>] [[-PolicyRestrictionType] <String>] [[-PolicyRestrictionList] <Array>]
 [<CommonParameters>]
```

## DESCRIPTION
Ändert ein Policy Object aus.

## EXAMPLES

### BEISPIEL 1
```
Update-DSM7Policy -ID xxx -PolicyRestrictionList (yyy,zzz) -PolicyRestrictionType Include -IsActiv
```

### BEISPIEL 2
```
Update-DSM7Policy -SwUniqueID "{A42DB21A-D859-4789-BD1C-FC5B5C61EA27}" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
```

### BEISPIEL 3
```
Update-DSM7Policy -SwName "Software" -IsActiv -ActivationStartDate "22:00 01.01.1970" -TargetName "Ziel"
```

## PARAMETERS

### -ID
{{Fill ID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SwName
{{Fill SwName Description}}

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

### -SwUniqueID
{{Fill SwUniqueID Description}}

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

### -SwLDAPPath
{{Fill SwLDAPPath Description}}

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

### -TargetName
{{Fill TargetName Description}}

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

### -TargetLDAPPath
{{Fill TargetLDAPPath Description}}

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

### -ActivationStartDate
{{Fill ActivationStartDate Description}}

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

### -IsActiv
{{Fill IsActiv Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsUserPolicy
{{Fill IsUserPolicy Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameter
{{Fill Parameter Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyRestrictionType
{{Fill PolicyRestrictionType Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PolicyRestrictionList
{{Fill PolicyRestrictionList Description}}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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

[Get-DSM7PolicyList]()

[Get-DSM7Policy]()

[Remove-DSM7Policy]()

[New-DSM7Policy]()

[Add-DSM7PolicyToTarget]()

[Move-DSM7PolicyToTarget]()

[Update-DSM7Policy]()

[Get-DSM7PolicyListByTarget]()

[Get-DSM7PolicyListByAssignedSoftware]()

[Copy-DSM7PolicyListNewTarget]()

[Get-DSM7PolicyStatisticsByTarget]()

[Get-DSM7PolicyStatistics]()

