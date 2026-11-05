# Start Claude Code in this workspace with every repo in repos.txt added (Windows).
Set-Location $PSScriptRoot
$dirs = foreach ($line in Get-Content repos.txt) { $n = ($line -split '\s+', 2)[0]; if ($n) { "--add-dir"; "repos\$n" } }
claude @dirs @args
