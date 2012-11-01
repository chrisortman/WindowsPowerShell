function Show-InUsePackages
{
    param($Filter = "")

    if($Filter -eq "") 
    {
        $packages = (Get-Package)
    }
    else 
    {
        $packages = (Get-Package -Filter $Filter)
    }

    $real_output = "";

    $packages | %{
        $real_output += $_.Id + " " + $_.Version.ToString() +  "`n"
        $real_output += "----------------------------------`n"

        $currentPackage = $_;
        get-project -All | %{
            $packageInProject = (Get-Package -Filter $currentPackage.Id -Project $_.ProjectName)
            if($packageInProject.Length -eq 1) {
                $real_output += $packageInProject[0].Version.ToString() + "  " + $_.ProjectName.ToString() + "`n"
            }
        }
    }

    Write-Output $real_output

}

function Search-PackageConfigs
{
    param($searchText)

    Get-ChildItem -Path . -Recurse -Include packages.config | Select-String $searchText
}

function Copy-MissingPackages
{
    param(
        $destination,
        $source="."
    )

    Get-ChildItem -Path $source -Filter *.nupkg -Recurse | Where-Object {
        (Test-Path (Join-Path $destination $_.Name)) -eq $false 
    } | Copy-Item -Destination $destination
}
