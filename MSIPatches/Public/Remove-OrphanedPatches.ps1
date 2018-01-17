function Remove-OrphanedPatches {
    <# 
    .SYNOPSIS 
        Removes all orphaned patches.
    .DESCRIPTION 
        This function recieves the [System.IO.FileInfo] objects through the pipeline from Get-OrphanedPatches.
        It will permantly remove each object.
    .EXAMPLE 
        Get-OrphanedPatches | Remove-OrphanedPatches

        This will permanently delete the orphaned msp files from "C:\Windows\OInstaller". Supports the "-Whatif" and 
        "Verbose" paramters.
    .NOTES
        Author: Mark Kerry
        Date:   08/01/2018
    #> 

    [CmdletBinding(SupportsShouldProcess=$true)]
    Param(
        [Parameter(
        Mandatory=$true,
        ValueFromPipeline=$true)]
        [System.IO.FileInfo]$item

    )

    process {
        try {
            Remove-Item -Path $item -Force -Verbose
        }
        catch {
            Write-Warning $_.exception.message
            break
        }
    }
}