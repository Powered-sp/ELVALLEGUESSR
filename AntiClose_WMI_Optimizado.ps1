# AntiClose WMI - Edge
$cooldownSeconds = 5
$lastLaunch = [datetime]::MinValue

Register-WmiEvent `
    -Query "SELECT * FROM Win32_ProcessStopTrace WHERE ProcessName='msedge.exe'" `
    -SourceIdentifier "EdgeAntiClose" `
    -Action {

        $cooldownSeconds = 5

        Start-Sleep -Seconds $cooldownSeconds

        $edgeRunning = Get-Process msedge -ErrorAction SilentlyContinue

        if (-not $edgeRunning) {
            Start-Process "msedge.exe"
        }
    }

while ($true) {
    Wait-Event -Timeout 60 | Out-Null
}
