$paths = 'C:\istfs\OSS\Version 08.04.00'

Set-Location $paths
$files = (Get-ChildItem -Path $paths -Recurse -Filter *.csproj | Select-String -SimpleMatch "<OutputPath>bin\Release\</OutputPath>")
#$files = (Get-ChildItem -Path $paths -Recurse -Filter *.vbproj | Select-String -SimpleMatch "<OutputPath>..\..\..\..\Binaries\Release\</OutputPath>")


    $files | Foreach-Object { 
        Add-TfsPendingChange -Edit -Item $_.Path
        #(Get-Content -Path $_.Path) | ForEach-Object { $_ -replace "<OutputPath>\.\.\\\.\.\\\.\.\\\.\.\\Binaries\\Release\\</OutputPath>", "<OutputPath>..\..\_Bin\</OutputPath>" } | Set-Content -Path $_.Path
        (Get-Content -Path $_.Path) | ForEach-Object { $_ -replace "<OutputPath>bin\\Release\\</OutputPath>", "<OutputPath>..\..\..\_Bin\</OutputPath>" } | Set-Content -Path $_.Path
    }