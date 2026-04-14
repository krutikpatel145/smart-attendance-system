@echo off
setlocal
set "ROOT=%~dp0"
cd /d "%ROOT%"

python install.py
if %errorlevel% neq 0 (
    pause
    exit /b %errorlevel%
)

python run.py
if %errorlevel% neq 0 (
    pause
    exit /b %errorlevel%
)