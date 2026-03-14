@echo off
echo 正在修复.cmd 文件关联...

:: 重置.cmd 扩展名关联
reg delete "HKCR\.cmd" /f 2>nul
reg add "HKCR\.cmd" /ve /t REG_SZ /d "cmdfile" /f

:: 重置 cmdfile 关联
reg delete "HKCR\cmdfile\shell\open\command" /f 2>nul
reg add "HKCR\cmdfile\shell\open\command" /ve /t REG_SZ /d "\"%%SystemRoot%%\\System32\\cmd.exe\" \"%%1\" %%*" /f

:: 设置 ftype
ftype cmdfile="%%SystemRoot%%\System32\cmd.exe" "%%1" %%*

echo 修复完成！
echo 如果还有问题，请重启资源管理器或注销后重新登录
pause
