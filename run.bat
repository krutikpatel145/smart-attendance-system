@echo off
REM Smart Attendance System - Easy Run Batch Script
setlocal
set "ROOT=%~dp0"
set "BACKEND=%ROOT%backend"
set "FRONTEND=%ROOT%frontend"
set "VENV_PY=%BACKEND%\venv\Scripts\python.exe"

echo Starting Smart Attendance System...

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed. Please install Python 3.11+ from https://python.org
    pause
    exit /b 1
)

REM Check Node.js
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is not installed. Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)

echo Setting up backend...
if not exist "%BACKEND%\venv" (
    python -m venv "%BACKEND%\venv"
)
"%VENV_PY%" -m pip install --upgrade pip
"%VENV_PY%" -m pip install -r "%BACKEND%\requirements.txt"

echo Setting up frontend...
pushd "%FRONTEND%"
npm install
popd

echo Starting backend server...
start "Backend Server" cmd /k "cd /d ""%BACKEND%"" && ""%VENV_PY%"" -m uvicorn main:app --host 127.0.0.1 --port 8000"

echo Starting frontend server...
start "Frontend Server" cmd /k "cd /d ""%FRONTEND%"" && npm run dev -- --host 127.0.0.1 --port 5173"

echo Both servers are starting up!
echo Frontend: https://127.0.0.1:5173
echo Backend: http://127.0.0.1:8000
echo Close the command windows to stop the servers

pause