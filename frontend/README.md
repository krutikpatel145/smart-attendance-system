# Frontend (React + Vite + TypeScript)

Frontend client for Smart Attendance System.

## Run Locally

```powershell
cd frontend
npm install
npm run dev -- --host 127.0.0.1 --port 5173
```

Dev URL:
- [https://127.0.0.1:5173/](https://127.0.0.1:5173/)

## Build

```powershell
npm run build
```

## Backend Connectivity

Vite proxy is configured in `vite.config.ts`:
- `/api` -> `http://localhost:8000`
- `/ws` -> `ws://localhost:8000`

Run the backend service on port `8000` for local development.
