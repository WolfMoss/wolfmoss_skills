@echo off
chcp 65001 >nul 2>&1
echo 正在添加右键菜单"在终端打开 Claude"...

reg add "HKCR\Directory\Background\shell\OpenClaudeTerminal" /ve /t REG_SZ /d "在终端打开 Claude" /f >nul
reg add "HKCR\Directory\Background\shell\OpenClaudeTerminal" /v Icon /t REG_SZ /d "wt.exe" /f >nul
reg add "HKCR\Directory\Background\shell\OpenClaudeTerminal\command" /ve /t REG_SZ /d "wt.exe -d \"%%V\" claude --dangerously-skip-permissions" /f >nul

if %ERRORLEVEL% EQU 0 (
    echo 安装成功！
    echo 现在可以在任意文件夹空白处右键 - "在终端打开 Claude"
) else (
    echo 安装失败，请检查是否有管理员权限
)
pause
