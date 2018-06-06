---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Remove-DSM7Policy

## SYNOPSIS
Löscht die Policy.

## SYNTAX

```
Remove-DSM7Policy [[-ID] <String>] [[-SwName] <String>] [[-SwUniqueID] <String>] [[-SwLDAPPath] <String>]
 [[-TargetID] <Int32>] [[-TargetName] <String>] [[-TargetLDAPPath] <String>] [-ForceDelete]
 [-DeleteAssociatedPolicies] [<CommonParameters>]
```

## DESCRIPTION
Löscht die Policy.

## EXAMPLES

### BEISPIEL 1
```
Remove-DSM7Policy -ID 12345
```

### BEISPIEL 2
```
Remove-DSM7Policy -SwName "TestSoftware" -TargetName "Computername" -ForceDelete -DeleteAssociatedPolicies
```

## PARAMETERS

### -ID
{{Fill ID Description}}

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

### -ForceDelete
{{Fill ForceDelete Description}}

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

### -DeleteAssociatedPolicies
{{Fill DeleteAssociatedPolicies Description}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
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

