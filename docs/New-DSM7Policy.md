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
New-DSM7Policy [[-SwName] <String>] [[-SwID] <Int32>] [[-SwUniqueID] <String>] [[-SwUpdateID] <String>]
 [[-SwLDAPPath] <String>] [[-SwInstallationParams] <Array>] [[-TargetID] <Int32>] [[-TargetName] <String>]
 [[-TargetLDAPPath] <String>] [[-TargetParentContID] <Int32>] [[-ActivationStartDate] <String>]
 [[-Priority] <Int32>] [[-MaintenanceBehavior] <Int32>] [[-WakeUpTimeSpan] <Int32>]
 [[-MaxPreStagingTime] <Int32>] [[-MinPreStagingTime] <Int32>] [-IsActiv] [-IsUserPolicy]
 [-IsUserPolicyCurrentComputer] [-IsUserPolicyAllassociatedComputer] [-JobPolicy] [[-JobPolicyTrigger] <Int32>]
 [-DenyPolicy] [-Pilot] [[-InstanceActivationOnCreate] <String>] [[-InstanceActivationMode] <String>] [-Stats]
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
New-DSM7Policy -UpdateID "ARDC-210215:AcroRdrDCUpd2100120138.msp:Adobe Acrobat Reader DC 21:0407" -TargetName "Ziel" -IsActiv
```

### BEISPIEL 3
```
New-DSM7Policy -swid 12345 -TargetID 54321 -IsActiv -SwInstallationParams ("BootEnvironmentType=1234","UILanguage=en-us")
```

### BEISPIEL 4
```
New-DSM7Policy -IsActiv -TargetID 54321 -SwUniqueID "{4F3BB3DB-F1F3-4ACA-A7B6-F8CA57FD20F1}" -JobPolicy -JobPolicyTrigger 10
```

### BEISPIEL 5
```
New-DSM7Policy -IsActiv -TargetID 54321 -SwUniqueID "{D4128974-088B-4395-B326-5A9DBBCE9DFD}" -DenyPolicy
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

### -SwID
{{Fill SwID Description}}

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

### -SwUpdateID
{{Fill SwUpdateID Description}}

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

### -SwInstallationParams
{{Fill SwInstallationParams Description}}

```yaml
Type: Array
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

### -TargetParentContID
{{Fill TargetParentContID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
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

### -Priority
{{Fill Priority Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 1000
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaintenanceBehavior
{{Fill MaintenanceBehavior Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 2
Accept pipeline input: False
Accept wildcard characters: False
```

### -WakeUpTimeSpan
{{Fill WakeUpTimeSpan Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 240
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxPreStagingTime
{{Fill MaxPreStagingTime Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 365
Accept pipeline input: False
Accept wildcard characters: False
```

### -MinPreStagingTime
{{Fill MinPreStagingTime Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 365
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

### -JobPolicyTrigger
{{Fill JobPolicyTrigger Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DenyPolicy
{{Fill DenyPolicy Description}}

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

### -Pilot
{{Fill Pilot Description}}

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

### -InstanceActivationOnCreate
{{Fill InstanceActivationOnCreate Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: CreateActive
Accept pipeline input: False
Accept wildcard characters: False
```

### -InstanceActivationMode
{{Fill InstanceActivationMode Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: DontAutoactivate
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stats
{{Fill Stats Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
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

