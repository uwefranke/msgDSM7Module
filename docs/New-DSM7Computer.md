---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# New-DSM7Computer

## SYNOPSIS
Legt ein neues Computerobjekt an.

## SYNTAX

```
New-DSM7Computer [[-Name] <String>] [[-LDAPPath] <String>] [[-ParentContID] <Int32>] [[-Values] <String[]>]
 [[-InitialMACAddress] <String>] [<CommonParameters>]
```

## DESCRIPTION
Legt ein neues Computerobjekt an.

## EXAMPLES

### BEISPIEL 1
```
New-DSM7Computer -Name "%Computername%" -LDAPPath "Managed Users & Computers/OU1/OU2" -InitialMACAddress "012345678912" -Values @("Computer.ComputerType=Server","Description=Test123")
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

### -LDAPPath
{{Fill LDAPPath Description}}

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

### -ParentContID
{{Fill ParentContID Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Values
{{Fill Values Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InitialMACAddress
{{Fill InitialMACAddress Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

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

