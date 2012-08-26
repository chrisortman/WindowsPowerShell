$psroot = (Split-Path $profile)

Set-Alias msbuild C:\windows\microsoft.net\framework\v4.0.30319\MSBuild.exe
Set-Alias vs 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'
Set-Alias subl 'C:\Program Files\Sublime Text 2\sublime_text.exe'
Set-Alias gh4w 'C:\Users\ChrisO\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\GitHub, Inc\GitHub.appref-ms'
Set-Alias vi 'C:\Program Files (x86)\Vim\vim73\vim.exe'
Set-Alias gvim 'C:\Program Files (x86)\Vim\vim73\gvim.exe'

$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)

$PSModuleAutoLoadingPreference = "ALL"

Push-Location $mydir
Import-Module .\Modules\posh-git

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return [System.Environment]::NewLine + "> "
}

#Posh git stuff
Enable-GitColors
Start-SshAgent -Quiet

Pop-Location