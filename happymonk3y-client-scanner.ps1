# Scripted-video prop: every scan message and result is fictional.
# This script never reads javaw, process memory, files, or the network.
[CmdletBinding()]
param(
    [ValidateRange(0, 600)]
    [int]$DurationSeconds = 120
)

$ErrorActionPreference = 'Stop'

Write-Host ''
Write-Host '  ======================================================' -ForegroundColor DarkCyan
Write-Host '               happymonk3y client scanner' -ForegroundColor Cyan
Write-Host '  ======================================================' -ForegroundColor DarkCyan
Write-Host ''
Write-Host '  [OK] javaw.exe located' -ForegroundColor Green
Write-Host '  [OK] Automatic scan started' -ForegroundColor Green
Write-Host ''

$stages = @(
    'Connecting to Java runtime',
    'Enumerating loaded classes',
    'Inspecting runtime signatures',
    'Analyzing combat input patterns',
    'Checking macro indicators',
    'Correlating detection flags',
    'Preparing scan report'
)

$timer = [Diagnostics.Stopwatch]::StartNew()
$previousStage = -1
try {
    while ($timer.Elapsed.TotalSeconds -lt $DurationSeconds) {
        $fraction = $timer.Elapsed.TotalSeconds / $DurationSeconds
        $stageIndex = [Math]::Min($stages.Count - 1, [int][Math]::Floor($fraction * $stages.Count))
        $remaining = [int][Math]::Ceiling($DurationSeconds - $timer.Elapsed.TotalSeconds)
        if ($stageIndex -ne $previousStage) {
            Write-Host ('  [SCAN] {0}...' -f $stages[$stageIndex]) -ForegroundColor DarkGray
            $previousStage = $stageIndex
        }
        Write-Progress -Activity 'Automatic javaw.exe scan' -Status $stages[$stageIndex] -PercentComplete ([int]($fraction * 100)) -SecondsRemaining $remaining
        Start-Sleep -Milliseconds 200
    }
}
finally {
    $timer.Stop()
    Write-Progress -Activity 'Automatic javaw.exe scan' -Completed
}

$client = Get-Random -InputObject @('Prestige Client', 'Krypton Client', 'Doomsday Client')
$maximum = if ($client -eq 'Prestige Client') { 20 } else { 30 }
$results = @(
    [pscustomobject]@{
        Check = $client
        Occurrences = Get-Random -Minimum 1 -Maximum ($maximum + 1)
        Result = 'FLAG'
    }
)

foreach ($check in @('Auto Crystal', 'Auto Hit Crystal', 'Anchor Macro', 'Double Anchor', 'Shield Breaker', '198m', 'Hover Totem', 'Auto Totem', 'Totem Refill', 'Fast Place')) {
    $results += [pscustomobject]@{
        Check = $check
        Occurrences = Get-Random -Minimum 1 -Maximum 31
        Result = Get-Random -InputObject @('FLAG', 'FLAG', 'FLAG', 'GENERIC', 'FALSE POSITIVE')
    }
}

Write-Host ''
Write-Host '  SCAN COMPLETE' -ForegroundColor Green
Write-Host ('  Elapsed: {0:mm\:ss}' -f $timer.Elapsed) -ForegroundColor DarkGray
Write-Host ''
Write-Host ('  {0,-22} {1,11}   {2}' -f 'CHECK', 'OCCURRENCES', 'RESULT') -ForegroundColor Cyan
Write-Host '  ------------------------------------------------------' -ForegroundColor DarkGray
foreach ($row in $results) {
    $color = switch ($row.Result) {
        'FLAG' { 'Red' }
        'GENERIC' { 'Yellow' }
        'FALSE POSITIVE' { 'DarkGray' }
    }
    Write-Host ('  {0,-22} {1,11}   {2}' -f $row.Check, $row.Occurrences, $row.Result) -ForegroundColor $color
}
Write-Host ''
Write-Host ('  Verdict: FLAGS FOUND | {0}' -f $client) -ForegroundColor Red
Write-Host ''
