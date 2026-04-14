# Backend (FastAPI)

Backend service for Smart Attendance System.

## Run Locally

```powershell
python -m pip install -r ../requirements.txt
cd backend
python -m uvicorn main:app --host 127.0.0.1 --port 8000
```

For the simplest full-project flow, use root scripts:
- `python install.py`
- `python run.py`

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
