@echo off
title System-1 MiniOS Launcher
echo ========================================================
echo   System-1 MiniOS: Autonomous Spatial Desktop Workspace
echo ========================================================
echo Starting Backend (FastAPI on http://127.0.0.1:8000)...
start "MiniOS Backend" cmd /k "cd /d "%~dp0" && set PYTHONPATH=%~dp0 && backend\venv\Scripts\python.exe -m uvicorn backend.app.main:app --host 127.0.0.1 --port 8000 --reload"

timeout /t 3 /nobreak > nul

echo Starting Frontend (Vite on http://localhost:5173)...
start "MiniOS Frontend" cmd /k "cd /d "%~dp0frontend" && node .\node_modules\vite\bin\vite.js"

timeout /t 2 /nobreak > nul

echo Opening browser at http://localhost:5173...
start http://localhost:5173
echo ========================================================
echo Done! Both servers are running.
echo ========================================================
