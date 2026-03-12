@echo off
chcp 65001 >nul 2>&1
echo 正在删除右键菜单"打开 Claude"...

reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\OpenClaude" /f >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo 卸载成功！
) else (
    echo 卸载失败，请检查是否有管理员权限
)
pause
