$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $projectRoot

try {
    python .\install.py
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }

    python .\run.py
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}