[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Url,

    [Parameter(Mandatory = $true)]
    [string]$OutputFile,

    [ValidateSet('get', 'fetch', 'stealthy-fetch')]
    [string]$Mode = 'get',

    [string]$CssSelector,

    [string]$WaitSelector,

    [int]$Timeout,

    [int]$WaitMs,

    [switch]$NoHeadless,

    [switch]$SolveCloudflare,

    [switch]$NoVerify,

    [string[]]$Header
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resolvedOutput = [System.IO.Path]::GetFullPath($OutputFile)
$extension = [System.IO.Path]::GetExtension($resolvedOutput).ToLowerInvariant()
$validExtensions = @('.md', '.txt', '.html')

if ($validExtensions -notcontains $extension) {
    throw "Unsupported output extension '$extension'. Use one of: .md, .txt, .html"
}

$outputDirectory = [System.IO.Path]::GetDirectoryName($resolvedOutput)
if ($outputDirectory -and -not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

$arguments = @('extract', $Mode, $Url, $resolvedOutput)

if ($CssSelector) {
    $arguments += @('--css-selector', $CssSelector)
}

if ($Timeout -gt 0) {
    $arguments += @('--timeout', $Timeout.ToString())
}

if ($Mode -eq 'get' -and $NoVerify) {
    $arguments += '--no-verify'
}

foreach ($entry in ($Header | Where-Object { $_ })) {
    if ($Mode -eq 'get') {
        $arguments += @('--headers', $entry)
    }
    else {
        $arguments += @('--extra-headers', $entry)
    }
}

if ($Mode -ne 'get') {
    if ($WaitSelector) {
        $arguments += @('--wait-selector', $WaitSelector)
    }

    if ($WaitMs -gt 0) {
        $arguments += @('--wait', $WaitMs.ToString())
    }

    if ($NoHeadless) {
        $arguments += '--no-headless'
    }
}

if ($Mode -eq 'stealthy-fetch' -and $SolveCloudflare) {
    $arguments += '--solve-cloudflare'
}

Write-Host ("Running: scrapling " + ($arguments -join ' '))
& scrapling @arguments
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    throw "scrapling exited with code $exitCode"
}

Write-Host "Saved extracted content to $resolvedOutput"
