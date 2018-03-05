function Move-OrphanedPatch {
    <# 
    .SYNOPSIS 
        Moves the orphaned patches to a specified backup location.
    .DESCRIPTION 
        This function recieves the [System.IO.FileInfo] objects through the pipeline from Get-OrphanedPatch.
        It will move each object to a specified backup location. The location can be created if it doesn't exist.
    .PARAMETER Destination
        Location of where you want to move the orphaned patches to. If it doesn't exist it will be created.
    .PARAMETER Item
        Single patch you would like to move.
    .PARAMETER Confirm
        Confirm the action.
    .PARAMETER WhatIf
        Performs a demonstation of what patches will be moved without moving them.
    .EXAMPLE 
        Move-OrphanedPatch -Item <String> -Destination <string>

        Don't use this unless you have identified one patch to move. To move all use the below command.

        Get-OrphanedPatch | Move-OrphanedPatch -Destination <String>
        
        This will move the orphaned patches to a different location so they can be restored to "C:\Windows\Installer"
        directory if needed. Supports the "-Whatif" and "Verbose" paramters.
    .NOTES
        Author: Mark Kerry
        Date:   08/01/2018
    #> 

    [CmdletBinding(SupportsShouldProcess=$true)]
    Param(
        [Parameter(
        Mandatory=$true,
        ValueFromPipeline=$true)]
        [System.IO.FileInfo]$item,

        [Parameter(
        Mandatory=$true)]
        [String]$Destination
    )
    
    begin {
        if (!(Test-Path -Path $Destination -PathType Container)) {
            $confirmation = Read-Host "Destination: $Destination does not exist. Create it? [y/n]"
            while ($confirmation -ne 'y') {
                if ($confirmation -eq 'n') {
                    break
                }
                $confirmation = Read-Host "Destination: $Destination does not exist. Create it? [y/n]"
            }
            if ($confirmation -eq 'y') {
                try {
                    New-Item -ItemType Directory $Destination
                }
                catch {
                    Write-Warning $_.exception.message
                }
            }
            else {
                break
            }
        }
    }

    process {
        try {
            Move-Item -Path $item -Destination $Destination -Verbose
        }
        catch {
            Write-Warning $_.exception.message
            break
        }
    }
}