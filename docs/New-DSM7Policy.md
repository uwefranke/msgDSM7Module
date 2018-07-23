---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# New-DSM7Policy

## SYNOPSIS
Erstellt eine neue Policy.

## SYNTAX

```
New-DSM7Policy [[-SwName] <String>] [[-SwUniqueID] <String>] [[-SwLDAPPath] <String>] [[-TargetID] <Int32>]
 [[-TargetName] <String>] [[-TargetLDAPPath] <String>] [[-ActivationStartDate] <String>] [-IsActiv]
 [-IsUserPolicy] [-IsUserPolicyCurrentComputer] [-IsUserPolicyAllassociatedComputer] [-JobPolicy]
 [<CommonParameters>]
```

## DESCRIPTION
Erstellt eine neue Policy.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7Policy -SwName "Microsoft Windows Update Agent (x64)" -TargetName "Ziel" -IsActiv
```

### BEISPIEL 2
```

```

## PARAMETERS

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

### -TargetID
{{Fill TargetID Description}}

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

### -IsUserPolicyCurrentComputer
{{Fill IsUserPolicyCurrentComputer Description}}

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

### -IsUserPolicyAllassociatedComputer
{{Fill IsUserPolicyAllassociatedComputer Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobPolicy
{{Fill JobPolicy Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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

