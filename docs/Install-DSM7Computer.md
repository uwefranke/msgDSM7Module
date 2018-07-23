---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Install-DSM7Computer

## SYNOPSIS
Installiert den Computer neu.

## SYNTAX

```
Install-DSM7Computer [[-Name] <String>] [[-ID] <Int32>] [-RecalculateInstallationOrder]
 [-UpgradePolicyInstances] [-UpdatePolicyInstancesActive] [<CommonParameters>]
```

## DESCRIPTION
Installiert den Computer neu.

## EXAMPLES

### BEISPIEL 1
```
Install-DSM7Computer -Name "%Computername%" -UpgradePolicyInstances -RecalculateInstallationOrder -UpdatePolicyInstancesActive
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

### -RecalculateInstallationOrder
{{Fill RecalculateInstallationOrder Description}}

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

### -UpgradePolicyInstances
{{Fill UpgradePolicyInstances Description}}

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

### -UpdatePolicyInstancesActive
{{Fill UpdatePolicyInstancesActive Description}}

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

[Get-DSM7ComputerList]()

[Get-DSM7Computer]()

[Update-DSM7Computer]()

[Install-DSM7Computer]()

[New-DSM7Computer]()

[Remove-DSM7Computer]()

[Move-DSM7Computer]()

