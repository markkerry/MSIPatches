if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Testing of this module requires elevation.`nPlease start PowerShell as an Administrator..."
    break
}

try {
    Import-Module $PSScriptRoot\..\MSIPatches.psd1 -Force -Verbose
}
catch {
    Write-Output "Failed to import module"
    Write-Warning $_.exception.message
    break
}

if ($host.Name -eq 'Visual Studio Code Host') {
    Write-Output 'Running in VSCode'
}
else {
    Describe '- Validating environment' {
        Context '- Powershell Version' {
            It 'Should not be PowerShell Core' {
                $PSVersionTable.PSEdition -ne 'Core' | Should Be $true
            }
            It 'Should be greater than 3 for OneGet' {
                $host.Version.Major -gt 3 | Should Be $true
            }
            It 'Install-Module exists' {
                Get-Command Install-Module | Should Be $true
            }
            It 'Should be elevated' {
                (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) | Should Be $true
            }
        }
    }
}


Describe '- Dot Sourcing MSIPatches Module' {
    Context '- MSI module checks' {
        It 'Get-MSIPatchInfo exists' {
            Get-Command Get-MSIPatchInfo | Should Be $true
        }
    }
    Context '- MSIPatches functions were loaded' {
        It 'Get-MsiPatch exists' {
            Get-Command Get-MsiPatch | Should Be $true
        }
        It 'Get-OrphanedPatch exists' {
            Get-Command Get-OrphanedPatch | Should Be $true
        }
        It 'Move-OrphanedPatch exists' {
            Get-Command Move-OrphanedPatch | Should Be $true
        }    
        It 'Restore-OrphanedPatch exists' {
            Get-Command Restore-OrphanedPatch | Should Be $true
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
    Context '- Get the function Types' {
        It 'Get-MsiPatch should return a PsCustomObject TypeName' {
            Get-MsiPatch | Should BeOfType System.Management.Automation.PSCustomObject
        }
        It 'Get-OrphanedPatches should BeOfType FileInfo TypeName or BeNullOrEmpty' {
            # Assuming you have dicovered orphaned patches
            $b = Get-OrphanedPatch
            if ($b -ne $null) {  
                $b | Should BeOfType System.IO.FileInfo
            }
            else {
                $b | Should BeNullOrEmpty
            } 
        }
    }
}