---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Get-DSM7User

## SYNOPSIS
Gibt das Benutzerobjekt zurück.

## SYNTAX

```
Get-DSM7User [[-ID] <Int32>] [[-Name] <String>] [[-UniqueID] <String>] [[-LDAPPath] <String>] [-LDAP]
 [<CommonParameters>]
```

## DESCRIPTION
Gibt das Benutzerobjekt zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7User -Name "%Benutzer%"
```

### BEISPIEL 2
```
Get-DSM7User -ID 1234
```

### BEISPIEL 3
```
Get-DSM7User -UniqueID %SID%
```

### BEISPIEL 4
```
Get-DSM7User -Name "%Benutzer%" -LDAPPath "Managed Users & Computers/domäne/loc/Benutzer"
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UniqueID
{{Fill UniqueID Description}}

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

### -LDAP
{{Fill LDAP Description}}

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

[Get-DSM7User]()

