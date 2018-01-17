#Requires -Modules MSI
function Get-OrphanedPatches {
    <# 
    .SYNOPSIS 
        Scans the "C:\Windows\Installer" directory for all orpaned msp files.
    .DESCRIPTION 
        Office installations can leave behind a large amount of orphaned patches which can take up many GBs of disk space.
        Using the "Get-MSIPatchInfo" cmdlet from the "MSI" module we can determine which msp files are currently installed.
        From there we can calculate the amount and size of the orpaned msp files.

        This can be run on it's own to list the orphaned patches, or piped to Move-OrphanedPatches or Remove-OrphanedPatches.
    .EXAMPLE 
        Get-OrphanedPatches
        
        Simply lists orphaned msp files in "C:\Windows\Installer"
    .EXAMPLE 
        Get-OrphanedPatches | Move-OrphanedPatches -Destination <String>
        
        If you want to free up space I recommend moving the orphaned msp files to another location so they can easily be
        restored. Supports the "-Whatif" and "Verbose" paramters.
    .EXAMPLE
        Get-OrphanedPatches | Remove-OrphanedPatches

        This will permanently delete the orphaned msp files from "C:\Windows\OInstaller". Supports the "-Whatif" and 
        "Verbose" paramters.
    .NOTES
        Author: Mark Kerry
        Date:   08/01/2018
    #> 

    [CmdletBinding()] 
    [OutputType([System.IO.FileInfo])]
    Param()

    # Begin by checking the user in running the function from elevated priviledges 
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You need to run this script from an elevated PowerShell prompt!`nPlease start PowerShell as an Administrator..."
        break
    }

    if ($PSVersionTable.PSEdition -eq 'Core') {
        Write-Warning "This function is not compatible with PowerShell Core as it reiles on the MSI module binaries."
        break
    }

    # List all msp files in %windir%\Installer and convert to string
    $strAllMsp = Get-ChildItem -Path C:\Windows\Installer\*.msp | Select-Object Name -ExpandProperty Name

    # List all currently installed msp files and convert to string
    $strInstalledMsps = Get-MSIPatchInfo | Select-Object LocalPackage -ExpandProperty LocalPackage

    # Create a new array of all the installed msp files but run a regex query to strip the path from the string so the format is the same as the strAllMsp variable
    $array = @()
    foreach ($Msp in $strInstalledMsps) {
       $a = $Msp -creplace '(?s)^.*\\', ''
       $array += $a
    }
    # Remove any duplicate values from the array
    $array = $array | Select-Object -uniq

    $obinst = @()
    foreach ($x in $strAllMsp) {
        if (!($array.Contains($x))) {
            $obinst += $x
        }
    }
    
    $obinst | ForEach-Object {Get-ChildItem -Path C:\Windows\Installer\$_} -ov item
}