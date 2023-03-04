# Process a raw deploment log file in the folder deployment-logs to split into separate log files per stage.
# Author: Serge van den Oever [Macaw]
# Version: 1.0
param (
    [Parameter(Mandatory=$true)]$deploymentId
)

$VerbosePreference = 'SilentlyContinue' # change to Continue to see verbose output
$DebugPreference = 'SilentlyContinue' # change to Continue to see debug output
$ErrorActionPreference = 'Stop'

$rawLogfilePath = "$PSScriptRoot\..\deployment-logs\Deployment_$($deploymentId)_logs.json"
if (-not (Test-Path -Path $rawLogfilePath)) {
    Write-Error "Deployment log file with deployment id '$deploymentId' not found at $rawLogfilePath"
}
$rawLogfilePath = Resolve-Path -Path $rawLogfilePath
$rawLogfilePath = $rawLogfilePath.Path
Write-Host "Deployment raw log file path: $rawLogfilePath"
$logData = Get-Content -Raw -Path $rawLogfilePath | ConvertFrom-Json
$stages = $logData.Stage
$logs = $logData.Logs
$stages | ForEach-Object {
    $stageName = $_.Name
    $stageLogs = $logs | Where-Object { $_.Stage -eq $stageName }
    $lines = ''
    $stageLogs | ForEach-Object {
        $logTime = $_.LogTime.SubString(0,19) # only date and time
        $logLevel = $_.LogLevel.ToUpper()
        $logMessage = $_.LogMessage
        $lines += "$logTime $logLevel $logMessage`n"
    }
    $stageLogFilePath = "$PSScriptRoot\..\deployment-logs\Deployment_$($deploymentId)_$($stageName).log"
    Set-Content -Path $stageLogFilePath -Value $lines
    $_  | Add-Member -NotePropertyName LogFile -NotePropertyValue (Resolve-Path -Path $stageLogFilePath).Path
}
$stagesResult = $stages | Format-Table -Property Name, State, LogFile -AutoSize | Out-String -Width 512
$stagesLogFilePath = "$PSScriptRoot\..\deployment-logs\Deployment_$($deploymentId)_StagesOverview.log"
Set-Content -Path $stagesLogFilePath -Value $stagesResult
$stagesLogFilePath = (Resolve-Path -Path $stagesLogFilePath).Path
Write-Host "Deployment stages overview log file path: $stagesLogFilePath"
Write-Host $stagesResult