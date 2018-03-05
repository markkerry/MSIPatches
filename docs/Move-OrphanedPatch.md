---
external help file: MSIPatches-help.xml
Module Name: MSIPatches
online version:
schema: 2.0.0
---

# Move-OrphanedPatch

## SYNOPSIS
Moves the orphaned patches to a specified backup location.

## SYNTAX

```
Move-OrphanedPatch [-item] <FileInfo> [-Destination] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function receives the \[System.IO.FileInfo\] objects through the pipeline from Get-OrphanedPatch.
It will move each object to a specified backup location.
The location can be created if it doesn't exist.

## EXAMPLES

### EXAMPLE 1
```
Move-OrphanedPatch -Item <string> -Destination <string>
```

Don't use this unless you have identified one patch to move.
To move all use the below command.

### EXAMPLE 2
```
Get-OrphanedPatch | Move-OrphanedPatch -Destination <String>
```

This will move the orphaned patches to a different location so they can be restored to "C:\Windows\Installer"
directory if needed.
Supports the "-Whatif" and "Verbose" paramters.

## PARAMETERS

### -item
Single patch you would like to move.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Destination
Location of where you want to move the orphaned patches to.
If it doesn't exist it will be created.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Date:   08/01/2018

## RELATED LINKS
