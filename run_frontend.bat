@echo off
echo ===================================================
echo Starting ReviewIQ AI Frontend (Vite + React)...
echo ===================================================
cd /d "%~dp0frontend"
echo Running npm run dev at http://localhost:3000...
call npm.cmd run dev -- --host 127.0.0.1
pause
