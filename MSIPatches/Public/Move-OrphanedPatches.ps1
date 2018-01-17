function Move-OrphanedPatches {
    <# 
    .SYNOPSIS 
        Moves the orphaned patches to a specified backup location.
    .DESCRIPTION 
        This function recieves the [System.IO.FileInfo] objects through the pipeline from Get-OrphanedPatches.
        It will move each object to a specified backup location. The location can be created if it doesn't exist.
    .EXAMPLE 
        Get-OrphanedPatches | Move-OrphanedPatches -Destination <String>
        
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