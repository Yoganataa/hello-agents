param(
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$Repo = if ($env:HELLO_AGENTS_REPO) { $env:HELLO_AGENTS_REPO } else { "Yoganataa/hello-agents" }
$Branch = if ($env:HELLO_AGENTS_BRANCH) { $env:HELLO_AGENTS_BRANCH } else { "main" }
$BaseUrl = "https://raw.githubusercontent.com/$Repo/$Branch"

$Files = @(
  "AGENTS.md",
  "docs/product.md",
  "docs/ideas.md",
  "docs/decisions.md",
  "docs/architecture.md",
  "docs/naming-and-copy.md",
  "docs/skills.md",
  "docs/stack-notes.md",
  "docs/evals.md"
)

foreach ($Rel in $Files) {
  if ((Test-Path $Rel) -and (-not $Force)) {
    Write-Host "skip: $Rel (already exists; pass -Force to overwrite)"
    continue
  }
  $Dir = Split-Path -Parent $Rel
  if ($Dir -and (-not (Test-Path $Dir))) {
    New-Item -ItemType Directory -Path $Dir -Force | Out-Null
  }
  Invoke-WebRequest -Uri "$BaseUrl/$Rel" -OutFile $Rel -UseBasicParsing
  Write-Host "installed: $Rel"
}

Write-Host ""
Write-Host "Done. Next: fill in AGENTS.md and docs/architecture.md, and install any kits you want from docs/skills.md."
