param(
    [string]$Targets = "codex,claude,agents",
    [switch]$Force,
    [ValidateSet('skills', 'relay')]
    [string]$Source = 'skills'
)

$ErrorActionPreference = 'Stop'

$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
    Write-Host "[FAIL] python not found in PATH" -ForegroundColor Red
    exit 1
}

$scriptPath = Join-Path $PSScriptRoot 'install_skills.py'
if (-not (Test-Path $scriptPath)) {
    Write-Host "[FAIL] install_skills.py not found: $scriptPath" -ForegroundColor Red
    exit 1
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$argsList = @(
    $scriptPath,
    '--repo-root', $repoRoot.Path,
    '--targets', $Targets,
    '--source', $Source
)
if ($Force) {
    $argsList += '--force'
}

python @argsList
exit $LASTEXITCODE
