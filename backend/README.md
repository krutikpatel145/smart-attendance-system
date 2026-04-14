# Backend (FastAPI)

Backend service for Smart Attendance System.

## Run Locally

```powershell
cd backend
python -m pip install -r requirements.txt
python -m uvicorn main:app --host 127.0.0.1 --port 8000
```

## Main Features

- Student enrollment
- Attendance logs and export
- Session switching
- Student CRUD endpoints
- WebSocket attendance stream: `/ws/attendance`

## Important Runtime Files

- `students.json` - local student storage
- `attendance.json` - local attendance storage

These files are runtime-generated and ignored for version control.
