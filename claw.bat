@echo off
setlocal

:: Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"
set "SETTINGS_FILE=%SCRIPT_DIR%settings.json"

:: Check if settings.json exists in the script's directory
if not exist "%SETTINGS_FILE%" (
    echo [Error] settings.json not found in: %SCRIPT_DIR%
    exit /b 1
)

:: Use PowerShell to read the JSON file safely
for /f "usebackq tokens=*" %%A in (`powershell -NoProfile -Command "$j = Get-Content -Raw -LiteralPath '%SETTINGS_FILE%' | ConvertFrom-Json; 'MODEL_NAME='+$j.model; 'OPENAI_BASE_URL='+$j.OPENAI_BASE_URL; 'OPENAI_API_KEY='+$j.OPENAI_API_KEY"`) do (
    set "%%A"
)

:: Check if the extraction was successful
if "%MODEL_NAME%"=="" (
    echo [Error] Could not find a "model" key inside settings.json.
    exit /b 1
)

:: Execute the renamed claw binary from the script's directory
"%SCRIPT_DIR%claw_.exe" --model "%MODEL_NAME%" %*