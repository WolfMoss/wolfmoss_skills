@echo off
chcp 65001 >nul
echo 当前.cmd 文件关联设置:
echo.
echo === HKCR\.cmd ===
reg query "HKCR\.cmd" 2>nul
echo.
echo === HKCR\cmdfile\shell ===
reg query "HKCR\cmdfile\shell" 2>nul
echo.
echo === HKCR\cmdfile\shell\open\command ===
reg query "HKCR\cmdfile\shell\open\command" 2>nul
echo.
echo === 用户级别关联 ===
reg query "HKCU\Software\Classes\.cmd" 2>nul
reg query "HKCU\Software\Classes\cmdfile" 2>nul
echo.
pause
