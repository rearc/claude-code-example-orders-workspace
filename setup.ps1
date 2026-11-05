# One-time setup (Windows): clone the repos in repos.txt into repos\ and install every plugin
# that this workspace or the repos turn on, at project scope.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
New-Item -ItemType Directory -Force repos | Out-Null
foreach ($line in Get-Content repos.txt) {
  $name, $url = $line -split '\s+', 2
  if (-not $name) { continue }
  if (-not (Test-Path "repos\$name")) { git clone -q $url "repos\$name" }
  Write-Host "repo:   $name"
}
$mine = (Get-Content .claude\settings.json -Raw | ConvertFrom-Json).enabledPlugins
$dirs = @(Get-Item .) + @(Get-ChildItem repos -Directory)
foreach ($d in $dirs) {
  $s = Join-Path $d.FullName ".claude\settings.json"
  if (-not (Test-Path $s)) { continue }
  $cfg = Get-Content $s -Raw | ConvertFrom-Json
  Push-Location $d.FullName
  if ($cfg.extraKnownMarketplaces) {
    foreach ($m in $cfg.extraKnownMarketplaces.PSObject.Properties) {
      $src = $m.Value.source
      $arg = if ($src.path) { $src.path } elseif ($src.url) { $src.url } else { $src.repo }
      claude plugin marketplace add $arg --scope project *> $null
      Write-Host "market: $($m.Name) for $($d.Name)"
    }
  }
  if ($cfg.enabledPlugins) {
    foreach ($p in $cfg.enabledPlugins.PSObject.Properties) {
      if ($p.Value) {
        claude plugin install $p.Name --scope project *> $null; Write-Host "plugin: $($p.Name) for $($d.Name)"
        if ($d.FullName -ne (Get-Item .).FullName -and -not ($mine -and $mine.($p.Name))) {
          Write-Host "note:   $($d.Name) turns on $($p.Name); this workspace doesn't, so it won't load here"
        }
      }
    }
  }
  Pop-Location
}
Write-Host "Done. VS Code: open orders.code-workspace. CLI: .\start.ps1"
