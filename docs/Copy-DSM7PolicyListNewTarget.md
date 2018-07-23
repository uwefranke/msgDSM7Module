---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Copy-DSM7PolicyListNewTarget

## SYNOPSIS
Kopiert die Policys eines Ziels und/oder erweiter eine Referens Ziel zu einer neuen Ziel.

## SYNTAX

```
Copy-DSM7PolicyListNewTarget [[-ID] <String>] [[-Name] <String>] [[-LDAPPath] <String>] [[-NewID] <String>]
 [[-NewName] <String>] [[-NewLDAPPath] <String>] [[-ExtentionID] <String>] [[-ExtentionName] <String>]
 [[-ExtentionLDAPPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Kopiert die Policys eines Ziels und/oder erweiter eine Referens Ziel zu einer neuen Ziel.

## EXAMPLES

### BEISPIEL 1
```
Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -NewName "Name" -NewLDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 2
```
Copy-DSM7PolicyListNewTarget -Name "Name" -LDAPPath "Managed Users & Computers/OU1" -NewName "Name" -NewLDAPPath "Managed Users & Computers/OU1" -ExtentionName "Name" -ExtentionLDAPPath "Managed Users & Computers/OU1"
```

### BEISPIEL 3
```
Copy-DSM7PolicyListNewTarget -ID 1234 -NewID 1234
```

### BEISPIEL 4
```
Copy-DSM7PolicyListNewTarget -ID 1234 -NewID 1234 -ExtentionID 1234
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

### -NewID
{{Fill NewID Description}}

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

### -NewName
{{Fill NewName Description}}

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

### -NewLDAPPath
{{Fill NewLDAPPath Description}}

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

### -ExtentionID
{{Fill ExtentionID Description}}

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

### -ExtentionName
{{Fill ExtentionName Description}}

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

### -ExtentionLDAPPath
{{Fill ExtentionLDAPPath Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7PolicyList]()

[Remove-DSM7Policy]()

[New-DSM7Policy]()

[Copy-DSM7Policy]()

[Add-DSM7PolicyToTarget]()

[Move-DSM7PolicyToTarget]()

[Update-DSM7Policy]()

[Get-DSM7PolicyListByTarget]()

[Get-DSM7PolicyListByAssignedSoftware]()

[Copy-DSM7PolicyListNewTarget]()

[Get-DSM7PolicyStatisticsByTarget]()

[Get-DSM7PolicyStatistics]()

