# Scripted-video prop: every scan message and result is fictional.
# This script never reads javaw, process memory, files, or the network.
[CmdletBinding()]
param(
    [ValidateRange(0, 600)]
    [int]$DurationSeconds = (Get-Random -Minimum 27 -Maximum 121)
)

$ErrorActionPreference = 'Stop'

$scannerName = "HappyMonk3y's Client Scanner"
$panelWidth = 68

function Write-PanelBorder {
    Write-Host ('  +' + ('-' * ($panelWidth + 2)) + '+') -ForegroundColor DarkCyan
}

function Write-PanelLine {
    param([string]$Text = '', [ConsoleColor]$Color = 'Gray')
    Write-Host '  | ' -ForegroundColor DarkCyan -NoNewline
    Write-Host $Text.PadRight($panelWidth) -ForegroundColor $Color -NoNewline
    Write-Host ' |' -ForegroundColor DarkCyan
}

function Write-ResultRow {
    param($Row)
    $color = switch ($Row.Result) {
        'FLAG' { 'Red' }
        'GENERIC' { 'Yellow' }
        'FALSE POSITIVE' { 'DarkGray' }
    }
    $label = '{0,-27} {1,5}   ' -f $Row.Check, $Row.Occurrences
    $badge = '[{0}]' -f $Row.Result
    Write-Host '  | ' -ForegroundColor DarkCyan -NoNewline
    Write-Host $label -ForegroundColor Gray -NoNewline
    Write-Host $badge.PadRight($panelWidth - $label.Length) -ForegroundColor $color -NoNewline
    Write-Host ' |' -ForegroundColor DarkCyan
}

function Write-ScanProgress {
    param([ValidateRange(0, 100)][int]$Percent)
    $barWidth = 44
    $filled = [int][Math]::Floor($barWidth * $Percent / 100)
    $bar = ('#' * $filled) + ('-' * ($barWidth - $filled))
    $color = if ($Percent -eq 100) { 'Green' } else { 'Cyan' }
    Write-Host ("`r  [{0}] {1,3}%" -f $bar, $Percent) -ForegroundColor $color -NoNewline
}

Write-Host ''
Write-PanelBorder
Write-PanelLine
Write-PanelLine $scannerName Cyan
Write-PanelLine 'CLIENT SIGNATURES / COMBAT MODULES / INPUT PATTERNS' DarkGray
Write-PanelLine
Write-PanelBorder
Write-PanelLine 'TARGET  javaw.exe                         STATUS  CONNECTED' Green
Write-PanelBorder
Write-Host ''

$stagePool = @(
    'Inspecting Java class signatures',
    'Checking combat module indicators',
    'Analyzing crystal placement timing',
    'Reviewing shield interaction patterns',
    'Checking totem swap intervals',
    'Inspecting inventory action sequences',
    'Analyzing anchor input timing',
    'Checking repeated key patterns',
    'Reviewing item selection intervals',
    'Correlating client signature matches',
    'Filtering generic signature matches',
    'Checking rapid placement sequences',
    'Comparing macro timing patterns',
    'Reviewing attack and hit intervals'
)
$stages = @('Connecting to Java runtime') + @(Get-Random -InputObject $stagePool -Count 7) + @('Preparing scan report')

$timer = [Diagnostics.Stopwatch]::StartNew()
$previousStage = -1
try {
    while ($timer.Elapsed.TotalSeconds -lt $DurationSeconds) {
        $fraction = $timer.Elapsed.TotalSeconds / $DurationSeconds
        $stageIndex = [Math]::Min($stages.Count - 1, [int][Math]::Floor($fraction * $stages.Count))
        if ($stageIndex -ne $previousStage) {
            if ($previousStage -ge 0) {
                Write-Host ("`r" + (' ' * 54) + "`r") -NoNewline
            }
            Write-Host ('  {0:HH:mm:ss}  ' -f (Get-Date)) -ForegroundColor DarkGray -NoNewline
            Write-Host 'SCAN  ' -ForegroundColor Cyan -NoNewline
            Write-Host $stages[$stageIndex] -ForegroundColor Gray
            $previousStage = $stageIndex
        }
        Write-ScanProgress -Percent ([Math]::Min(99, [int][Math]::Floor($fraction * 100)))
        Start-Sleep -Milliseconds 200
    }
}
finally {
    $timer.Stop()
}
Write-ScanProgress -Percent 100
Write-Host ''

$client = Get-Random -InputObject @('198m Client', 'Prestige Client', 'Doomsday Client', 'Krypton Client', 'Argon Client')
$results = @(
    [pscustomobject]@{
        Group = 'CLIENT'
        Check = $client
        Occurrences = 1
        Result = 'FLAG'
    }
)

foreach ($check in @('Anchor Macro', 'Double Anchor')) {
    $results += [pscustomobject]@{
        Group = 'MACROS'
        Check = $check
        Occurrences = 1
        Result = Get-Random -InputObject @('FLAG', 'FLAG', 'FLAG', 'GENERIC', 'FALSE POSITIVE')
    }
}

foreach ($check in @('Auto Crystal', 'Auto Hit Crystal', 'Shield Breaker', 'Auto Totem', 'Hover Totem', 'Inv Totem', 'Totem Refill', 'Fast Place')) {
    $results += [pscustomobject]@{
        Group = 'MODULES'
        Check = $check
        Occurrences = Get-Random -Minimum 1 -Maximum 31
        Result = Get-Random -InputObject @('FLAG', 'FLAG', 'FLAG', 'GENERIC', 'FALSE POSITIVE')
    }
}

Write-Host ''
Write-PanelBorder
Write-PanelLine ('SCAN COMPLETE                                  ELAPSED  {0:mm\:ss}' -f $timer.Elapsed) Green
Write-PanelBorder
Write-PanelLine ('{0,-27} {1,5}   {2}' -f 'CHECK', 'COUNT', 'RESULT') DarkGray
foreach ($group in @('CLIENT', 'MACROS', 'MODULES')) {
    Write-PanelLine
    Write-PanelLine $group Cyan
    foreach ($row in @($results | Where-Object { $_.Group -eq $group })) {
        Write-ResultRow $row
    }
}
Write-PanelLine
Write-PanelBorder
$flagCount = @($results | Where-Object { $_.Result -eq 'FLAG' }).Count
$genericCount = @($results | Where-Object { $_.Result -eq 'GENERIC' }).Count
$falseCount = @($results | Where-Object { $_.Result -eq 'FALSE POSITIVE' }).Count
Write-PanelLine ('SUMMARY  {0} flagged / {1} generic / {2} false positive checks' -f $flagCount, $genericCount, $falseCount) Gray
Write-PanelLine ('CLIENT MATCH  {0}' -f $client) Red
Write-PanelBorder
Write-Host ''
