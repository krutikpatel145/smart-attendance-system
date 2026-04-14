@echo off
REM Smart Attendance System - Easy Run Batch Script
echo 🚀 Starting Smart Attendance System...

REM Check Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Python is not installed. Please install Python 3.11+ from https://python.org
    pause
    exit /b 1
)

REM Check Node.js
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)

echo 📦 Setting up backend...
cd backend
if not exist venv (
    python -m venv venv
)
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install -r requirements.txt

echo 🔧 Starting backend server...
start "Backend Server" cmd /k "cd backend && call venv\Scripts\activate.bat && python -m uvicorn main:app --host 127.0.0.1 --port 8000"

cd ..

echo 📦 Setting up frontend...
cd frontend
npm install

echo 🎨 Starting frontend server...
start "Frontend Server" cmd /k "cd frontend && npm run dev -- --host 127.0.0.1 --port 5173"

cd ..

echo ✅ Both servers are starting up!
echo 🌐 Frontend: http://127.0.0.1:5173
echo 🔗 Backend: http://127.0.0.1:8000
echo 📝 Close the command windows to stop the servers

pause