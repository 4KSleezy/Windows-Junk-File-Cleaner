@echo off
:: Run as administrator check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run this script as Administrator.
    pause
    exit /b
)

:: Ask if user has an NVIDIA GPU
set /p nvidiaGPU="Do you have an NVIDIA graphics card? (yes/no): "
if /i "%nvidiaGPU%" neq "yes" (
    echo [31mSkipping NVIDIA cache cleanup.[0m
    goto cleanup
)

:: Delete NVIDIA cache
del /s /q "C:\Users\%USERNAME%\AppData\Local\NVIDIA\DXCache\*.*"

:cleanup
:: Display cleaning message and wait for 3 seconds
echo [31mCleaning up...[0m
timeout /t 3 /nobreak >nul

:: Delete all files in temp folders
del /s /q "C:\Windows\Temp\*.*"
del /s /q "C:\Users\%USERNAME%\AppData\Local\Temp\*.*"
del /s /q "C:\Windows\Prefetch\*.*"

echo [31mTemp files deleted successfully![0m
pause
