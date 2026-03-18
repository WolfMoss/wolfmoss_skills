@echo off
echo Installing Claude context menu...
powershell -ExecutionPolicy Bypass -File "%~dp0install_context_menu.ps1"
pause
