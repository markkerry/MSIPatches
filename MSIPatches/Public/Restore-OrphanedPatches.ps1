function Restore-OrphanedPatches {
    <# 
    .SYNOPSIS 
        Restores the previously backed up msp files
    .DESCRIPTION 
        This function can be run in the event of needing to restore the moved msp files.
    .EXAMPLE 
        Restore-OrphanedPatches -BackupLocation D:\Backup

    .NOTES
        Author: Mark Kerry
        Date:   18/01/2018
    #> 
    [CmdletBinding(SupportsShouldProcess=$true)] 
    Param(
        [Parameter(
        Mandatory=$true)]
        [String]$BackupLocation
    )

    # Begin by checking the user in running the function from elevated priviledges 
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "You need to run this script from an elevated PowerShell prompt!`nPlease start PowerShell as an Administrator..."
        break
    }

    # Check the backup location is exists or is accessible
    if (Test-Path -Path $BackupLocation) {
        # If so check there are msp files in the location. Then attempt to move them back to the installer directory.
        if (Get-ChildItem -Path "$($BackupLocation)\*.msp") { 
            try {
                Move-Item -Path "$($BackupLocation)\*.msp" -Destination 'C:\Windows\Installer' -Verbose
            }
            catch {
                Write-Warning $_.exception.message
                break
            }
        }
        else {
            Write-Warning "Unable to find any msp files in $BackupLocation"
        }
    }
    else {
        Write-Warning "Unable to find $BackupLocation"
    }
}