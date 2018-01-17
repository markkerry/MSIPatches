Import-Module $PSScriptRoot\..\MSIPatches\MSIPatches.psd1 -Force

Describe '- Dot Sourcing MSIPatches Module' {
    Context '- Windows Installer XML (WiX) toolset checks' {
        It 'Get-MSIPatchInfo exists' {
            Get-Command Get-MSIPatchInfo | Should Be $true
        }
    }
    Context '- My functions were loaded' {
        It 'Get-MsiPatches exists' {
            Get-Command Get-MsiPatches | Should Be $true
        }
        It 'Get-OrphanedPatches exists' {
            Get-Command Get-OrphanedPatches | Should Be $true
        }
        It 'Move-OrphanedPatches exists' {
            Get-Command Move-OrphanedPatches | Should Be $true
        }    
        It 'Remove-OrphanedPatches exists' {
            Get-Command Remove-OrphanedPatches | Should Be $true
        }
    }
}
Describe '- Testing content within the functions' {
    Context '- Convert Get-MSIPatchInfo LocalPackage property to string' {
        It 'Should return a String TypeName' {
            $InstalledMsps = Get-MSIPatchInfo | Select-Object LocalPackage -ExpandProperty LocalPackage
            $InstalledMsps | Should BeOfType System.String
        }
    }
}
