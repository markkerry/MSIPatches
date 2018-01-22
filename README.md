# MSIPatches
*Written by Mark Kerry*

## About
This module requires the [MSI](https://github.com/heaths/psmsi) module by [Heath Stewart](https://github.com/heaths). Install via the following method:  
``` powershell
Install-Package msi -Provider PowerShellGet
```

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

**Restore-OrphanedPatches.ps1**
* Restores all previously backed up orphaned patches to `$env:SystemRoot\Installer\`

---

## Installation
``` powershell
# Install the MSI package (as above)
Install-Package msi -Provider PowerShellGet

# Download and unzip the MSIPatches module. 
# Unblock the files. E.g:
Get-ChildItem C:\MSIPatches\ -Recurse | Unblock-File

# Import the module
Import-Module C:\MSIPatches\MSIPatches\MSIPatches.psd1 -Force -Verbose
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
# After you move the orphaned patches you can run the Get-MsiPatches command again and see the results.
```
![Move-OrphanedPatches](/Media/Move-OrphanedPatches_03.png)

``` powershell
# Restore previously backed up msp files using the Restore-OrphanedPatches command
 Restore-OrphanedPatches -BackupLocation <String>
```
![Restore-OrphanedPatches](/Media/Restore-OrphanedPatches_01.png)

``` powershell
# If the directory doesn't exist/inaccessible or doesn't contain any msp files, the following will display
```
![Restore-OrphanedPatches](/Media/Restore-OrphanedPatches_02.png)
![Restore-OrphanedPatches](/Media/Restore-OrphanedPatches_03.png)

``` powershell
# Note: you can pass the [System.IO.FileInfo] objects through the pipeline to Remove-Item to permanenlty delete the msp files. Recommend you pipe to Move-OrphanedPatches instead.
Get-OrphanedPatches | Remove-Item
```
