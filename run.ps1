# Smart Attendance System - Easy Run Script
# This script sets up and runs both backend and frontend

Write-Host "🚀 Starting Smart Attendance System..." -ForegroundColor Green

# Check if Python is installed
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Python is not installed. Please install Python 3.11+ from https://python.org" -ForegroundColor Red
    exit 1
}

# Check if Node.js is installed
if (!(Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org" -ForegroundColor Red
    exit 1
}

# Backend setup
Write-Host "📦 Setting up backend..." -ForegroundColor Yellow
cd backend
if (!(Test-Path "venv")) {
    python -m venv venv
}
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt

# Start backend in background
Write-Host "🔧 Starting backend server..." -ForegroundColor Cyan
$backendJob = Start-Job -ScriptBlock {
    cd backend
    .\venv\Scripts\Activate.ps1
    python -m uvicorn main:app --host 127.0.0.1 --port 8000
}

cd ..

# Frontend setup
Write-Host "📦 Setting up frontend..." -ForegroundColor Yellow
cd frontend
npm install

# Start frontend in background
Write-Host "🎨 Starting frontend server..." -ForegroundColor Cyan
$frontendJob = Start-Job -ScriptBlock {
    cd frontend
    npm run dev -- --host 127.0.0.1 --port 5173
}

cd ..

Write-Host "✅ Both servers are starting up!" -ForegroundColor Green
Write-Host "🌐 Frontend: http://127.0.0.1:5173" -ForegroundColor Blue
Write-Host "🔗 Backend: http://127.0.0.1:8000" -ForegroundColor Blue
Write-Host "📝 Press Ctrl+C to stop both servers" -ForegroundColor Yellow

# Wait for jobs
try {
    Wait-Job -Job $backendJob, $frontendJob
} catch {
    Write-Host "🛑 Stopping servers..." -ForegroundColor Red
    Stop-Job -Job $backendJob, $frontendJob
    Remove-Job -Job $backendJob, $frontendJob
}