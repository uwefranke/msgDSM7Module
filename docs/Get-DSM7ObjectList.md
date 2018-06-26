---
external help file: msgDSM7Module-help.xml
Module Name: msgdsm7module
online version:
schema: 2.0.0
---

# Get-DSM7ObjectList

## SYNOPSIS
Gibt eine Liste von Objekten zurück.

## SYNTAX

```
Get-DSM7ObjectList [[-Attributes] <String>] [[-Filter] <String>] [[-LDAPPath] <String>] [[-LDAProot] <String>]
 [[-ParentContID] <Int32>] [-GenTypeData] [-recursive] [<CommonParameters>]
```

## DESCRIPTION
Gibt eine Liste von Objekten zurück.

## EXAMPLES

### BEISPIEL 1
```
Get-DSM7ObjectList -LDAPPath "Managed Users & Computers/OU1/OU2" -recursive
```

### BEISPIEL 2
```
" -Filter "(&(Name=Windows 10 \(x64\))(PatchCa
```

tegoryObject.RequiredLicense=DSM7_LUMENSION_PATCH))" -Attributes "PatchCategoryObject.RequiredLicense"

## PARAMETERS

### -Attributes
{{Fill Attributes Description}}

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

### -Filter
{{Fill Filter Description}}

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

### -LDAPPath
{{Fill LDAPPath Description}}

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

### -LDAProot
{{Fill LDAProot Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: <LDAP://rootDSE>
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
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GenTypeData
{{Fill GenTypeData Description}}

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

### -recursive
{{Fill recursive Description}}

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
Nur benutzen wenn man die Objektstruktur genau kennt!
Es kann sonst zu langen Anwortzeiten oder Fehlern kommen!
Alternativen:
Get-DSM7SoftwareList
Get-DSM7ComputerList

## RELATED LINKS

[Get-DSM7ObjectList]()

[Get-DSM7Object]()

[Get-DSM7Objects]()

