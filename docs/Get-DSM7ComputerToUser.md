---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7ComputerToUser

## SYNOPSIS
Gibt die zugeordneten Benutzer zu einem Computer zurueck.

## SYNTAX

```
Get-DSM7ComputerToUser [[-ID] <Int32>] [[-Name] <String>] [[-LDAPPath] <String>] [[-UserID] <Int32>]
 [[-UserName] <String>] [[-UserUniqueID] <String>] [[-UserLDAPPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Gibt die zugeordneten Benutzer zu einem Computer zurueck.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7ComputerToUser -ID x
```

### BEISPIEL 2
```
Get-DSM7ComputerToUser -UserID x
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

### -UserID
{{Fill UserID Description}}

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

### -UserName
{{Fill UserName Description}}

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

### -UserUniqueID
{{Fill UserUniqueID Description}}

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

### -UserLDAPPath
{{Fill UserLDAPPath Description}}

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

## RELATED LINKS

[Add-DSM7ComputerToUser]()

[Remove-DSM7ComputerToUser]()

[Get-DSM7ComputerToUser]()

