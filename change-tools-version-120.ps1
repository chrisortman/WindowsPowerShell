$paths = 'C:\istfs\oss\Current\Billing\ExternalApi', 'C:\istfs\oss\Current\Billing\Web'

Get-ChildItem -Path $paths -Recurse -Filter *.csproj |
    Foreach-Object { 
        Add-TfsPendingChange -Edit -Item $_.FullName
        (Get-Content -Path $_.FullName) | ForEach-Object { $_ -replace "ToolsVersion=`"4.0`"", "ToolsVersion=`"12.0`"" } | Set-Content -Path $_.FullName
    }