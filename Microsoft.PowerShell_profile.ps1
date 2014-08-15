$psroot = (Split-Path $profile)

Set-Alias msbuild 'C:\program files (x86)\MSBuild\12.0\bin\MSBuild.exe'
Set-Alias vs 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'
Set-Alias subl 'C:\Program Files\Sublime Text 2\sublime_text.exe'
Set-Alias gh4w 'C:\Users\ChrisO\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\GitHub, Inc\GitHub.appref-ms'
Set-Alias vi 'C:\Program Files (x86)\Vim\vim73\vim.exe'
Set-Alias gvim 'C:\Program Files (x86)\Vim\vim73\gvim.exe'
Set-Alias -Name tm86 'C:\Windows\syswow64\taskmgr.exe'

$mydir = (Split-Path -parent $MyInvocation.MyCommand.Definition)

$PSModuleAutoLoadingPreference = "ALL"

Push-Location $mydir
Import-Module .\Modules\posh-git

function Test-ConnectionString
{
    param([string] $ConnectionString)

    Add-Type -AssemblyName System.Data

    $conn = New-Object System.Data.SqlClient.SqlConnection
    
    try 
    {
        $conn.ConnectionString = $ConnectionString
        $conn.Open()
        Write-Host "Connected to Database $($conn.Database)"
        $conn.Close()
    }
    Catch [Exception]
    {
        Write-Host "Generic Exception"
        Write-Host $_
        $_ | Select *
    }
}



function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    $historyid = 1
    $historyItem = Get-History -Count 1
    if($historyItem)
    {
        $historyid = $historyItem.Id + 1
    }
    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    Write-Host -nonewline "`n$historyid > "

    "`b"
}

#Posh git stuff
Enable-GitColors
Start-SshAgent -Quiet

Pop-Location

Add-PSSnapin WDeploySnapin3.0

Import-Module Pscx
Invoke-BatchFile "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat"
. (Join-Path $mydir 'Enable-HistoryPersistence.ps1')