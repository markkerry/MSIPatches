---
external help file: MSIPatches-help.xml
Module Name: MSIPatches
online version:
schema: 2.0.0
---

# Get-OrphanedPatch

## SYNOPSIS
Scans the "C:\Windows\Installer" directory for all orpaned msp files.

## SYNTAX

```
Get-OrphanedPatch [<CommonParameters>]
```

## DESCRIPTION
Office installations can leave behind a large amount of orphaned patches which can take up many GBs of disk space.
Using the "Get-MSIPatchInfo" cmdlet from the "MSI" module we can determine which msp files are currently installed.
From there we can calculate the amount and size of the orpaned msp files.

This can be run on it's own to list the orphaned patches, or piped to Move-OrphanedPatches or Remove-Item.

## EXAMPLES

### EXAMPLE 1
```
Get-OrphanedPatch
```

Simply lists orphaned msp files in "C:\Windows\Installer". If you want to free up space I recommend moving the orphaned msp files to another location so they can easily be
restored.
Supports the "-Whatif" and "Verbose" paramters.

### EXAMPLE 2
```
Get-OrphanedPatch | Remove-Item
```

This will permanently delete the orphaned msp files from "C:\Windows\Installer". Supports the "-Whatif" and 
"Verbose" parameters.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.IO.FileInfo

## NOTES
Author: Mark Kerry
Date:   08/01/2018

## RELATED LINKS
