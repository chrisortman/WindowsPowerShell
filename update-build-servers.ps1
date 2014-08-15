$Credential = Get-Credential

$tfs_path = 'Program Files\Microsoft Team Foundation Server 12.0\Tools\TFSBuildServiceHost.exe.config'

New-PSDrive -Name 'buildC' -PSProvider FileSystem -Root '\\isbuild1\c$' -Credential $Credential
New-PSDrive -Name 'isbuild1C' -PSProvider FileSystem -Root '\\isbuild1\c$' -Credential $Credential
New-PSDrive -Name 'isbuild2vmC' -PSProvider FileSystem -Root '\\isbuild2-vm\c$' -Credential $Credential
New-PSDrive -Name 'obfuscator3C' -PSProvider FileSystem -Root '\\Obfuscator3\c$' -Credential $Credential

Get-PSDrive buildC, isbuild1C, isbuild2vmC, obfuscator3C | format-list


$source = "obfuscator3c:\$tfs_path"

'buildC:', 'isbuild1C:', 'isbuild2vmC:' | %{
    $file = "$_\$tfs_path"
    Copy-Item -Path $file -Destination "$file.bak" -WhatIf
    Copy-Item -Path $source -Destination $file -Confirm -WhatIf
}

Get-PSDrive buildC, isbuild1C, isbuild2vmC, obfuscator3C | Remove-PSDrive
