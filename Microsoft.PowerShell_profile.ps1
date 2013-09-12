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

function Get-OSSVersion
{
    $currentDirectory = (Get-Location).Path
    $currentVersion = $currentDirectory.Substring(13)
    $currentVersion = $currentVersion.Substring(0, $currentVersion.IndexOf('\'))

    $currentVersion
}
function Switch-OSSVersion
{
	param([string] $Version)
        
    $currentVersion = (Get-OSSVersion)
    $currentPath = (Get-OSSVersionPath -Version $currentVersion)
    $newPath = (Get-OSSVersionPath -Version $Version)

    Write-Host "Switching from $currentPath to $newPath"
    Push-Location (Get-Location).Path.ToLower().Replace($currentPath.ToLower(), $newPath.ToLower())
}

function Get-OSSVersionPath
{
    param([string] $Version)

    $path = "c:\istfs\OSS\$($Version)\"
    if((Test-Path $path) -eq $true)
    {
        return $path
    }
    else 
    {
        $path = "c:\istfs\OSS\Version 0$($Version).00\"
        if((Test-Path $path) -eq $true) 
        {
            return $path
        }
        else 
        {
            $path = "c:\istfs\OSS\Version $($Version)"
            if((Test-Path $path) -eq $true)
            {
                return $path
            }
        }

        throw "Invalid Version $Version"
    }
}
function Start-DbAdmin 
{
    param([string] $Version = "Current")

    $path = (Join-Path (Get-OSSVersionPath $Version) "_Bin")
    Write-Host "Starting DBAdmin in $path"
    . "$path\IS.DbAdministration.exe"
   
}

function Start-OSS
{
    param(
        [string] $Server = "ISSQLDEV",
        [string] $Environment = "DVLP",
        [string] $Version = "Current"
        )

    $path = (Join-Path (Get-OSSVersionPath $Version) "_Bin")
    Write-Host "Starting Elation in $path connected to $Server - $Environment"
    . "$path\IS.OSS.Main.exe" -S $Server -E $Environment
   
}

function Start-Storefront
{
    param(
        [string] $Server = "ISSQLDEV",
        [string] $Environment = "DVLP",
        [string] $Version = "Current"
        )

    $path = (Join-Path (Get-OSSVersionPath $Version) "_Bin")
    Write-Host "Starting Elation in $path connected to $Server - $Environment"
    . "$path\Shell.exe" -S $Server -E $Environment
   
}

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

Add-PSSnapin WDeploySnapin3.0

Import-Module Pscx
Invoke-BatchFile "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\Tools\VsDevCmd.bat"