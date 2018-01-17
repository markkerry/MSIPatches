#Requires -Modules MSI
function Get-MsiPatches {
    <# 
    .SYNOPSIS 
        Scans the "C:\Windows\Installer" directory for all installed and orpaned msp files.
    .DESCRIPTION 
        Office installations can leave behind a large amount of orphaned patches which can take up many GBs of disk space.
        Using the "Get-MSIPatchInfo" cmdlet from the "MSI" module we can determine which msp files are currently installed.
        From there we can calculate the amount and size of the orpaned msp files.
    .EXAMPLE 
        Get-MsiPatches
        
        This will display a PsCustomObject of all msp files and size, which are installed and size, and which are 
        orpaned and their total size.
    .EXAMPLE 
        Get-MsiPatches -Verbose
        
        Same as above only verbose information is displayed for each msp detailing whether they are installed or orphaned.
    .EXAMPLE
        Get-MsiPatches | FT

        Simply changes the format to a table view of the object.
    .NOTES
        Author: Mark Kerry
        Date:   08/01/2018
    #> 

    [CmdletBinding()] 
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

    # Get each .msp in the Installer directory and calculate the size.
    $allMsp = Get-Item -Path C:\Windows\Installer\*.msp | Measure-Object -Property Length -Sum
    $allMspSum = "{0:N2}" -f ($allMsp.sum / 1GB) + " GB"

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

    # Now list both installed and Obsolete msps
    $inCount=0
    $obCount=0
    $inst = @()
    $obinst = @()
    foreach ($x in $strAllMsp) {
        if ($array.Contains($x)) {
            Write-Verbose "$x is installed."
            $inst += $x
            $inCount++
        }
        else {
            Write-Verbose "$x is obsolete and can be moved/deleted."
            $obinst += $x
            $obCount++
        }
    }
    
    # Scan for each installed msp and calculate the total size of them all.
    Write-Progress -Activity 'Retrieving installed msp files...' -Status '33% Complete.' -PercentComplete 33

    $size = $null
    foreach ($i in $inst) {
        $instSize = Get-ChildItem -Path C:\Windows\Installer | Where-Object {$_.Name -like $i} | Select-Object Length -ExpandProperty Length
        $size += $instSize
    }
    $TotalInst = "{0:N2}" -f ($size / 1GB) + " GB"

    # Scan for each obsolete msp and calculate the total size of them all.
    Write-Progress -Activity 'Retrieving orphaned msp files...' -Status '66% Complete.' -PercentComplete 66

    $obsize = $null
    foreach ($o in $obinst) {
        $obinstSize = Get-ChildItem -Path C:\Windows\Installer | Where-Object {$_.Name -like $o} | Select-Object Length -ExpandProperty Length
        $obsize += $obinstSize
    }
    $TotalOb = "{0:N2}" -f ($obsize / 1GB) + " GB"
    
    # Display them all in a PsCustomObject
    [PsCustomObject]@{
        TotalPatchCount = $allMsp.Count
        TotalPatchSize = $allMspSum
        InstalledPatchCount = $inCount
        InstalledPatchSize = $TotalInst
        OrphanedPatchCount = $obCount
        OrphanedPatchSize = $TotalOb
    }
}
