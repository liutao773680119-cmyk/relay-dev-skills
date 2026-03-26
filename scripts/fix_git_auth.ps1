param(
    [string]$RepoPath = '.',
    [string]$GitPath = '',
    [string]$GhPath = ''
)

$ErrorActionPreference = 'Stop'

function Assert-CommandPath {
    param(
        [string]$Label,
        [string]$Path
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "$Label not found: $Path"
    }
}

function Resolve-GitPath {
    param([string]$RequestedPath)

    if ($RequestedPath) {
        return $RequestedPath
    }

    $gitCmd = Get-Command git -ErrorAction SilentlyContinue
    if ($gitCmd -and $gitCmd.Source -and (Test-Path -LiteralPath $gitCmd.Source)) {
        return $gitCmd.Source
    }

    if ($env:CLAUDE_CODE_GIT_BASH_PATH -and (Test-Path -LiteralPath $env:CLAUDE_CODE_GIT_BASH_PATH)) {
        $gitRoot = Split-Path (Split-Path $env:CLAUDE_CODE_GIT_BASH_PATH -Parent) -Parent
        $derived = Join-Path $gitRoot 'cmd\git.exe'
        if (Test-Path -LiteralPath $derived) {
            return $derived
        }
    }

    $fallbacks = @(
        'C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.5.4\resources\app\git\cmd\git.exe'
    )

    foreach ($candidate in $fallbacks) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }

    throw 'git.exe not found. Re-run with -GitPath <full-path-to-git.exe>.'
}

function Resolve-GhPath {
    param([string]$RequestedPath)

    if ($RequestedPath) {
        return $RequestedPath
    }

    $ghCmd = Get-Command gh -ErrorAction SilentlyContinue
    if ($ghCmd -and $ghCmd.Source -and (Test-Path -LiteralPath $ghCmd.Source)) {
        return $ghCmd.Source
    }

    $fallbacks = @(
        'C:\Users\Administrator\AppData\Local\Programs\Python\Python310\Scripts\gh.exe'
    )

    foreach ($candidate in $fallbacks) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }

    throw 'gh.exe not found. Re-run with -GhPath <full-path-to-gh.exe>.'
}

$GitPath = Resolve-GitPath -RequestedPath $GitPath
$GhPath = Resolve-GhPath -RequestedPath $GhPath

Assert-CommandPath -Label 'git.exe' -Path $GitPath
Assert-CommandPath -Label 'gh.exe' -Path $GhPath

$repoRoot = (Resolve-Path $RepoPath).Path
$askPassPath = Join-Path $HOME '.git-askpass.cmd'
$credPath = Join-Path $HOME '.git-credentials'

$askPassBody = @'
@echo off
setlocal
set "PROMPT=%~1"

echo(%PROMPT%| findstr /I "Username" >nul
if %ERRORLEVEL%==0 (
  echo x-access-token
  exit /b 0
)

echo(%PROMPT%| findstr /I "Password" >nul
if %ERRORLEVEL%==0 (
  for /f "delims=" %%I in ('"__GH_PATH__" auth token') do (
    echo %%I
    exit /b 0
  )
)

exit /b 1
'@

$askPassBody = $askPassBody.Replace('__GH_PATH__', $GhPath)
Set-Content -LiteralPath $askPassPath -Value $askPassBody -Encoding ASCII

$token = (& $GhPath auth token).Trim()
if (-not $token) {
    throw 'gh auth token returned an empty token'
}

$credLine = "https://x-access-token:$token@github.com"
Set-Content -LiteralPath $credPath -Value ($credLine + [Environment]::NewLine) -Encoding UTF8

& $GitPath -C $repoRoot config credential.helper ""
& $GitPath -C $repoRoot config --add credential.helper store
& $GitPath -C $repoRoot config core.askPass ($askPassPath -replace '\\', '/')

Write-Host "[ok] repo_root=$repoRoot"
Write-Host "[ok] askpass=$askPassPath"
Write-Host "[ok] credentials=$credPath"
Write-Host "[ok] git_path=$GitPath"
Write-Host "[next] test with: `"$GitPath`" -C `"$repoRoot`" push -u origin main"
