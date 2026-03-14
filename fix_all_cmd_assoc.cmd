@echo off
chcp 65001 >nul
echo 正在彻底修复.cmd 文件关联...

:: 1. 重置 .cmd 扩展名关联
reg delete "HKCR\.cmd" /f 2>nul
reg add "HKCR\.cmd" /ve /t REG_SZ /d "cmdfile" /f

:: 2. 删除 cmdfile 的 shell 设置（包括 Cmder/ConEmu 的）
reg delete "HKCR\cmdfile\shell" /f 2>nul

:: 3. 重新设置默认的 open 命令
reg add "HKCR\cmdfile\shell\open\command" /ve /t REG_SZ /d "C:\Windows\System32\cmd.exe /c \"%%1\" %%" /f

:: 4. 使用 assoc 和 ftype 命令
assoc .cmd=cmdfile
ftype cmdfile=C:\Windows\System32\cmd.exe /c "%%1" %%*

echo.
echo 修复完成！请关闭所有窗口后双击测试。
pause
