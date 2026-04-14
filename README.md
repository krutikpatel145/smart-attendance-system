# Smart Attendance System

Smart Attendance System is a full-stack project for webcam-based attendance tracking.
It includes:

- A `FastAPI` backend for enrollment, attendance logs, student management, and websocket frame processing
- A `React + Vite + TypeScript` frontend for UI and camera interaction

## Project Structure

- `backend/` - FastAPI service and face-processing logic
- `frontend/` - React/Vite web app
- `docker-compose.yml` - optional local PostgreSQL + backend stack

## Tech Stack

- Frontend: React, TypeScript, Vite, Tailwind CSS
- Backend: FastAPI, Uvicorn, OpenCV, NumPy
- Optional DB stack: PostgreSQL + pgvector (via Docker Compose)

## Prerequisites

- Python `3.11+`
- Node.js `18+` (current LTS recommended)
- npm

## Quick Start (Recommended)

From the project root, run:

```powershell
python install.py
python run.py
```

Then visit: [https://127.0.0.1:5173](https://127.0.0.1:5173)

This installs dependencies once, then starts both backend and frontend in one terminal.

## Quick Start (Windows one-click scripts)

You can also use:

- `.\run.ps1` (PowerShell)
- `run.bat` (Command Prompt / double-click)

## Manual Setup (Optional)

### 1) Backend

```powershell
python -m pip install -r requirements.txt
cd backend
python -m uvicorn main:app --host 127.0.0.1 --port 8000
```

Backend health:

- [http://127.0.0.1:8000/](http://127.0.0.1:8000/)

### 2) Frontend

Open a second terminal:

```powershell
npm install --prefix frontend
cd frontend
npm run dev -- --host 127.0.0.1 --port 5173
```

Frontend dev URL:

- [https://127.0.0.1:5173/](https://127.0.0.1:5173/)

## API Quick Endpoints

- `GET /` - backend health
- `GET /students` - list students
- `GET /attendance_logs` - list attendance records
- `GET /current_session` - active session name
- `WS /ws/attendance` - realtime attendance stream

## Docker (Optional)

If you want to run the backend + Postgres stack:

```powershell
docker compose up --build
```

## License

This repository is released under the MIT License. See `LICENSE`.
