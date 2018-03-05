---
external help file: MSIPatches-help.xml
Module Name: MSIPatches
online version:
schema: 2.0.0
---

# Restore-OrphanedPatch

## SYNOPSIS
Restores the previously backed up msp files

## SYNTAX

```
Restore-OrphanedPatch [-BackupLocation] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function can be run in the event of needing to restore the moved msp files.

## EXAMPLES

### EXAMPLE 1
```
Restore-OrphanedPatch -BackupLocation D:\Backup
```

Moves the previously relocated pacthes back to "C:\Windows\Installer\"

## PARAMETERS

### -BackupLocation
Location of the prevously moved msp files

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Performs a demonstation of what patches will be moved without moving them.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Confirm the action.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
Author: Mark Kerry
Date:   18/01/2018

## RELATED LINKS
