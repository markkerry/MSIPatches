# MSIPatches

[![Build status](https://ci.appveyor.com/api/projects/status/mh290e295fnap311/branch/master?svg=true)](https://ci.appveyor.com/project/markkerry/msipatches/branch/master)
[![PowerShell Gallery - MSIPatches](https://img.shields.io/badge/PowerShell%20Gallery-MSIPatches-ff69b4.svg)](https://www.powershellgallery.com/packages/MSIPatches/1.0)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/markkerry/MSIPatches/blob/master/LICENSE)
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-3.0-blue.svg)](https://github.com/markkerry/MSIPatches)

## About

The "C:\Windows\Installer" can often grow very large in size due to applications such as Microsoft Office being regularly patched. Superseded patches get left behind leaving them in an orphaned state. The MSIPatches module can detect and move the orphaned patches freeing up valuable disk space.
This module requires the [MSI](https://github.com/heaths/psmsi) module by [Heath Stewart](https://github.com/heaths). Installation instructions are in the next section

**MSIPactches** functions
**Get-MsiPatch.ps1**

* Lists all msp files in `$env:SystemRoot\Installer\`
* Calculates their total size
* Gets installed patches and size
* Gets orphaned patches and size

**Get-OrphanedPatch.ps1**
* Lists all orphaned patches in `$env:SystemRoot\Installer\`
* Outputs the objects as `[System.IO.FileInfo]` which can be piped to the next functions.

**Move-OrphanedPatch.ps1**
* Moves all orphaned patches in `$env:SystemRoot\Installer\` to a specified location.

**Restore-OrphanedPatch.ps1**
* Restores all previously backed up orphaned patches to `$env:SystemRoot\Installer\`

---

## Installation

You can now install this module from the PowerShell gallery

``` powershell
Install-Module MSIPatches
```

Or you can install it manually

``` powershell
# Install the MSI package
Install-Package msi -Provider PowerShellGet

# Download and unzip the MSIPatches module.
# Unblock the files. E.g:
Get-ChildItem C:\MSIPatches\ -Recurse | Unblock-File

# Import the module
Import-Module C:\MSIPatches\MSIPatches.psd1 -Force -Verbose

# List the commands in the MSIPatches module
Get-Command -Module MSIPatches

CommandType     Name                        Version    Source
-----------     ----                        -------    ------
Function        Get-MsiPatch                1.0.21     MSIPatches
Function        Get-OrphanedPatch           1.0.21     MSIPatches
Function        Move-OrphanedPatch          1.0.21     MSIPatches
Function        Restore-OrphanedPatch       1.0.21     MSIPatches

# Get-Help
Get-Help about_MSIPatches
Get-Help Get-MsiPatches
```

---

## Examples

``` powershell
# Get a count of all MSI patches with Get-MsiPatch
Get-MsiPatch
```

![Get-MsiPatch](/Media/Get-MsiPatch_01.png)  

``` powershell
# Get-OrphanedPatch returns basic information. [System.IO.FileInfo] objects.
Get-OrphanedPatch
```

![Get-OrphanedPatch](/Media/Get-OrphanedPatch_01.png)

``` powershell
# Pass the [System.IO.FileInfo] objects through the pipeline to Move-OrphanedPatch
Get-OrphanedPatch | Move-OrphanedPatch -Destination C:\Backup
```

![Move-OrphanedPatch](/Media/Move-OrphanedPatch_01.png)

``` powershell
# 'y' to create the directory if it doesn't exist.
```

![Move-OrphanedPatch](/Media/Move-OrphanedPatch_02.png)

``` powershell
# After you move the orphaned patches you can run the Get-MsiPatch command again and see the results.
```

![Move-OrphanedPatch](/Media/Move-OrphanedPatch_03.png)

``` powershell
# Restore previously backed up msp files using the Restore-OrphanedPatch command
 Restore-OrphanedPatch -BackupLocation <String>
```

![Restore-OrphanedPatch](/Media/Restore-OrphanedPatch_01.png)

``` powershell
# If the directory doesn't exist/inaccessible or doesn't contain any msp files, the following will display
```

![Restore-OrphanedPatch](/Media/Restore-OrphanedPatch_02.png)  
![Restore-OrphanedPatch](/Media/Restore-OrphanedPatch_03.png)

``` powershell
# Note: you can pass the [System.IO.FileInfo] objects through the pipeline to Remove-Item to permanenlty 
#delete the msp files. Recommend you pipe to Move-OrphanedPatch instead.
Get-OrphanedPatch | Remove-Item
```