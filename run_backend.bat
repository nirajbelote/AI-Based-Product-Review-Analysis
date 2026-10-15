@echo off
echo ===================================================
echo Starting ReviewIQ AI Backend Server...
echo ===================================================
set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"

where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python was not found on PATH. Checking default installation...
    if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
        set "PYTHON_EXE=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    ) else (
        echo [ERROR] Python 3.11 is required. Please install Python.
        pause
        exit /b 1
    )
) else (
    set "PYTHON_EXE=python"
)

cd /d "%~dp0"
echo Using Python: %PYTHON_EXE%
echo Starting Uvicorn at http://127.0.0.1:8000 (OpenAPI docs at http://127.0.0.1:8000/docs)
"%PYTHON_EXE%" -m uvicorn app.main:app --app-dir backend --host 127.0.0.1 --port 8000 --reload
pause
