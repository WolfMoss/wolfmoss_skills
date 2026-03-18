@echo off
chcp 65001 >nul 2>&1
echo 正在修复 Claude 右键菜单...
echo.

:: 删除旧的注册表项
reg delete "HKCR\Directory\Background\shell\OpenClaude" /f >nul 2>&1
reg delete "HKCR\Directory\Background\shell\OpenClaudeTerminal" /f >nul 2>&1

:: 导入新的注册表项
echo 导入新的注册表配置...
reg import "%~dp0fix_context_menu.reg"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo 修复成功！
    echo 现在可以在任意文件夹空白处右键 - "在终端打开 Claude"
) else (
    echo.
    echo 安装失败，请检查是否有管理员权限
)
pause
