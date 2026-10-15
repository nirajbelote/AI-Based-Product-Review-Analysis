@echo off
echo ===================================================
echo Running ReviewIQ AI Automated Test Suite...
echo ===================================================
set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"

where python >nul 2>nul
if %errorlevel% neq 0 (
    if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
        set "PYTHON_EXE=%LOCALAPPDATA%\Programs\Python\Python311\python.exe"
    ) else (
        echo [ERROR] Python 3.11 is required.
        pause
        exit /b 1
    )
) else (
    set "PYTHON_EXE=python"
)

cd /d "%~dp0"
"%PYTHON_EXE%" -m pytest backend/tests -v
pause
