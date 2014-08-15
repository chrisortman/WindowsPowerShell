$paths = 'C:\istfs\oss\Version 08.04.00\Billing\ExternalApi', 'C:\istfs\oss\Version 08.04.00\Billing\Web'

Get-ChildItem -Path $paths -Recurse -Filter *.csproj | Select-String -SimpleMatch 'nuget.targets' |
    Foreach-Object { 
        Add-TfsPendingChange -Edit -Item $_.Path
        gvim $_.Path
    }