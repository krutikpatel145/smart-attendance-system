# Smart Attendance System - Easy Run Script
# This script sets up and runs both backend and frontend

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendPath = Join-Path $projectRoot "backend"
$frontendPath = Join-Path $projectRoot "frontend"
$venvPath = Join-Path $backendPath "venv"
$venvPython = Join-Path $venvPath "Scripts\python.exe"

Write-Host "Starting Smart Attendance System..." -ForegroundColor Green

# Check if Python is installed
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python is not installed. Please install Python 3.11+ from https://python.org" -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
if (!(Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js is not installed. Please install Node.js 18+ from https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Backend setup
Write-Host "Setting up backend..." -ForegroundColor Yellow
if (!(Test-Path $venvPath)) {
    python -m venv $venvPath
}
& $venvPython -m pip install --upgrade pip
& $venvPython -m pip install -r (Join-Path $backendPath "requirements.txt")

# Frontend setup
Write-Host "Setting up frontend..." -ForegroundColor Yellow
Push-Location $frontendPath
npm install
Pop-Location

# Start backend in background
Write-Host "Starting backend server..." -ForegroundColor Cyan
$backendJob = Start-Job -ArgumentList $backendPath, $venvPython -ScriptBlock {
    param($backendPathArg, $venvPythonArg)
    Set-Location $backendPathArg
    & $venvPythonArg -m uvicorn main:app --host 127.0.0.1 --port 8000
}

# Start frontend in background
Write-Host "Starting frontend server..." -ForegroundColor Cyan
$frontendJob = Start-Job -ArgumentList $frontendPath -ScriptBlock {
    param($frontendPathArg)
    Set-Location $frontendPathArg
    npm run dev -- --host 127.0.0.1 --port 5173
}

Write-Host "Both servers are starting up!" -ForegroundColor Green
Write-Host "Frontend: https://127.0.0.1:5173" -ForegroundColor Blue
Write-Host "Backend: http://127.0.0.1:8000" -ForegroundColor Blue
Write-Host "Press Ctrl+C to stop both servers" -ForegroundColor Yellow

# Wait for jobs
try {
    Wait-Job -Job $backendJob, $frontendJob
} finally {
    Stop-Job -Job $backendJob, $frontendJob -ErrorAction SilentlyContinue
    Remove-Job -Job $backendJob, $frontendJob -ErrorAction SilentlyContinue
}