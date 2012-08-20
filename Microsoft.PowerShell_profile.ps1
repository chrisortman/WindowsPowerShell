$psroot = (Split-Path $profile)

Set-Alias msbuild C:\windows\microsoft.net\framework\v4.0.30319\MSBuild.exe
Set-Alias vs 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'
Set-Alias subl 'C:\Program Files\Sublime Text 2\sublime_text.exe'

$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)

$PSModuleAutoLoadingPreference = "ALL"

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