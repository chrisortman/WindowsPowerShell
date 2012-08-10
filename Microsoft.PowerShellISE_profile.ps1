$psroot = (Split-Path $profile)

Set-Alias msbuild C:\windows\microsoft.net\framework\v4.0.30319\MSBuild.exe
Set-Alias vs 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe'


$PSModuleAutoLoadingPreference = "ALL"
# Load posh-git example profile
. 'C:\Users\chris\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

