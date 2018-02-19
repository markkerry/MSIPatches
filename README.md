[![Build status](https://ci.appveyor.com/api/projects/status/mh290e295fnap311/branch/master?svg=true)](https://ci.appveyor.com/project/markkerry/msipatches/branch/master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/markkerry/MSIPatches/blob/master/LICENSE)
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-3.0-blue.svg)](https://github.com/markkerry/MSIPatches)

# MSIPatches

## About
The "C:\Windows\Installer" can often grow very large in size due to applications such as Microsoft Office being regularly patched. Superseded patches get left behind leaving them in an orphaned state. The MSIPatches module can detect and move the orphaned patches freeing up valuable disk space.  
This module requires the [MSI](https://github.com/heaths/psmsi) module by [Heath Stewart](https://github.com/heaths). Installation instructions are in the next section


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
# Install the MSI package
Install-Package msi -Provider PowerShellGet

# Download and unzip the MSIPatches module. 
# Unblock the files. E.g:
Get-ChildItem C:\MSIPatches\ -Recurse | Unblock-File

# Import the module
Import-Module C:\MSIPatches\MSIPatches\MSIPatches.psd1 -Force -Verbose

# List the commands in the MSIPatches module
Get-Command -Module MSIPatches

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Get-MsiPatches                                     1.0        MSIPatches
Function        Get-OrphanedPatches                                1.0        MSIPatches
Function        Move-OrphanedPatches                               1.0        MSIPatches
Function        Restore-OrphanedPatches                            1.0        MSIPatches

# Get-Help
Get-Help about_MSIPatches
Get-Help Get-MsiPatches
```
---

## Examples
``` powershell
# Get-MsiPatches with Verbose output
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
# Note: you can pass the [System.IO.FileInfo] objects through the pipeline to Remove-Item to permanenlty 
# delete the msp files. Recommend you pipe to Move-OrphanedPatches instead.
Get-OrphanedPatches | Remove-Item
```
