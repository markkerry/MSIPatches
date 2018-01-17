# MSIPatches
*Written by Mark Kerry*

## About
This module requires the the [MSI](https://github.com/heaths/psmsi) module by [Heath Stewart](https://github.com/heaths) which, if currently isn't installed, will attempt to install when importing the MSIPatches module.

**MSIPactches** functions
	
**Get-MsiPatches.ps1**
* Lists all msp files in `$env:SystemRoot\Installer\`
* Calculates their total size
* Gets installed patches and size
* Gets orphaned patches and size

**Get-OrphanedPatches.ps1**
* Lists all orphaned patches in `$env:SystemRoot\Installer\`
* Outputs the objects as `[System.IO.FileInfo]` which can be piped to the next functions.

**Move-OrphanedPatches.ps1**
* Moves all orphaned patches in `$env:SystemRoot\Installer\` to a specified location.

**Remove-OrphanedPatches.ps1**
* Removes all orphaned patches from `$env:SystemRoot\Installer\`

---

## Installation
``` powershell
# Import the module
Import-Module C:\MSIPatches\MSIPatches\MSIPatches.psd1
```
---

## Examples
``` powershell
# Get-Msi-Patches with Verbose output
Get-MsiPatches -Verbose 
```
![Get-MsiPatches](/Media/Get-MsiPatches_01.png)  
![Get-MsiPatches](/Media/Get-MsiPatches_02.png)  

``` powershell
# Get-OrphanedPatches returns basic information. [System.IO.FileInfo] objects.
Get-OrphanedPatches
```
![Get-OrphanedPatches](/Media/Get-OrphanedPatches_01.png)  

``` powershell
# Pass the [System.IO.FileInfo] objects through the pipeline to Move-OrphanedPatches
Get-OrphanedPatches | Move-OrphanedPatches -Destination C:\Backup
```
![Move-OrphanedPatches](/Media/Move-OrphanedPatches_01.png)
``` powershell
# 'y' to create the directory if it doesn't exist.
```
![Move-OrphanedPatches](/Media/Move-OrphanedPatches_02.png)

``` powershell
# Pass the [System.IO.FileInfo] objects through the pipeline to Move-OrphanedPatches
Get-OrphanedPatches | Remove-OrphanedPatches
```
![Remove-OrphanedPatches](/Media/Remove-OrphanedPatches_01.png)