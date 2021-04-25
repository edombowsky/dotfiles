Import-Module posh-git
Import-Module Get-ChildItemColor

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

Function myls {
    param(
      [Switch] $lrt
    )
    if ( $lrt ) {
      Get-ChildItemColor | Sort-Object LastWriteTime
    }
    else {
      Get-ChildItemColor $args
    }
}

Function mylrt {
    myls -lrt $args
}

Del Alias:ls
Set-Alias -Name ls -Value myls
Set-Alias -Name ll -Value myls
Set-Alias -Name lrt -Value mylrt

try { $null = Get-Command concfg -ea stop; concfg tokencolor -n enable } catch { }

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    if ($s -ne $null) {  # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host ""

    return "> "
}

# $ENV:STARSHIP_CONFIG = "$HOME\.starship"
# $ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
# Invoke-Expression (&starship init powershell)
Set-PoshPrompt -Theme powerlevel10k_modern
