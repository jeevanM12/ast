@echo off
title Compiler-Based Sentiment & Emotion Analyzer - Team 9
cd /d "%~dp0"
echo ====================================================================
echo   Compiler-Based Sentiment and Emotion Analyzer Using AST (Team 9)
echo   Explainable Rule-Based Sentiment Analysis & ML Integration
echo ====================================================================
echo.

:: Detect Python executable
set PYTHON_CMD=python
if exist "C:\Python312\python.exe" set PYTHON_CMD="C:\Python312\python.exe"

echo [1/3] Starting Python ML FastAPI Backend on http://127.0.0.1:8000...
start "FastAPI ML Backend Service" /B %PYTHON_CMD% -m uvicorn backend.app:app --host 127.0.0.1 --port 8000

echo [2/3] Waiting 2 seconds for backend initialization...
timeout /t 2 /nobreak >nul

echo [3/3] Launching Vite Frontend on http://localhost:3000...
start http://localhost:3000/
npm run dev -- --port 3000
pause
