---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Move-DSM7Software

## SYNOPSIS
Verschiebt ein Softwareobjekt.

## SYNTAX

```
Move-DSM7Software [[-Name] <String>] [[-ID] <Int32>] [[-UniqueID] <String>] [[-LDAPPath] <String>]
 [[-toLDAPPath] <String>] [[-toLDAPPathID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Verschiebt ein Softwareobjekt.

## EXAMPLES

### BEISPIEL 1
```
Move-DSM7Software -Name "%Softwarename%" -toLDAPPath "Global Software Library/Folder1/Folder2"
```

### BEISPIEL 2
```
Move-DSM7Software -ID 12345 -toLDAPPathID 12345
```

### BEISPIEL 3
```
Move-DSM7Software -UniqueID "{UniqueID}" -toLDAPPath "Global Software Library/Folder1/Folder2"
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

### -UniqueID
{{Fill UniqueID Description}}

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

### -toLDAPPath
{{Fill toLDAPPath Description}}

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

### -toLDAPPathID
{{Fill toLDAPPathID Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-DSM7SoftwareList]()

[Get-DSM7SoftwareIDs]()

[Get-DSM7Software]()

[Update-DSM7Software]()

[Move-DSM7Software]()

[Get-DSM7SoftwareCategoryList]()

[Get-DSM7SoftwareCategory]()

[New-DSM7SoftwareCategory]()

[Update-DSM7SoftwareCategory]()

[Remove-DSM7SoftwareCategory]()

[Get-DSM7GroupMembers]()

[Get-DSM7ListOfMemberships]()

[Update-DSM7MembershipInGroups]()

[Update-DSM7MemberListOfGroup]()

