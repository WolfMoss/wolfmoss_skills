@echo off
chcp 65001 >nul
echo 正在删除 Cmder/ConEmu 的.cmd 关联...

:: 删除所有 cmdfile shell 下的设置
reg delete "HKCR\cmdfile\shell\ConEmu" /f 2>nul
reg delete "HKCR\cmdfile\shell\edit" /f 2>nul

:: 强制重置为 Windows 默认
reg add "HKCR\cmdfile\shell\open\command" /ve /t REG_SZ /d "cmd.exe /c \"%%1\" %%*" /f

:: 确保默认打开方式是 open
reg add "HKCR\cmdfile\shell" /ve /t REG_SZ /d "open" /f

echo.
echo 修复完成！请关闭所有窗口后双击测试。
pause
