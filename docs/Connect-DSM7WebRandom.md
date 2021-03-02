---
external help file: msgDSM7Module-help.xml
Module Name: msgDSM7Module
online version:
schema: 2.0.0
---

# Connect-DSM7WebRandom

## SYNOPSIS
Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zufoallig ausgewaehlt wird.

## SYNTAX

```
Connect-DSM7WebRandom [[-WebServer] <String>] [[-Port] <String>] [-UseDefaultCredential] [[-User] <String>]
 [[-UserPW] <String>] [[-Credential] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Stellt Verbindung zur SOAP Schnittstelle von HEAT Software DSM7 her, mit einen BSL Server der zufaellig ausgewaehlt wird.

## EXAMPLES

### BEISPIEL 1
```
Connect-DSM7WebRandom -WebServer "DSM7 BLS" -UseDefaultCredential
```

### BEISPIEL 2
```
Connect-DSM7WebRandom -WebServer "DSM7 BLS" -Port 8080 -User "Domaene\Benutzer" -UserPW "******"
```

### BEISPIEL 3
```
Connect-DSM7WebRandom -WebServer "DSM7 BLS" -Port 8080 -Credential PSCredential
```

## PARAMETERS

### -WebServer
{{Fill WebServer Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
{{Fill Port Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 8080
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredential
{{Fill UseDefaultCredential Description}}

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

### -User
{{Fill User Description}}

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

### -UserPW
{{Fill UserPW Description}}

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

### -Credential
{{Fill Credential Description}}

```yaml
Type: Object
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

[Connect-DSM7Web]()

[Connect-DSM7WebRandom]()

