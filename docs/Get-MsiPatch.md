---
external help file: MSIPatches-help.xml
Module Name: MSIPatches
online version:
schema: 2.0.0
---

# Get-MsiPatch

## SYNOPSIS
Scans the "C:\Windows\Installer" directory for all installed and orpaned msp files.

## SYNTAX

```
Get-MsiPatch [<CommonParameters>]
```

## DESCRIPTION
Office installations can leave behind a large amount of orphaned patches which can take up many GBs of disk space.
Using the "Get-MSIPatchInfo" cmdlet from the "MSI" module we can determine which msp files are currently installed.
From there we can calculate the amount and size of the orpaned msp files.

## EXAMPLES

### EXAMPLE 1
```
Get-MsiPatch
```

This will display a PsCustomObject of all msp files and size, which are installed and size, and which are 
orpaned and their total size.

### EXAMPLE 2
```
Get-MsiPatch -Verbose
```

Same as above only verbose information is displayed for each msp detailing whether they are installed or orphaned.

### EXAMPLE 3
```
Get-MsiPatch | FT
```

Simply changes the format to a table view of the object.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mark Kerry
Date:   08/01/2018

## RELATED LINKS
