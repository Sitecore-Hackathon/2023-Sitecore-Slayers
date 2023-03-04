param(
    [string]$itemPath = "/sitecore/content/Home"
)

Set-Location -Path $PSScriptRoot

$config = Get-Content -Raw -Path ./config.json | ConvertFrom-Json
Write-Output "ConnectionUri: $($config.connectionUri)"
Write-Output "Username     : $($config.username)"
Write-Output "SharedSecret : $($config.SPE_sharedSecret)"

Write-Output "Get item fields of '$itemPath'..."
Import-Module -Name SPE 
$session = New-ScriptSession -ConnectionUri $config.connectionUri -Username $config.username -SharedSecret $config.SPE_SharedSecret
Invoke-RemoteScript -Session $session -ScriptBlock {
    Get-Item $Using:itemPath | Get-ItemField -IncludeStandardFields -ReturnType Field -Name "*" | Format-Table Name, DisplayName, SectionDisplayName, Description -auto
}
Stop-ScriptSession -Session $session